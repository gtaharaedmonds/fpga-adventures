module decrypt (
    input logic rst_n,
    input logic clk,

    // Debug signals.
    input  logic [7:0] debug_addr,
    output logic [7:0] anodes_7seg,
    output logic [6:0] cathodes_7seg
);
  logic [7:0] ram_addr, ram_din, ram_dout;
  logic ram_wren;

  logic init_rdy, init_en;
  logic [7:0] init_addr, init_din;
  logic init_wren;

  logic ksa_rdy, ksa_en;
  logic [7:0] ksa_addr, ksa_din;
  logic ksa_wren;

  logic [7:0] debug_data;
  logic [6:0] debug_7segs[8];

  typedef enum logic [3:0] {
    RESET,
    INIT_WAIT,
    INIT_RUNNING,
    KSA_WAIT,
    KSA_RUNNING,
    DONE
  } state_t;

  state_t current_state, next_state;

  // Update state machine.
  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      current_state <= RESET;
    end else begin
      current_state <= next_state;
    end
  end

  // Next-state logic.
  always_comb begin
    next_state = current_state;

    case (current_state)
      RESET:   next_state = INIT_WAIT;
      INIT_WAIT: begin
        if (init_rdy) next_state = INIT_RUNNING;
      end
      INIT_RUNNING: begin
        if (init_rdy) next_state = KSA_WAIT;
      end
      KSA_WAIT: begin
        if (ksa_rdy) next_state = KSA_RUNNING;
      end
      KSA_RUNNING: begin
        if (ksa_rdy) next_state = DONE;
      end
      DONE: begin
        next_state = DONE;
      end
      default: next_state = RESET;
    endcase
  end

  // Combinational control signals.
  always_comb begin
    init_en = 0;
    ksa_en  = 0;

    case (current_state)
      RESET: begin
        // Defaults OK.
      end
      INIT_WAIT: begin
        if (init_rdy) init_en = 1;
      end
      INIT_RUNNING: begin
        // Defaults OK.
      end
      KSA_WAIT: begin
        if (ksa_rdy) ksa_en = 1;
      end
      KSA_RUNNING: begin
        // Defaults OK.
      end
      DONE: begin
        // Defaults OK.
      end
      default: begin
        // Defaults OK.
      end
    endcase
  end

  // If done, RAM is connected to debug signals to inspect memory.
  // Otherwise, connected to init or KSA module depending on current step.
  always_comb begin
    if (current_state == RESET || current_state == INIT_WAIT || current_state == INIT_RUNNING) begin
      ram_addr = init_addr;
      ram_din = init_din;
      ram_wren = init_wren;
      debug_data = 8'hFF;
    end else if (current_state == KSA_WAIT || current_state == KSA_RUNNING) begin
      ram_addr = ksa_addr;
      ram_din = ksa_din;
      ram_wren = ksa_wren;
      debug_data = 8'hFF;
    end else begin
      ram_addr = debug_addr;
      ram_din = 0;
      ram_wren = 0;
      debug_data = ram_dout;
    end
  end

  bram status_ram (
      .*,
      .addr(ram_addr),
      .dout(ram_dout),
      .din (ram_din),
      .en  (1),
      .wren(ram_wren)
  );

  // Step 1: Initialize status RAM.
  init_status init_status_inst (
      .*,
      .rdy(init_rdy),
      .en(init_en),
      .ram_addr(init_addr),
      .ram_dout(ram_dout),
      .ram_din(init_din),
      .ram_wren(init_wren)
  );

  // Step 2: Run KSA.
  ksa ksa_inst (
      .*,
      .rdy(ksa_rdy),
      .en(ksa_en),
      .ram_addr(ksa_addr),
      .ram_dout(ram_dout),
      .ram_din(ksa_din),
      .ram_wren(ksa_wren)
  );

  // Decode MSB.
  hex_7seg debug_data_0 (
      .hex_input  (debug_data[3:0]),
      .hex_decoded(debug_7segs[0])
  );
  // Decode LSB.
  hex_7seg debug_data_1 (
      .hex_input  (debug_data[7:4]),
      .hex_decoded(debug_7segs[1])
  );

  // Turn off all other displays.
  assign debug_7segs[2] = 7'b1111111;
  assign debug_7segs[3] = 7'b1111111;
  assign debug_7segs[4] = 7'b1111111;
  assign debug_7segs[5] = 7'b1111111;
  assign debug_7segs[6] = 7'b1111111;
  assign debug_7segs[7] = 7'b1111111;

  nexys_7segs nexys_7segs_inst (
      .*,
      .inputs_7seg(debug_7segs)
  );

endmodule
