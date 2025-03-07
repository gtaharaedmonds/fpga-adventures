module uart_tx (
    input logic clk,
    input logic rst_n,
    output logic ready,
    input logic start,
    input logic [7:0] data_in,
    output logic data_out
);

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin

    end else begin

    end
  end

endmodule
