module init (
    input logic rst_n,
    input logic clk,

    // Ready/enable microprotocol signals.
    output logic rdy,
    input  logic en,

    // RAM port I/O.
    output logic [7:0] ram_addr,
    input logic [7:0] ram_dout,
    output logic [7:0] ram_din,
    output logic ram_wren
);
  logic [8:0] i;
  logic running;

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      rdy <= 0;
      i <= 0;
      running <= 0;
      ram_wren <= 0;
    end else begin
      if (~running) begin
        rdy <= 1;
      end

      if (~running && en) begin
        rdy <= 0;
        i <= 0;
        running <= 1;
        ram_wren <= 1;
      end

      if (running) begin
        ram_addr <= i;
        ram_din <= i;
        i <= i + 1;

        if (i == 256) begin
          running  <= 0;
          ram_wren <= 0;
        end
      end
    end
  end
endmodule
