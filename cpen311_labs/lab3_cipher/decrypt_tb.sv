`timescale 1 ns / 10 ps

module decrypt_tb;
  logic rst_n, clk;
  logic [7:0] debug_addr;
  logic [7:0] anodes_7seg;
  logic [6:0] cathodes_7seg;

  decrypt dut (.*);

  // Generate clock.
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period (100MHz)

  initial begin
    // Reset DUT.
    rst_n = 0;

    #10;
    rst_n = 1;
    debug_addr = 8'h00;

    // Simulate and see what happens!
    #20000;

    debug_addr = 0;
    #10;

    #50;

    // Stop sim.
    $stop;
  end
endmodule
