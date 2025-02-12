module datapath (
    input logic clk,
    input logic fast_clk,
    input logic rst_n,
    input logic [2:0] deal_player_card,
    input logic [2:0] deal_dealer_card,

    output logic [6:0] game_7segs[8]
);
  logic [3:0] new_card;
  logic [3:0] player_cards[3], dealer_cards[3];

  random_card random_card_inst (
      .fast_clk(fast_clk),
      .rst_n(rst_n),
      .new_card(new_card)
  );

  genvar i;
  generate
    for (i = 0; i < 3; i++) begin
      always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
          dealer_cards[i] <= 3'b0;
          player_cards[i] <= 3'b0;
        end else begin
          if (deal_player_card[i]) player_cards[i] <= new_card;
          if (deal_dealer_card[i]) dealer_cards[i] <= new_card;
        end
      end
    end
  endgenerate

  assign game_7segs[3] = 7'b1111111;
  assign game_7segs[7] = 7'b1111111;

  generate
    for (i = 0; i < 3; i++) begin
      card_7seg player_7seg (
          .card_input  (player_cards[i]),
          .card_decoded(game_7segs[i])
      );

      card_7seg dealer_7seg (
          .card_input  (dealer_cards[i]),
          .card_decoded(game_7segs[i+4])
      );
    end
  endgenerate
endmodule
