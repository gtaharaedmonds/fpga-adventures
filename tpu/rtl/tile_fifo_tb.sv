`timescale 1 ns / 10 ps

module tile_fifo_tb;
  logic rst_n, clk;
  logic push, pop, push_rdy, pop_rdy;
  logic [1:0] count;
  logic [7:0] din[2][2];
  logic [7:0] dout[2][2];
  logic [7:0] dex[2][2];

  tile_fifo #(
      .SIZE (2),
      .DEPTH(3)
  ) uut (
      .*
  );

  // Generate clock.
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period (100MHz)

  initial begin
    // Reset DUT.
    rst_n = 0;
    push  = 0;
    pop   = 0;
    din   = '{'{0, 0}, '{0, 0}};
    dout  = '{'{0, 0}, '{0, 0}};
    #10;
    rst_n = 1;
    #10;

    assert (count == 0 && push_rdy == 1 && pop_rdy == 0)
    else $error("Assert failed!");

    #100;
    assert (count == 0)
    else $error("Assert failed!");

    din  = '{'{8'h11, 8'h12}, '{8'h21, 8'h22}};
    push = 1;
    #10;
    push = 0;
    assert (count == 1 && push_rdy == 1 && pop_rdy == 1)
    else $error("Assert failed!");

    pop = 1;
    #10;
    pop = 0;
    assert (count == 0 && push_rdy == 1 && pop_rdy == 0)
    else $error("Assert failed!");

    dex = '{'{8'h11, 8'h12}, '{8'h21, 8'h22}};
    assert (dout == dex)
    else $error("Assert failed!");

    for (int i = 1; i <= 3; i++) begin
      if (i == 1) din = '{'{8'h11, 8'h12}, '{8'h13, 8'h14}};
      else if (i == 2) din = '{'{8'h21, 8'h22}, '{8'h23, 8'h24}};
      else if (i == 3) din = '{'{8'h31, 8'h32}, '{8'h33, 8'h34}};
      push = 1;
      #10;
      push = 0;
      assert (count == i && push_rdy == (i < 3) && pop_rdy == 1)
      else $error("Assert failed!");
    end

    for (int i = 1; i <= 3; i++) begin
      logic [7:0] dex[2][2];
      pop = 1;
      #10;
      pop = 0;
      assert (count == 3 - i && push_rdy == 1 && pop_rdy == (i < 3))
      else $error("Assert failed!");

      if (i == 1) dex = '{'{8'h11, 8'h12}, '{8'h13, 8'h14}};
      else if (i == 2) dex = '{'{8'h21, 8'h22}, '{8'h23, 8'h24}};
      else if (i == 3) dex = '{'{8'h31, 8'h32}, '{8'h33, 8'h34}};
      assert (dout == dex)
      else $error("Assert failed!");
    end

    #10;
    // Stop sim.
    $stop;
  end
endmodule
