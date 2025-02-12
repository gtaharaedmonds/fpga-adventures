module baccarat (
    input logic clk,
    input logic fast_clk,
    input logic rst_n,
    output logic [7:0] anodes_7seg,
    output logic [6:0] cathodes_7seg,
    output logic cathode_dp
);
  logic [2:0] deal_player_card, deal_dealer_card;
  logic [6:0] game_7segs[8];

  // Disable decimal point.
  assign cathode_dp = 1'b1;

  state_machine state_machine_inst (
      .clk(clk),
      .rst_n(rst_n),
      .deal_player_card(deal_player_card),
      .deal_dealer_card(deal_dealer_card)
  );

  datapath datapath_inst (
      .clk(clk),
      .fast_clk(fast_clk),
      .rst_n(rst_n),
      .deal_player_card(deal_player_card),
      .deal_dealer_card(deal_dealer_card),
      .game_7segs(game_7segs)
  );

  nexys_7segs nexys_7segs_inst (
      .clk(fast_clk),
      .rst_n(rst_n),
      .inputs_7seg(game_7segs),
      .anodes_7seg(anodes_7seg),
      .cathodes_7seg(cathodes_7seg)
  );
endmodule
