module ksa (
    input logic rst_n,
    input logic clk,

    // Ready/enable microprotocol signals.
    output logic rdy,
    input  logic en,

    // RAM port I/O.
    output logic [7:0] ram_addr,
    input logic [7:0] ram_dout,
    output logic [7:0] ram_din,
    output logic ram_wren,

    // Super secret key!
    input logic [7:0] key[KEY_LENGTH]
);
  localparam KEY_LENGTH = 3;

  logic [7:0] i, j;
  logic [7:0] si, sj;

  typedef enum {
    RESET,
    ADDR_SI,
    FETCH_SI,
    COPY_SI,
    UPDATE_J,
    ADDR_SJ,
    FETCH_SJ,
    COPY_SJ,
    STORE_SI,
    STORE_SJ,
    DONE
  } ksa_step_t;

  ksa_step_t current_step, next_step;

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) current_step <= RESET;
    else current_step <= next_step;
  end

  always_comb begin
    // Default to no transition.
    next_step = current_step;

    case (current_step)
      RESET: begin
        if (en) next_step = ADDR_SI;
      end
      ADDR_SI: next_step = FETCH_SI;
      FETCH_SI: next_step = COPY_SI;
      COPY_SI: next_step = UPDATE_J;
      UPDATE_J: next_step = ADDR_SJ;
      ADDR_SJ: next_step = FETCH_SJ;
      FETCH_SJ: next_step = COPY_SJ;
      COPY_SJ: next_step = STORE_SI;
      STORE_SI: next_step = STORE_SJ;
      STORE_SJ: begin
        if (i == 0) next_step = DONE;
        else next_step = ADDR_SI;
      end
      DONE: next_step = RESET;
      default: next_step = RESET;
    endcase
  end

  // Registered outputs. Apparently Vivado wants RAM inputs to be registered so
  // that's why they all are.
  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      i  <= 0;
      j  <= 0;
      si <= 0;
      sj <= 0;
    end else begin
      case (next_step)
        RESET: begin
          i  <= 0;
          j  <= 0;
          si <= 0;
          sj <= 0;
        end
        ADDR_SI: begin
          ram_din  <= 0;
          ram_addr <= i;
          ram_wren <= 0;
        end
        FETCH_SI: begin
          // No-op, just let it fetch. (1-cycle delay)
        end
        COPY_SI: begin
          si <= ram_dout;
        end
        UPDATE_J: begin
          j <= (j + si + key[i%KEY_LENGTH]) % 256;
        end
        ADDR_SJ: begin
          ram_addr <= j;
          ram_wren <= 0;
        end
        FETCH_SJ: begin
          // No-op, just let it fetch. (1-cycle delay)
        end
        COPY_SJ: begin
          sj <= ram_dout;
        end
        STORE_SI: begin
          ram_addr <= j;
          ram_wren <= 1;
          ram_din  <= si;
        end
        STORE_SJ: begin
          ram_addr <= i;
          ram_wren <= 1;
          ram_din <= sj;
          i <= i + 1;
        end
        DONE: begin
          ram_wren <= 0;
        end
        default: begin
          // No-op.
        end
      endcase
    end
  end

  assign rdy = (current_step == RESET);
endmodule
