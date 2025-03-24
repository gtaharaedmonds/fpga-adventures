module mmu #(
    parameter SIZE = 2,
    parameter WEIGHT_FIFO_DEPTH = 3
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
    input logic [31:0] acc_out[SIZE][SIZE],
    output logic acc_out_rdy,
    input logic acc_out_pop,

    // Load new weights into array.
    output logic weight_ld_rdy,
    input  logic weight_ld_start,

    // Run a matrix multiplication.
    output logic mult_rdy,
    input  logic mult_run
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
        else weight_ld_next_state = WEIGHT_LD_IDLE;
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
          mmu_arr_weight_in <= weight_fifo_out[weight_ld_cnt];
          weight_ld_cnt <= weight_ld_cnt + 1;
        end
        default: weight_ld_cnt <= 0;
      endcase
    end
  end

  /*
   * Data FIFO
   */

  // TODO

  /*
   * MMU Systolic Array
   */

  logic mmu_arr_run, mmu_arr_ld_weight, mmu_arr_swap_weights;
  logic [ 7:0] mmu_arr_weight_in[SIZE];
  logic [ 7:0] mmu_arr_data_in  [SIZE];
  logic [31:0] mmu_arr_acc_out  [SIZE];

  mmu_array #(
      .SIZE(SIZE)
  ) mmu_array_unit (
      .clk(clk),
      .rst_n(rst_n),
      .run(mmu_arr_run),
      .load_weight(mmu_arr_ld_weight),
      .swap_weights(mmu_arr_swap_weights),
      .weight_in(mmu_arr_weight_in),
      .data_in(mmu_arr_data_in),
      .acc_out(mmu_arr_acc_out)
  );

endmodule
