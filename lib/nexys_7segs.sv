module nexys_7segs (
    input logic rst_n,
    input logic clk,
    input logic [6:0] inputs_7seg[8],

    output logic [7:0] anodes_7seg,
    output logic [6:0] cathodes_7seg
);
  logic clk_7seg;
  logic [2:0] active_7seg;

  clk_div #(
      .IN_CLKS_PER_HALF_OUT_CLK(50000)  // 100 Hz
  ) clk_div_inst (
      .rst_n  (rst_n),
      .clk_in (clk),
      .clk_out(clk_7seg)
  );

  genvar i;
  generate
    assign anodes_7seg[i] = (active_7seg == i) ? 1'b0 : 1'b1;
  endgenerate

  assign cathodes_7seg = inputs_7seg[active_7seg];

  always_ff @(posedge clk_7seg or negedge rst_n) begin
    if (~rst_n) begin
      active_7seg <= 3'd0;
    end else begin
      if (active_7seg == 3'd7) active_7seg <= 3'd0;
      else active_7seg <= active_7seg + 1;
    end
  end
endmodule
