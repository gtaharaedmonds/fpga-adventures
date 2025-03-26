`timescale 1 ns / 10 ps

module mmu_tb;
  localparam SIZE = 2;

  logic rst_n, clk;

  logic new_weight_rdy, new_weight_push;
  logic [7:0] new_weight_in[SIZE][SIZE];

  logic data_in_rdy, data_in_push;
  logic [7:0] data_in[SIZE][SIZE];

  logic acc_out_rdy, acc_out_pop;
  logic [31:0] acc_out[SIZE][SIZE];
  logic [31:0] out_expected[SIZE][SIZE];

  logic weight_ld_rdy, weight_ld_start, weight_ld_done, weight_swap;
  logic mult_rdy, mult_start, mult_done;

  mmu uut (.*);

  // Generate clock.
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period (100MHz)

  initial begin
    new_weight_rdy = 0;
    new_weight_push = 0;
    data_in_rdy = 0;
    data_in_push = 0;
    acc_out_rdy = 0;
    acc_out_pop = 0;
    weight_ld_rdy = 0;
    weight_ld_start = 0;
    weight_swap = 0;
    mult_rdy = 0;
    mult_start = 0;

    // Reset DUT.
    rst_n = 0;
    #10;
    rst_n = 1;
    #10;

    // Push new weights into the FIFO.
    assert (new_weight_rdy)
    else $error("Assert failed!");
    new_weight_in   = '{'{8'h1, 8'h2}, '{8'h3, 8'h4}};
    new_weight_push = 1;
    #10;
    new_weight_push = 0;
    #10;

    // Load weights from FIFO to array.
    assert (weight_ld_rdy)
    else $error("Assert failed!");
    weight_ld_start = 1;
    #10;
    weight_ld_start = 0;
    wait (weight_ld_done == 1);
    #10;

    // Swap weights.
    weight_swap = 1;
    #10;
    weight_swap = 0;
    #10;

    // Push new data into the data FIFO.
    assert (data_in_rdy)
    else $error("Assert failed!");
    data_in = '{'{8'h5, 8'h6}, '{8'h7, 8'h8}};
    data_in_push = 1;
    #10;
    data_in_push = 0;
    #10;

    // Run matrix multiplication!
    assert (mult_rdy && !mult_done)
    else $error("Assert failed!");
    mult_start = 1;
    #10;
    mult_start = 0;
    wait (mult_done == 1);
    #10;

    // Pop output off FIFO.
    assert (acc_out_rdy)
    else $error("Assert failed!");
    acc_out_pop = 1;
    #10;
    acc_out_pop = 0;
    #10;

    out_expected = '{'{8'h13, 8'h16}, '{8'h2B, 8'h32}};
    assert (acc_out == out_expected)
    else $error("Assert failed!");

    // Stop sim.
    $stop;
  end
endmodule
