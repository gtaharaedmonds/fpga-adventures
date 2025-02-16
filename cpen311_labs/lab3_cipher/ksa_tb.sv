`timescale 1 ns / 10 ps

module ksa_tb;
  logic rst_n, clk;
  logic rdy, en;
  logic [7:0] ram_addr, ram_dout, ram_din;
  logic ram_wren;

  ksa dut (
      .key({8'h00, 8'h03, 8'h3C}),
      .*
  );
  bram s_ram (
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

  initial begin
    // Reset DUT.
    rst_n = 0;
    #10;
    rst_n = 1;

    // Fill expected memory contents.
    for (int i = 0; i < 256; i++) begin
      ram_addr = i;
      ram_din  = i;
      ram_wren = 1;
      #10;
    end

    wait (rdy == 1);
    en = 1;
    wait (rdy == 0);
    en = 0;

    // Simulate and see what happens!
    wait (rdy == 1);
    #10;

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
