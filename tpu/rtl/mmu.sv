module mmu #(
    parameter SIZE = 2,
    parameter WEIGHT_FIFO_DEPTH = 3,
    parameter DATA_FIFO_DEPTH = 3
) (
    input logic rst_n,
    input logic clk,

    // Push a new weight into the weight FIFO.
    input logic [7:0] new_weight_in[SIZE][SIZE],
    output logic new_weight_rdy,
    input logic new_weight_push,

    // Push new activations into the data FIFO.
    input logic [7:0] data_in[SIZE][SIZE],
    output logic data_in_rdy,
    input logic data_in_push,

    // Pop new results off the result FIFO.
    output logic [31:0] acc_out[SIZE][SIZE],
    output logic acc_out_rdy,
    input logic acc_out_pop,

    // Load new weights into array.
    output logic weight_ld_rdy,
    input  logic weight_ld_start,
    input  logic weight_swap,

    // Run a matrix multiplication.
    output logic mult_rdy,
    input  logic mult_run
);

  /*
   * MMU Systolic Array
   */

  logic mmu_arr_run, mmu_arr_ld_weight;
  logic [7:0] mmu_arr_weight_in[SIZE];
  logic [7:0] mmu_arr_din[SIZE];
  logic [31:0] mmu_arr_acc_out[SIZE];

  mmu_array #(
      .SIZE(SIZE)
  ) mmu_array_unit (
      .clk(clk),
      .rst_n(rst_n),
      .run(mmu_arr_run),
      .load_weight(mmu_arr_ld_weight),
      .swap_weights(weight_swap),
      .weight_in(mmu_arr_weight_in),
      .data_in(mmu_arr_din),
      .acc_out(mmu_arr_acc_out)
  );

  /*
   * Weight FIFO
   */

  typedef enum logic [2:0] {
    WEIGHT_LD_IDLE,
    WEIGHT_LD_POP_1,
    WEIGHT_LD_POP_2,
    WEIGHT_LD_SHIFT
  } weight_ld_state_t;

  logic weight_fifo_pop, weight_fifo_pop_rdy;
  logic [7:0] weight_fifo_out[SIZE][SIZE];

  weight_ld_state_t weight_ld_cur_state, weight_ld_next_state;
  logic [$clog2(SIZE):0] weight_ld_cnt;

  assign weight_ld_rdy = weight_fifo_pop_rdy && weight_ld_cur_state == WEIGHT_LD_IDLE;

  tile_fifo #(
      .SIZE (SIZE),
      .DEPTH(WEIGHT_FIFO_DEPTH)
  ) weight_fifo_unit (
      .rst_n(rst_n),
      .clk(clk),
      .push(new_weight_push),
      .push_rdy(new_weight_rdy),
      .pop(weight_fifo_pop),
      .pop_rdy(weight_fifo_pop_rdy),
      .din(new_weight_in),
      .dout(weight_fifo_out),
      .count()
  );

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) weight_ld_cur_state <= WEIGHT_LD_IDLE;
    else weight_ld_cur_state <= weight_ld_next_state;
  end

  always_comb begin
    case (weight_ld_cur_state)
      WEIGHT_LD_IDLE: begin
        if (weight_ld_rdy && weight_ld_start) weight_ld_next_state = WEIGHT_LD_POP_1;
        else weight_ld_next_state = weight_ld_cur_state;
      end
      WEIGHT_LD_POP_1: weight_ld_next_state = WEIGHT_LD_POP_2;
      WEIGHT_LD_POP_2: weight_ld_next_state = WEIGHT_LD_SHIFT;
      WEIGHT_LD_SHIFT: begin
        if (weight_ld_cnt == SIZE) weight_ld_next_state = WEIGHT_LD_IDLE;
        else weight_ld_next_state = WEIGHT_LD_SHIFT;
      end
      default: weight_ld_next_state = WEIGHT_LD_IDLE;
    endcase
  end

  always_comb begin
    case (weight_ld_cur_state)
      WEIGHT_LD_POP_1: begin
        weight_fifo_pop   = 1;
        mmu_arr_ld_weight = 0;
      end
      WEIGHT_LD_SHIFT: begin
        weight_fifo_pop   = 0;
        mmu_arr_ld_weight = 1;
      end
      default: begin
        weight_fifo_pop   = 0;
        mmu_arr_ld_weight = 0;
      end
    endcase
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      weight_ld_cnt <= 0;
    end else begin
      case (weight_ld_next_state)
        WEIGHT_LD_SHIFT: begin
          weight_ld_cnt <= weight_ld_cnt + 1;
        end
        default: weight_ld_cnt <= 0;
      endcase
    end
  end

  genvar row;
  for (row = 0; row < SIZE; row++) begin
    always_ff @(posedge clk or negedge rst_n) begin
      if (~rst_n) begin
      end else begin
        case (weight_ld_next_state)
          WEIGHT_LD_SHIFT: begin
            // X-reverse the weight matrix before sending it in.
            // Also, transpose it.
            mmu_arr_weight_in[row] <= weight_fifo_out[SIZE-weight_ld_cnt-1][row];
          end
          default: begin

          end
        endcase
      end
    end
  end

  /*
   * Data FIFO
   */

  typedef enum logic [2:0] {
    MMU_STATE_IDLE,
    MMU_STATE_DATA_POP_1,
    MMU_STATE_DATA_POP_2,
    MMU_STATE_RUN
  } mmu_state_t;

  mmu_state_t cur_state, next_state;
  logic data_fifo_pop;
  logic [7:0] data_fifo_out[SIZE][SIZE];
  logic [31:0] mult_count;

  tile_fifo #(
      .SIZE (SIZE),
      .DEPTH(DATA_FIFO_DEPTH)
  ) data_fifo_unit (
      .rst_n(rst_n),
      .clk(clk),
      .push(data_in_push),
      .push_rdy(data_in_rdy),
      .pop(data_fifo_pop),
      .pop_rdy(mult_rdy),
      .din(data_in),
      .dout(data_fifo_out),
      .count()
  );

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) cur_state <= MMU_STATE_IDLE;
    else cur_state <= next_state;
  end

  always_comb begin
    case (cur_state)
      MMU_STATE_IDLE: begin
        if (mult_rdy && mult_run) next_state = MMU_STATE_DATA_POP_1;
        else next_state = cur_state;
      end
      MMU_STATE_DATA_POP_1: next_state = MMU_STATE_DATA_POP_2;
      MMU_STATE_DATA_POP_2: next_state = MMU_STATE_RUN;
      MMU_STATE_RUN: begin
        if (mult_count > (2 * SIZE)) next_state = MMU_STATE_IDLE;
        else next_state = cur_state;
      end
      default: begin
        next_state = MMU_STATE_IDLE;
      end
    endcase
  end

  always_comb begin
    case (cur_state)
      MMU_STATE_DATA_POP_1: begin
        data_fifo_pop = 1;
        mmu_arr_run   = 0;
      end
      MMU_STATE_RUN: begin
        data_fifo_pop = 0;
        mmu_arr_run   = 1;
      end
      default: begin
        data_fifo_pop = 0;
        mmu_arr_run   = 0;
      end
    endcase
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      mult_count <= 0;
    end else begin
      case (next_state)
        MMU_STATE_RUN: begin
          mult_count <= mult_count + 1;
        end
        default: begin
          mult_count <= 0;
        end
      endcase
    end
  end

  // Create triangular wavefront of data to shift into the systolic array.
  generate
    for (row = 0; row < SIZE; row++) begin
      always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
          mmu_arr_din[row] <= 0;
        end else begin
          case (next_state)
            MMU_STATE_RUN:
            if ((mult_count < row) || ((mult_count - row) >= SIZE)) mmu_arr_din[row] <= 0;
            else mmu_arr_din[row] <= data_fifo_out[row][mult_count-row];
            default: mmu_arr_din[row] <= 0;
          endcase
        end
      end
    end
  endgenerate

  // Drain triangular wavefront of accumulated results.
  genvar col;
  generate
    for (col = 0; col < SIZE; col++) begin
      always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
          // for (row = 0; row < SIZE; row++) begin
          //   acc_out[row][col] <= 0;
          // end
        end else if (cur_state == MMU_STATE_RUN) begin
          if (mult_count >= SIZE + col + 1) begin
            acc_out[col][mult_count-SIZE-col-1] <= mmu_arr_acc_out[col];
          end
        end
      end
    end
  endgenerate

endmodule
