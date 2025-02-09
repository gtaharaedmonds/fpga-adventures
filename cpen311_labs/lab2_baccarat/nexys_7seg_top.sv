module nexys_7seg_top (
    input logic [6:0] sw,
    input logic cpu_nrst,
    input logic sys_clk,
    output logic [7:0] anodes_7seg,
    output logic [6:0] cathodes_7seg
);

  logic clk_7seg;
  logic [6:0] inputs_7seg[8];

  clock_div #(
      .IN_CLKS_PER_HALF_OUT_CLK(50000)  // 100 Hz
  ) clock_div_inst (
      .rst(~cpu_nrst),
      .clk_in(sys_clk),
      .clk_out(clk_7seg)
  );

  genvar i;
  generate
    for (i = 0; i < 8; i++) begin
      if (i % 2 == 0) begin
        assign inputs_7seg[i] = sw;
      end else begin
        assign inputs_7seg[i] = ~sw;
      end
    end
  endgenerate

  nexys_7seg nexys_7seg_inst (
      .rst(~cpu_nrst),
      .clk(clk_7seg),
      .inputs_7seg(inputs_7seg),
      .anodes(anodes_7seg),
      .cathodes(cathodes_7seg)
  );

endmodule
