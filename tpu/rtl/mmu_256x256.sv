module mmu_256x256 (
    input logic rst_n,
    input logic clk,

    // Push a new weight into the weight FIFO.
    input logic [7:0] new_weight_in[SIZE][SIZE],
    output logic new_weight_rdy,
    input logic new_weight_push,

    // Push new activations into the data FIFO.
    input logic [7:0] data_in[SIZE][SIZE],
    output logic data_in_rdy,
    input logic data_in_push,

    // Pop new results off the result FIFO.
    output logic [31:0] acc_out[SIZE][SIZE],
    output logic acc_out_rdy,
    input logic acc_out_pop,

    // Load new weights into array.
    output logic weight_ld_rdy,
    input  logic weight_ld_start,
    output logic weight_ld_done,
    input  logic weight_swap,

    // Run a matrix multiplication.
    output logic mult_rdy,
    input  logic mult_start,
    output logic mult_done
);

  mmu #(
      .SIZE(256),
      .WEIGHT_FIFO_DEPTH(8),
      .DATA_FIFO_DEPTH(8),
      .OUT_FIFO_DEPTH(8)
  ) mmu_unit (
      .*
  );

endmodule
