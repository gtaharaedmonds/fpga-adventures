`timescale 1 ns / 10 ps

module decrypt_tb;
  logic rst_n, clk, dut_clk;
  logic rdy, en;
  logic [7:0] s_addr, s_dout, s_din;
  logic s_wren;
  logic [7:0] ct_addr, ct_dout, ct_din;
  logic ct_wren;
  logic [7:0] pt_addr, pt_dout, pt_din;
  logic pt_wren;
  logic [7:0] debug_addr, debug_data;
  logic init_done, decrypt_done;

  decrypt dut (
      .clk(dut_clk),
      .*
  );
  bram s_ram (
      .*,
      .addr(s_addr),
      .dout(s_dout),
      .din (s_din),
      .en  (1),
      .wren(s_wren)
  );
  ct_rom ct_rom (
      .*,
      .addr(ct_addr),
      .dout(ct_dout),
      .din (ct_din),
      .en  (1),
      .wren(ct_wren)
  );
  bram pt_ram (
      .*,
      .addr(pt_addr),
      .dout(pt_dout),
      .din (pt_din),
      .en  (1),
      .wren(pt_wren)
  );

  logic [7:0] pt_data[256];
  initial begin
    $readmemh("../../../../project_1.srcs/sources_1/imports/lab3_cipher/pt.data", pt_data);
  end

  // Generate clock.
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period (100MHz)

  // Generate DUT clock. Follows the master clock while enabled.
  // (Hacky way to disable DUT)
  always_comb begin
    if (~init_done || decrypt_done) dut_clk = 0;
    else dut_clk = clk;
  end

  initial begin
    // Reset DUT.
    decrypt_done = 0;
    init_done = 0;
    rst_n = 0;
    #10;

    init_done = 1;
    #20;

    // Release reset.
    rst_n = 1;

    // Run until it's in the done state.
    wait (dut.current_state == 7);
    decrypt_done = 1;

    // Assert that memory has expected values.
    for (int i = 0; i <= 8'h49; i++) begin
      pt_addr = i;
      pt_wren = 0;
      #20;

      assert (pt_dout == pt_data[i])
      else
        $error(
            "Character decoded wrong: i = %h, pt_dout = %h, expected = %h", i, pt_dout, pt_data[i]
        );
    end

    // Stop sim.
    $stop;
  end
endmodule
