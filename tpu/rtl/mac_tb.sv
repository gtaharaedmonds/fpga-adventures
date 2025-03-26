`timescale 1 ns / 10 ps

module mac_tb;
  logic rst_n, clk;
  logic load_weight, swap_weights, run;
  logic [7:0] weight_in, weight_out, data_in, data_out;
  logic [31:0] acc_in, acc_out;

  mac uut (.*);

  // Generate clock.
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period (100MHz)

  initial begin
    load_weight = 0;
    swap_weights = 0;
    weight_in = 0;
    data_in = 0;
    acc_in = 0;

    // Reset DUT.
    rst_n = 0;
    #10;
    rst_n = 1;
    #10;

    // Load new weight.
    weight_in = 8'd57;
    load_weight = 1;
    swap_weights = 1;
    #10;
    load_weight  = 0;
    swap_weights = 0;
    #10;

    // Do a multiply-accumulate.
    data_in = 8'd94;
    run = 1;
    #10;

    assert (acc_out == 32'd5358)
    else $error("Assert failed!");
    assert (data_out == 8'd94)
    else $error("Assert failed!");
    assert (weight_out == 8'd57)
    else $error("Assert failed!");

    run = 0;
    #10;

    // Stop sim.
    $stop;
  end
endmodule
