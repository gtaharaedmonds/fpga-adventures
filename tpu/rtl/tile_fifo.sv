module tile_fifo #(
    parameter BITS  = 8,
    parameter SIZE  = 2,
    parameter DEPTH = 3
) (
    input logic rst_n,
    input logic clk,

    // Control signals.
    input  logic push,
    output logic push_rdy,
    input  logic pop,
    output logic pop_rdy,

    // Data input.
    input logic [BITS-1:0] din[SIZE][SIZE],

    // Data output.
    output logic [BITS-1:0] dout[SIZE][SIZE],
    output logic [$clog2(DEPTH + 1) - 1:0] count
);
  logic [$clog2(DEPTH + 1) - 1:0] head, tail, count_pad;
  logic [BITS-1:0] fifo_buf[DEPTH + 1][SIZE][SIZE];
  logic full, empty;

  assign full = (tail + 1 == head);
  assign empty = tail == head;

  assign push_rdy = ~full;
  assign pop_rdy = ~empty;

  assign count = (tail >= head) ? (tail - head) : (DEPTH - head + tail + 1);

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      tail <= 0;
    end else begin
      if (~full && push) begin
        fifo_buf[tail] <= din;
        tail <= tail + 1;
      end
    end
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      head <= 0;
    end else begin
      if (~empty && pop) begin
        dout <= fifo_buf[head];
        head <= head + 1;
      end
    end
  end

endmodule
