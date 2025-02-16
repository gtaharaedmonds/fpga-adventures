module decrypt_top (
    input logic rst_n,
    input logic clk,

    // Debug signals.
    input  logic [7:0] debug_addr,
    output logic [7:0] anodes_7seg,
    output logic [6:0] cathodes_7seg
);
  logic [7:0] s_addr, s_din, s_dout;
  logic s_wren;

  logic [7:0] ct_addr, ct_din, ct_dout;
  logic ct_wren;

  logic [7:0] pt_addr, pt_din, pt_dout;
  logic pt_wren;

  logic [7:0] debug_data;
  logic [6:0] debug_7segs[8];

  decrypt decrypt_inst (.*);

  // RAM for ARC4 status.
  bram s_ram (
      .*,
      .addr(s_addr),
      .dout(s_dout),
      .din (s_din),
      .en  (1),
      .wren(s_wren)
  );

  // RAM for cipher text (encoded message).
  bram ct_ram (
      .*,
      .addr(ct_addr),
      .dout(ct_dout),
      .din (ct_din),
      .en  (1),
      .wren(ct_wren)
  );

  // RAM for plain text (decoded message).
  bram pt_ram (
      .*,
      .addr(pt_addr),
      .dout(pt_dout),
      .din (pt_din),
      .en  (1),
      .wren(pt_wren)
  );

  // Decode MSB.
  hex_7seg debug_data_0 (
      .hex_input  (debug_data[3:0]),
      .hex_decoded(debug_7segs[0])
  );
  // Decode LSB.
  hex_7seg debug_data_1 (
      .hex_input  (debug_data[7:4]),
      .hex_decoded(debug_7segs[1])
  );

  // Turn off all other displays.
  assign debug_7segs[2] = 7'b1111111;
  assign debug_7segs[3] = 7'b1111111;
  assign debug_7segs[4] = 7'b1111111;
  assign debug_7segs[5] = 7'b1111111;
  assign debug_7segs[6] = 7'b1111111;
  assign debug_7segs[7] = 7'b1111111;

  nexys_7segs nexys_7segs_inst (
      .*,
      .inputs_7seg(debug_7segs)
  );

endmodule
