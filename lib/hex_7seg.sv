module hex_7seg (
    input  logic [3:0] hex_input,
    output logic [6:0] hex_decoded
);
  localparam logic [6:0] DECODED_0 = 7'b1000000;
  localparam logic [6:0] DECODED_1 = 7'b0001000;
  localparam logic [6:0] DECODED_2 = 7'b0100100;
  localparam logic [6:0] DECODED_3 = 7'b0110000;
  localparam logic [6:0] DECODED_4 = 7'b0011001;
  localparam logic [6:0] DECODED_5 = 7'b0010010;
  localparam logic [6:0] DECODED_6 = 7'b0000010;
  localparam logic [6:0] DECODED_7 = 7'b1111000;
  localparam logic [6:0] DECODED_8 = 7'b0000000;
  localparam logic [6:0] DECODED_9 = 7'b0010000;
  localparam logic [6:0] DECODED_A = 7'b0001000;
  localparam logic [6:0] DECODED_B = 7'b0000011;
  localparam logic [6:0] DECODED_C = 7'b1000110;
  localparam logic [6:0] DECODED_D = 7'b0100001;
  localparam logic [6:0] DECODED_E = 7'b0000110;
  localparam logic [6:0] DECODED_F = 7'b0001110;

  always_comb begin
    case (hex_input)
      4'h0: hex_decoded = DECODED_0;
      4'h1: hex_decoded = DECODED_1;
      4'h2: hex_decoded = DECODED_2;
      4'h3: hex_decoded = DECODED_3;
      4'h4: hex_decoded = DECODED_4;
      4'h5: hex_decoded = DECODED_5;
      4'h6: hex_decoded = DECODED_6;
      4'h7: hex_decoded = DECODED_7;
      4'h8: hex_decoded = DECODED_8;
      4'h9: hex_decoded = DECODED_9;
      4'hA: hex_decoded = DECODED_A;
      4'hB: hex_decoded = DECODED_B;
      4'hC: hex_decoded = DECODED_C;
      4'hD: hex_decoded = DECODED_D;
      4'hE: hex_decoded = DECODED_E;
      4'hF: hex_decoded = DECODED_F;
      default: hex_decoded = DECODED_0;
    endcase
  end
endmodule
