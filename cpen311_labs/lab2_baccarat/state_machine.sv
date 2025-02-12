module state_machine (
    input logic clk,
    input logic rst_n,

    // Output control signals to the datapath.
    output logic [2:0] deal_player_card,
    output logic [2:0] deal_dealer_card
);

  typedef enum logic [7:0] {
    GAME_START,
    DEAL_PLAYER_1,
    DEAL_DEALER_1,
    DEAL_PLAYER_2,
    DEAL_DEALER_2,
    DEAL_PLAYER_3,
    DEAL_DEALER_3,
    GAME_END
  } state_t;

  state_t current_state, next_state;

  // Current state register.
  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      current_state <= GAME_START;
    end else begin
      current_state <= next_state;
    end
  end

  // Next-state combinational logic.
  always_comb begin
    case (current_state)
      GAME_START: next_state = DEAL_PLAYER_1;
      DEAL_PLAYER_1: next_state = DEAL_DEALER_1;
      DEAL_DEALER_1: next_state = DEAL_PLAYER_2;
      DEAL_PLAYER_2: next_state = DEAL_DEALER_2;
      DEAL_DEALER_2: next_state = DEAL_PLAYER_3;
      DEAL_PLAYER_3: next_state = DEAL_DEALER_3;
      DEAL_DEALER_3: next_state = GAME_END;
      GAME_END: next_state = GAME_END;
      default: next_state = GAME_START;
    endcase
  end

  // Drive control signals based on state -> The inputs to the datapath!
  always_comb begin
    case (current_state)
      DEAL_PLAYER_1: begin
        deal_player_card = 3'b001;
        deal_dealer_card = 3'b000;
      end
      DEAL_DEALER_1: begin
        deal_player_card = 3'b000;
        deal_dealer_card = 3'b001;
      end
      DEAL_PLAYER_2: begin
        deal_player_card = 3'b010;
        deal_dealer_card = 3'b000;
      end
      DEAL_DEALER_2: begin
        deal_player_card = 3'b000;
        deal_dealer_card = 3'b010;
      end
      DEAL_PLAYER_3: begin
        deal_player_card = 3'b100;
        deal_dealer_card = 3'b000;
      end
      DEAL_DEALER_3: begin
        deal_player_card = 3'b000;
        deal_dealer_card = 3'b100;
      end
      default: begin
        // Game start, end, default all do nothing.
        deal_player_card = 3'b000;
        deal_dealer_card = 3'b000;
      end
    endcase
  end

endmodule
