module mmu_array #(
    parameter SIZE = 2
) (
    input logic clk,
    input logic rst_n,

    input logic run,
    input logic load_weight,
    input logic swap_weights,

    input  logic [ 7:0] weight_in[SIZE],  // Weight inputs
    input  logic [ 7:0] data_in  [SIZE],  // Activation inputs
    output logic [31:0] acc_out  [SIZE]   // Accumulated outputs
);
  logic [7:0] mac_weight_out[SIZE][SIZE];
  logic [7:0] mac_data_out[SIZE][SIZE];
  logic [31:0] mac_acc_out[SIZE][SIZE];

  genvar row;
  genvar col;

  generate
    for (row = 0; row < SIZE; row++) begin
      for (col = 0; col < SIZE; col++) begin
        mac mac_unit (
            .clk(clk),
            .rst_n(rst_n),
            .run(run),
            .load_weight(load_weight),
            .swap_weights(swap_weights),
            .weight_in(col == 0 ? weight_in[row] : mac_weight_out[row][col-1]),
            .weight_out(mac_weight_out[row][col]),
            .data_in(col == 0 ? data_in[row] : mac_data_out[row][col-1]),
            .data_out(mac_data_out[row][col]),
            .acc_in(row == 0 ? 0 : mac_acc_out[row-1][col]),
            .acc_out(mac_acc_out[row][col])
        );
      end
    end
  endgenerate

  generate
    for (col = 0; col < SIZE; col++) begin
      assign acc_out[col] = mac_acc_out[SIZE-1][col];
    end
  endgenerate


endmodule
