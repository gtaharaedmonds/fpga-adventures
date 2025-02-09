module nexys_7seg (
    input logic rst,
    input logic clk,
    input logic [6:0] inputs_7seg[8],

    output logic [7:0] anodes,
    output logic [6:0] cathodes
);
  logic [2:0] active_7seg;

  genvar i;
  generate
    for (i = 0; i < 8; i++) begin
      always_ff @(posedge clk) begin
        if (active_7seg == i) anodes[i] <= 1'b0;
        else anodes[i] <= 1'b1;
      end
    end
  endgenerate

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      cathodes <= 7'b1111111;
      active_7seg <= 3'd0;
    end else begin
      cathodes <= inputs_7seg[active_7seg];

      if (active_7seg == 3'd7) active_7seg <= 3'd0;
      else active_7seg <= active_7seg + 1;
    end
  end

endmodule
