module decrypt (
    input logic rst_n,
    input logic clk,

    // RAM I/O.
    output logic [7:0] ram_addr,
    output logic [7:0] ram_din,
    input logic [7:0] ram_dout,
    output logic ram_wren,

    // Debug signals.
    input  logic [7:0] debug_addr,
    output logic [7:0] debug_data
);
  logic init_rdy, init_en;
  logic [7:0] init_addr, init_din;
  logic init_wren;

  logic ksa_rdy, ksa_en;
  logic [7:0] ksa_addr, ksa_din;
  logic ksa_wren;

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


  // Step 1: Initialize status RAM.
  init init_inst (
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

endmodule
