module mac #(
    parameter DATA_WIDTH = 8,
    parameter ACC_WIDTH  = 32
) (
    input logic clk,
    input logic rst_n,

    input  logic [DATA_WIDTH-1:0] data_in,   // Activation data input
    output logic [DATA_WIDTH-1:0] data_out,  // Activation data output
    input  logic [ ACC_WIDTH-1:0] acc_in,    // Accumulation input
    output logic [ ACC_WIDTH-1:0] acc_out,   // Accumulation output

    input mac_pkg::mac_ctrl_t ctrl  // Control signal
);
  import mac_pkg::*;

  logic [DATA_WIDTH-1:0] weight;

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      data_out <= 0;
      acc_out  <= 0;
      weight   <= 0;
    end else if (ctrl == MAC_CTRL_CLR) begin
      data_out <= 0;
      acc_out  <= 0;
    end else if (ctrl == MAC_CTRL_RUN) begin
      acc_out  <= weight * data_in + acc_in;
      data_out <= data_in;
    end else if (ctrl == MAC_CTRL_LOAD_WEIGHT) begin
      weight   <= data_in;
      data_out <= data_in;
    end
  end
endmodule
