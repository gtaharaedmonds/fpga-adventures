module mac (
    input logic rst_n,
    input logic clk,

    // Control.
    input logic run,

    // Weight control.
    input logic [7:0] weight_in,
    output logic [7:0] weight_out,
    input logic load_weight,
    input logic swap_weights,

    // Data pathway.
    input  logic [7:0] data_in,
    output logic [7:0] data_out,

    // Sum pathway.
    input  logic [31:0] acc_in,
    output logic [31:0] acc_out
);

  logic [7:0] weight_buf[2];
  logic active_weight;

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      weight_buf[0] <= 0;
      weight_buf[1] <= 0;
    end else if (load_weight) begin
      weight_buf[~active_weight] <= weight_in;
      weight_out <= weight_in;
    end
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      active_weight <= 1;
    end else if (swap_weights) begin
      active_weight <= ~active_weight;
    end
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      acc_out  <= 0;
      data_out <= 0;
    end else if (run) begin
      acc_out  <= weight_buf[active_weight] * data_in + acc_in;
      data_out <= data_in;
    end
  end

endmodule
