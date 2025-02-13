module state_machine (
    input logic clk,
    input logic rst_n,

    // External inputs to the state machine.
    input logic [3:0] player_score,
    input logic [3:0] dealer_score,
    input logic [3:0] player_card_3,

    // Output control signals to the datapath.
    output logic [2:0] deal_player_card,
    output logic [2:0] deal_dealer_card,

    // Outputs that just depend on the current state.
    output logic player_win,
    output logic dealer_win
);

  typedef enum logic [7:0] {
    START_GAME,
    DEAL_PLAYER_1,
    DEAL_DEALER_1,
    DEAL_PLAYER_2,
    DEAL_DEALER_2,
    DEAL_PLAYER_3,
    DEAL_DEALER_3,
    SCORE_GAME
  } state_t;

  state_t current_state, next_state;

  logic player_gets_3;

  // Current state register.
  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      current_state <= START_GAME;
    end else begin
      current_state <= next_state;
    end
  end

  // Next-state combinational logic.
  always_comb begin
    case (current_state)
      START_GAME: next_state = DEAL_PLAYER_1;
      DEAL_PLAYER_1: next_state = DEAL_DEALER_1;
      DEAL_DEALER_1: next_state = DEAL_PLAYER_2;
      DEAL_PLAYER_2: next_state = DEAL_DEALER_2;
      DEAL_DEALER_2: begin
        // Be careful with "unique if": If the conditionals aren't mutually exclusive,
        // then you need nested MUX2s to handle priorities. However, if you just
        // write "unique if", I think it'll infer a single MUX (no priorities) and
        // you'll get buggy behavior from your if block!
        // (By priorities I mean checking the first conditional first, then the
        // second if the first is false, then the next, etc.)
        if (player_score == 4'd9 || player_score == 4'd8) begin
          // Natural! No more cards.
          next_state = SCORE_GAME;
        end else if (player_score <= 5) begin
          // Player gets a third card.
          next_state = DEAL_PLAYER_3;
        end else if (dealer_score <= 5) begin
          // Player doesn't get a third card, but dealer does.
          next_state = DEAL_DEALER_3;
        end else begin
          // No more cards, game over.
          next_state = SCORE_GAME;
        end
      end
      DEAL_PLAYER_3: begin
        if ((dealer_score == 4'd6 && (player_card_3 >= 4'd6 && player_card_3 <= 4'd7)) ||
            (dealer_score == 4'd5 && (player_card_3 >= 4'd4 && player_card_3 <= 4'd7)) ||
            (dealer_score == 4'd4 && (player_card_3 >= 4'd2 && player_card_3 <= 4'd7)) ||
            (dealer_score == 4'd3 && (player_card_3 != 4'd8)) ||
            (dealer_score <= 4'd2)
        ) begin
          // Dealer also gets a third card.
          next_state = DEAL_DEALER_3;
        end else begin
          // No more cards, game over.
          next_state = SCORE_GAME;
        end
      end
      DEAL_DEALER_3: next_state = SCORE_GAME;
      SCORE_GAME: next_state = SCORE_GAME;
      default: next_state = START_GAME;
    endcase
  end

  // Drive control signals based on state -> The inputs to the datapath!
  always_comb begin
    // Default outputs to zero: These will get overriden by specific states.
    // Note that since we set defaults these don't infer a latch, even though
    // the assignments in the case statement aren't exhaustive.
    player_win = 1'b0;
    dealer_win = 1'b0;
    deal_player_card = 3'b000;
    deal_dealer_card = 3'b000;

    // Set control signals based on the next state, so everything gets updated
    // in the datapath in sync with state transitions.
    // (If you instead case'ed on the current state, there'd be a 1-cycle delay
    // before the datapath gets updated!)
    case (next_state)
      DEAL_PLAYER_1: begin
        deal_player_card = 3'b001;
      end
      DEAL_DEALER_1: begin
        deal_dealer_card = 3'b001;
      end
      DEAL_PLAYER_2: begin
        deal_player_card = 3'b010;
      end
      DEAL_DEALER_2: begin
        deal_dealer_card = 3'b010;
      end
      DEAL_PLAYER_3: begin
        deal_player_card = 3'b100;
      end
      DEAL_DEALER_3: begin
        deal_dealer_card = 3'b100;
      end
      SCORE_GAME: begin
        player_win = (player_score >= dealer_score);
        dealer_win = (dealer_score >= player_score);
      end
      default: begin
        player_win = 1'b0;
        dealer_win = 1'b0;
        deal_player_card = 3'b000;
        deal_dealer_card = 3'b000;
      end
    endcase
  end
endmodule
