module card_7seg (
    input  logic [3:0] card_input,
    output logic [6:0] card_decoded
);
  localparam logic [3:0] INPUT_BLANK = 4'd0;
  localparam logic [3:0] INPUT_ACE = 4'd1;
  localparam logic [3:0] INPUT_2 = 4'd2;
  localparam logic [3:0] INPUT_3 = 4'd3;
  localparam logic [3:0] INPUT_4 = 4'd4;
  localparam logic [3:0] INPUT_5 = 4'd5;
  localparam logic [3:0] INPUT_6 = 4'd6;
  localparam logic [3:0] INPUT_7 = 4'd7;
  localparam logic [3:0] INPUT_8 = 4'd8;
  localparam logic [3:0] INPUT_9 = 4'd9;
  localparam logic [3:0] INPUT_10 = 4'd10;
  localparam logic [3:0] INPUT_JACK = 4'd11;
  localparam logic [3:0] INPUT_QUEEN = 4'd12;
  localparam logic [3:0] INPUT_KING = 4'd13;

  localparam logic [6:0] DECODED_BLANK = 7'b1111111;
  localparam logic [6:0] DECODED_ACE = 7'b0001000;
  localparam logic [6:0] DECODED_2 = 7'b0100100;
  localparam logic [6:0] DECODED_3 = 7'b0110000;
  localparam logic [6:0] DECODED_4 = 7'b0011001;
  localparam logic [6:0] DECODED_5 = 7'b0010010;
  localparam logic [6:0] DECODED_6 = 7'b0000010;
  localparam logic [6:0] DECODED_7 = 7'b1111000;
  localparam logic [6:0] DECODED_8 = 7'b0000000;
  localparam logic [6:0] DECODED_9 = 7'b0011000;
  localparam logic [6:0] DECODED_10 = 7'b1000000;
  localparam logic [6:0] DECODED_JACK = 7'b1110001;
  localparam logic [6:0] DECODED_QUEEN = 7'b0011000;
  localparam logic [6:0] DECODED_KING = 7'b0001001;

  always_comb begin
    case (card_input)
      INPUT_BLANK: card_decoded = DECODED_BLANK;
      INPUT_ACE: card_decoded = DECODED_ACE;
      INPUT_2: card_decoded = DECODED_2;
      INPUT_3: card_decoded = DECODED_3;
      INPUT_4: card_decoded = DECODED_4;
      INPUT_5: card_decoded = DECODED_5;
      INPUT_6: card_decoded = DECODED_6;
      INPUT_7: card_decoded = DECODED_7;
      INPUT_8: card_decoded = DECODED_8;
      INPUT_9: card_decoded = DECODED_9;
      INPUT_10: card_decoded = DECODED_10;
      INPUT_JACK: card_decoded = DECODED_JACK;
      INPUT_QUEEN: card_decoded = DECODED_QUEEN;
      INPUT_KING: card_decoded = DECODED_KING;
      default: card_decoded = DECODED_BLANK;
    endcase
  end
endmodule
