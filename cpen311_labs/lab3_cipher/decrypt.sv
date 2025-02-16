module decrypt (
    input logic rst_n,
    input logic clk,

    // Status RAM I/O.
    output logic [7:0] s_addr,
    output logic [7:0] s_din,
    input logic [7:0] s_dout,
    output logic s_wren,

    // Cipher text RAM I/O.
    output logic [7:0] ct_addr,
    output logic [7:0] ct_din,
    input logic [7:0] ct_dout,
    output logic ct_wren,

    // Plain text RAM I/O.
    output logic [7:0] pt_addr,
    output logic [7:0] pt_din,
    input logic [7:0] pt_dout,
    output logic pt_wren,

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

  logic prga_rdy, prga_en;
  logic [7:0] prga_addr, prga_din;
  logic prga_wren;

  typedef enum logic [3:0] {
    RESET,
    INIT_WAIT,
    INIT_RUNNING,
    KSA_WAIT,
    KSA_RUNNING,
    PRGA_WAIT,
    PRGA_RUNNING,
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
      RESET: next_state = INIT_WAIT;
      INIT_WAIT: if (init_rdy) next_state = INIT_RUNNING;
      INIT_RUNNING: if (init_rdy) next_state = KSA_WAIT;
      KSA_WAIT: if (ksa_rdy) next_state = KSA_RUNNING;
      KSA_RUNNING: if (ksa_rdy) next_state = PRGA_WAIT;
      PRGA_WAIT: if (prga_rdy) next_state = PRGA_RUNNING;
      PRGA_RUNNING: if (prga_rdy) next_state = DONE;
      DONE: next_state = DONE;
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
      PRGA_WAIT: begin
        if (prga_rdy) prga_en = 1;
      end
      PRGA_RUNNING: begin
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
  // Otherwise, connected to the current step's module.
  always_comb begin
    if (current_state == RESET || current_state == INIT_WAIT || current_state == INIT_RUNNING) begin
      s_addr = init_addr;
      s_din = init_din;
      s_wren = init_wren;
      debug_data = 8'hFF;
    end else if (current_state == KSA_WAIT || current_state == KSA_RUNNING) begin
      s_addr = ksa_addr;
      s_din = ksa_din;
      s_wren = ksa_wren;
      debug_data = 8'hFF;
    end else if (current_state == PRGA_WAIT || current_state == PRGA_RUNNING) begin
      s_addr = prga_addr;
      s_din = prga_din;
      s_wren = prga_wren;
      debug_data = 8'hFF;
    end else begin
      s_addr = debug_addr;
      s_din = 0;
      s_wren = 0;
      debug_data = s_dout;
    end
  end

  // Step 1: Initialize status RAM.
  init init_inst (
      .*,
      .rdy(init_rdy),
      .en(init_en),
      .ram_addr(init_addr),
      .ram_dout(s_dout),
      .ram_din(init_din),
      .ram_wren(init_wren)
  );

  // Step 2: Run KSA.
  ksa ksa_inst (
      .*,
      .rdy(ksa_rdy),
      .en(ksa_en),
      .ram_addr(ksa_addr),
      .ram_dout(s_dout),
      .ram_din(ksa_din),
      .ram_wren(ksa_wren)
  );

  // Step 3: Run pseudo-random generation algorithm (actually does the decoding!)
  prga prga_inst (
      .*,
      .rdy(prga_rdy),
      .en(prga_en),
      .s_addr(prga_addr),
      .s_dout(s_dout),
      .s_din(prga_din),
      .s_wren(prga_wren)
  );

endmodule
