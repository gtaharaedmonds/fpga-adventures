module score_hand (
    logic [3:0] cards[3],
    logic [3:0] score
);

  logic [3:0] card_values[3];
  logic [4:0] score_subtotal;

  genvar i;
  generate
    for (i = 0; i < 3; i++) begin
      assign card_values[i] = cards[i] > 4'd9 ? 4'd0 : cards[i];
    end
  endgenerate

  assign score_subtotal = (card_values[0] + card_values[1] + card_values[2]) % 5'd10;
  assign score = score_subtotal[3:0];

endmodule
