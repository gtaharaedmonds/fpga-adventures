module vga_top (
    input logic CLK100MHZ,
    input logic CPU_RESETN,
    output logic [3:0] VGA_R,
    VGA_G,
    VGA_B,
    output logic VGA_HS,
    VGA_VS
);
  // Need to define system clock (which is 100MHz) by 4 to get a pixel clock of
  // 25MHz. This is close to enough to the 25.175MHz used by VGA.

  logic clk_div_2, clk_div_4;

  always_ff @(posedge CLK100MHZ or negedge CPU_RESETN) begin
    if (~CPU_RESETN) begin
      clk_div_2 <= 1'b0;
    end else begin
      clk_div_2 <= ~clk_div_2;
    end
  end

  always_ff @(posedge clk_div_2 or negedge CPU_RESETN) begin
    if (~CPU_RESETN) begin
      clk_div_4 <= 1'b0;
    end else begin
      clk_div_4 <= ~clk_div_4;
    end
  end

  vga vga_unit (
      .nrst (CPU_RESETN),
      .clk  (clk_div_4),
      .red  (VGA_R),
      .green(VGA_G),
      .blue (VGA_B),
      .hsync(VGA_HS),
      .vsync(VGA_VS)
  );

endmodule
