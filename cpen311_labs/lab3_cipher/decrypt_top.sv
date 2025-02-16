module decrypt_top (
    input logic rst_n,
    input logic clk,

    // Debug signals.
    input  logic [7:0] debug_addr,
    output logic [7:0] anodes_7seg,
    output logic [6:0] cathodes_7seg
);
  logic [7:0] ram_addr, ram_din, ram_dout;
  logic ram_wren;

  logic [7:0] debug_data;
  logic [6:0] debug_7segs[8];

  decrypt decrypt_inst (.*);

  bram status_ram (
      .*,
      .addr(ram_addr),
      .dout(ram_dout),
      .din (ram_din),
      .en  (1),
      .wren(ram_wren)
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
