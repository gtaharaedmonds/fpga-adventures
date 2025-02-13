module baccarat (
    input logic clk,
    input logic fast_clk,
    input logic rst_n,
    output logic [7:0] anodes_7seg,
    output logic [6:0] cathodes_7seg,
    output logic cathode_dp,
    output logic player_win,
    output logic dealer_win
);
  logic [3:0] player_score, dealer_score;
  logic [3:0] player_cards[3], dealer_cards[3];

  logic [2:0] deal_player_card, deal_dealer_card;
  logic [6:0] game_7segs[8];

  // Disable decimal point.
  assign cathode_dp = 1'b1;

  state_machine state_machine_inst (
      .player_card_3(player_cards[2]),
      .*
  );

  datapath datapath_inst (.*);

  nexys_7segs nexys_7segs_inst (
      .clk(fast_clk),
      .inputs_7seg(game_7segs),
      .*
  );
endmodule
