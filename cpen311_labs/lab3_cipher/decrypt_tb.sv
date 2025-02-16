`timescale 1 ns / 10 ps

module decrypt_tb;
  logic rst_n, clk;
  logic [7:0] debug_data, debug_addr;
  decrypt dut (
      .*,
      .key({8'h1E, 8'h46, 8'h00})
  );

  logic [7:0] pt_data[256];
  initial begin
    $readmemh("../../../../project_1.srcs/sources_1/imports/lab3_cipher/pt.data", pt_data);
  end

  // Generate clock.
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period (100MHz)

  initial begin
    // Reset DUT.
    debug_addr = 0;
    rst_n = 0;
    #10;

    // Release reset.
    rst_n = 1;

    // Run until it's in the done state.
    wait (dut.current_state == 7);
    #15;

    // Assert that memory has expected values.
    for (int i = 0; i <= 8'h49; i++) begin
      debug_addr = i;
      #20;

      assert (debug_data == pt_data[i])
      else
        $error(
            "Character decoded wrong: i = %h, debug_data = %h, expected = %h",
            i,
            debug_data,
            pt_data[i]
        );
    end

    // Stop sim.
    $stop;
  end
endmodule
