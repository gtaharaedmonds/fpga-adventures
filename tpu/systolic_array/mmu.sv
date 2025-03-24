module mmu #(
    parameter SIZE = 2,
    parameter DATA_WIDTH = 8,
    parameter ACC_WIDTH = 32
) (
    input logic clk,
    input logic rst_n,

    input  logic [DATA_WIDTH-1:0] data_in[SIZE],  // Activation inputs
    output logic [ ACC_WIDTH-1:0] acc_out[SIZE],  // Accumulated outputs

    input mac_pkg::mac_ctrl_t ctrl  // Control signal
);
  logic [DATA_WIDTH-1:0] mac_data_out[SIZE][SIZE];
  logic [ ACC_WIDTH-1:0] mac_acc_out [SIZE][SIZE];

  genvar row;
  genvar col;

  generate
    for (row = 0; row < SIZE; row++) begin
      for (col = 0; col < SIZE; col++) begin
        mac mac_unit (
            .clk(clk),
            .rst_n(rst_n),
            .data_in(col == 0 ? data_in[row] : mac_data_out[row][col-1]),
            .data_out(mac_data_out[row][col]),
            .acc_in(row == 0 ? 0 : mac_acc_out[row-1][col]),
            .acc_out(mac_acc_out[row][col]),
            .ctrl(ctrl)
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
