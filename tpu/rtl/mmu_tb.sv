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

  logic weight_ld_rdy, weight_ld_start;
  logic mult_rdy, mult_run;

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
    mult_rdy = 0;
    mult_run = 0;

    // Reset DUT.
    rst_n = 0;
    #10;
    rst_n = 1;
    #10;

    // Push new weights into the FIFO.
    assert (new_weight_rdy)
    else $error("Assert failed!");
    new_weight_in   = '{'{8'h11, 8'h12}, '{8'h21, 8'h22}};
    new_weight_push = 1;
    #10;
    new_weight_push = 0;
    #50;

    // Load weights from FIFO to array.
    assert (weight_ld_rdy)
    else $error("Assert failed!");
    weight_ld_start = 1;
    #10;
    weight_ld_start = 0;
    #100;

    // Stop sim.
    $stop;
  end
endmodule
