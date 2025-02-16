`timescale 1 ns / 10 ps

module decrypt_tb;
  logic rst_n, clk, dut_clk;
  logic rdy, en;
  logic [7:0] ram_addr, ram_dout, ram_din;
  logic ram_wren;
  logic [7:0] debug_addr, debug_data;
  logic ksa_done;

  decrypt dut (
      .clk(dut_clk),
      .*
  );
  bram status_ram (
      .*,
      .addr(ram_addr),
      .dout(ram_dout),
      .din (ram_din),
      .en  (1),
      .wren(ram_wren)
  );

  logic [7:0] expected[256];
  initial
    $readmemh(
        "../../../../project_1.srcs/sources_1/imports/lab3_cipher/ksa_expected.data", expected
    );

  // Generate clock.
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period (100MHz)

  // Generate DUT clock. Follows the master clock while enabled.
  // (Hacky way to disable DUT)
  always_comb begin
    if (ksa_done) dut_clk = 0;
    else dut_clk = clk;
  end

  initial begin
    // Reset DUT.
    ksa_done = 0;
    rst_n = 0;
    #10;
    rst_n = 1;

    // Run until it's in the done state.
    wait (dut.current_state == 5);
    ksa_done = 1;

    // Assert that memory has expected values.
    for (int i = 0; i < 256; i++) begin
      ram_addr = i;
      ram_wren = 0;
      #10;

      assert (ram_dout == expected[i])
      else $error("BAD! ram_dout = %h, i = %h", ram_dout, expected[i]);
    end

    // Stop sim.
    $stop;
  end
endmodule
