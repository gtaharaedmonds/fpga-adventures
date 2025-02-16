module prga (
    input logic rst_n,
    input logic clk,

    // Ready/enable microprotocol signals.
    output logic rdy,
    input  logic en,

    // Status RAM I/O.
    output logic [7:0] s_addr,
    input logic [7:0] s_dout,
    output logic [7:0] s_din,
    output logic s_wren,

    // Cipher text RAM I/O.
    output logic [7:0] ct_addr,
    input logic [7:0] ct_dout,
    output logic [7:0] ct_din,
    output logic ct_wren,

    // Plain text RAM I/O.
    output logic [7:0] pt_addr,
    input logic [7:0] pt_dout,
    output logic [7:0] pt_din,
    output logic pt_wren
);

  typedef enum {
    RESET,

    // Read out the length from CT[0].
    ADDR_LENGTH,
    FETCH_LENGTH,
    COPY_LENGTH,

    // Update i.
    UPDATE_I,

    // Fetch s[i].
    ADDR_SI,
    FETCH_SI,
    COPY_SI,

    // Update j.
    UPDATE_J,

    // Fetch s[j].
    ADDR_SJ,
    FETCH_SJ,
    COPY_SJ,

    // Swap s[i] and s[j].
    STORE_SI,
    STORE_SJ,

    // Fetch the pad value.
    ADDR_PAD,
    FETCH_PAD,
    COPY_PAD,

    // Fetch next cipher text character.
    ADDR_CT,
    FETCH_CT,

    // Write decoded plain text character.
    STORE_PT,

    // Done!
    DONE
  } prga_step_t;

  prga_step_t current_step, next_step;

  logic [7:0] i, j, k, len, si, sj, pad;

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) current_step <= RESET;
    else current_step <= next_step;
  end

  always_comb begin
    case (current_step)
      RESET:
      if (en) next_step = ADDR_LENGTH;
      else next_step = RESET;
      // Default case is just move to the next step.
      STORE_PT:
      if (k == len) next_step = DONE;
      else next_step = UPDATE_I;
      DONE: next_step = RESET;
      default: next_step = prga_step_t'(current_step + 1);
    endcase
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      i <= 0;
      j <= 0;
      k <= 0;

      len <= 0;
      si <= 0;
      sj <= 0;
      pad <= 0;

      ct_addr <= 0;
      ct_wren <= 0;
      ct_din <= 0;

      pt_addr <= 0;
      pt_wren <= 0;
      pt_din <= 0;

      s_addr <= 0;
      s_wren <= 0;
      s_din <= 0;

    end else begin
      case (next_step)
        RESET: begin
          i <= 0;
          j <= 0;
          k <= 0;
        end
        ADDR_LENGTH: begin
          ct_addr <= 0;
          ct_wren <= 0;
        end
        FETCH_LENGTH: begin
          // No-op - RAM has 1-cycle read delay.
        end
        COPY_LENGTH: begin
          len <= ct_dout;

          // Write length to start of plain text.
          pt_addr <= 0;
          pt_wren <= 1;
          pt_din <= ct_dout;
        end
        UPDATE_I: begin
          i <= (i + 1) % 256;

          // Disable write from previous state.
          pt_wren <= 0;
        end
        ADDR_SI: begin
          s_wren <= 0;
          s_addr <= i;
        end
        FETCH_SI: begin
          // No-op - RAM has 1-cycle read delay.
        end
        COPY_SI: begin
          si <= s_dout;
        end
        UPDATE_J: begin
          j <= (j + si) % 256;
        end
        ADDR_SJ: begin
          s_wren <= 0;
          s_addr <= j;
        end
        FETCH_SJ: begin
          // No-op - RAM has 1-cycle read delay.
        end
        COPY_SJ: begin
          sj <= s_dout;
        end
        STORE_SI: begin
          s_wren <= 1;
          s_addr <= j;
          s_din  <= si;
        end
        STORE_SJ: begin
          s_wren <= 1;
          s_addr <= i;
          s_din  <= sj;
        end
        ADDR_PAD: begin
          s_wren <= 0;
          s_addr <= (si + sj) % 256;
        end
        FETCH_PAD: begin
          // No-op - RAM has 1-cycle read delay.
        end
        COPY_PAD: begin
          pad <= s_dout;
        end
        ADDR_CT: begin
          // First char is length, so have to add 1.
          ct_addr <= k + 1;
          ct_wren <= 0;
        end
        FETCH_CT: begin
          // No-op - RAM has 1-cycle read delay.
        end
        STORE_PT: begin
          // First char is length, so have to add 1.
          pt_addr <= k + 1;
          pt_din <= pad ^ ct_dout;
          pt_wren <= 1;

          k <= k + 1;
        end
        DONE: begin
          pt_wren <= 0;
        end
        default: begin
          // No-op.
        end
      endcase
    end
  end

  assign rdy = (current_step == RESET);
endmodule
