module vga (
    input logic nrst,
    input logic clk,
    output logic [3:0] red,
    green,
    blue,
    output logic hsync,
    vsync
);

  localparam HSYNC_CNT = 96;
  localparam H_BACK_PORCH_CNT = 48;
  localparam H_VIDEO_CNT = 640;
  localparam H_FRONT_PORCH_CNT = 16;
  localparam H_TOTAL_CNT = HSYNC_CNT + H_BACK_PORCH_CNT + H_VIDEO_CNT + H_FRONT_PORCH_CNT;

  localparam VSYNC_CNT = 2;
  localparam V_BACK_PORCH_CNT = 33;
  localparam V_FRONT_PORCH_CNT = 10;
  localparam V_VIDEO_CNT = 480;
  localparam V_TOTAL_CNT = VSYNC_CNT + V_BACK_PORCH_CNT + V_VIDEO_CNT + V_FRONT_PORCH_CNT;

  logic [9:0] hcnt, vcnt;
  logic is_video_h, is_video_v, is_video;

  assign is_video_h = (hcnt >= HSYNC_CNT + H_BACK_PORCH_CNT) &&
                      (hcnt < HSYNC_CNT + H_BACK_PORCH_CNT + H_VIDEO_CNT + H_FRONT_PORCH_CNT);

  assign is_video_v = (vcnt >= VSYNC_CNT + V_BACK_PORCH_CNT) &&
                      (vcnt < VSYNC_CNT + V_BACK_PORCH_CNT + V_VIDEO_CNT + V_FRONT_PORCH_CNT);

  assign is_video = is_video_h && is_video_v;

  always_ff @(posedge clk or negedge nrst) begin
    if (~nrst) begin
      hcnt <= 10'b0;
      vcnt <= 10'b0;
    end else begin
      if (hcnt < HSYNC_CNT) hsync <= 1'b1;
      else vsync <= 1'b0;

      if (vcnt < VSYNC_CNT) vsync <= 1'b1;
      else vsync <= 1'b0;

      if (is_video) begin
        // All red, for now!
        red   <= 4'hF;
        green <= 4'h0;
        blue  <= 4'h0;
      end else begin
        red   <= 4'h0;
        green <= 4'h0;
        blue  <= 4'h0;
      end

      if (hcnt == H_TOTAL_CNT - 1) begin
        hcnt <= 10'b0;

        if (vcnt == V_TOTAL_CNT - 1) begin
          vcnt <= 10'b0;
        end else begin
          vcnt <= vcnt + 1;
        end
      end else begin
        hcnt <= hcnt + 1;
      end
    end
  end

endmodule
