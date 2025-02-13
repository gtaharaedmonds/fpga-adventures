module clk_div #(
    parameter IN_CLKS_PER_HALF_OUT_CLK
) (
    input  logic rst_n,
    input  logic clk_in,
    output logic clk_out
);

  logic [$clog2(IN_CLKS_PER_HALF_OUT_CLK):0] counter;

  always_ff @(posedge clk_in or negedge rst_n) begin
    if (~rst_n) begin
      counter <= 0;
      clk_out <= 0;
    end else begin
      if (counter == IN_CLKS_PER_HALF_OUT_CLK - 1) begin
        counter <= 0;
        clk_out <= ~clk_out;
      end else begin
        counter <= counter + 1;
      end
    end
  end

endmodule
