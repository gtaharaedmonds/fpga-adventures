module axi_if #(
    parameter integer S_AXI_DATA_WIDTH = 32,
    parameter integer S_AXI_ADDR_WIDTH = 4
) (
    // Global signals.
    input wire s_axi_aclk,
    input wire s_axi_aresetn,

    // Write address channel.
    input wire [S_AXI_ADDR_WIDTH-1:0] s_axi_awaddr,
    input wire [2:0] s_axi_awprot,
    input wire s_axi_awvalid,
    output wire s_axi_awready,

    // Write data channel.
    input wire [S_AXI_DATA_WIDTH-1:0] s_axi_wdata,
    input wire [(S_AXI_DATA_WIDTH/8)-1:0] s_axi_wstrb,
    input wire s_axi_wvalid,
    output wire s_axi_wready,

    // Write response channel.
    output wire [1:0] s_axi_bresp,
    output wire s_axi_bvalid,
    input wire s_axi_bready,

    // Read address channel.
    input wire [S_AXI_ADDR_WIDTH-1:0] s_axi_araddr,
    input wire [2:0] s_axi_arprot,
    input wire s_axi_arvalid,
    output wire s_axi_arready,

    // Read data/response channel.
    output wire [S_AXI_DATA_WIDTH-1:0] s_axi_rdata,
    output wire [1:0] s_axi_rresp,
    output wire s_axi_rvalid,
    input wire s_axi_rready
);

  reg [S_AXI_DATA_WIDTH-1:0] regval;

  /*
   * Write interface.
   */

  localparam WR_INIT = 2'b00, WR_ADDR = 2'b01, WR_DATA = 2'b10, WR_STORE = 2'b11;
  reg [2:0] wr_state;

  reg [S_AXI_ADDR_WIDTH-1:0] waddr;
  reg [S_AXI_DATA_WIDTH-1:0] wdata;
  reg [(S_AXI_DATA_WIDTH/8)-1:0] wstrb;
  reg wready, awready, bvalid;

  assign s_axi_awready = awready;
  assign s_axi_wready  = wready;
  assign s_axi_bvalid  = bvalid;
  assign s_axi_bresp   = 2'b00;  // Writes always succeed

  always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if (~s_axi_aresetn) begin
      regval <= 0;
      waddr <= 0;
      wdata <= 0;
      wstrb <= 0;
      wready <= 0;
      awready <= 0;
      bvalid <= 0;
      wr_state <= WR_INIT;
    end else begin
      case (wr_state)
        WR_INIT: begin
          awready  <= 1;
          wready   <= 1;
          wr_state <= WR_ADDR;
        end
        WR_ADDR: begin
          if (s_axi_awvalid) begin
            if (s_axi_wvalid) begin
              // Got addr and data, jump to store.
              waddr <= s_axi_awaddr;
              awready <= 0;
              wdata <= s_axi_wdata;
              wready <= 0;
              bvalid <= 1;
              wr_state <= WR_STORE;
            end else begin
              // Got addr but waiting for data, jump to data.
              waddr <= s_axi_awaddr;
              awready <= 0;
              wr_state <= WR_DATA;
            end
          end
        end
        WR_DATA: begin
          if (s_axi_wvalid) begin
            // Got data, jump to store.
            wdata <= s_axi_wdata;
            wstrb <= s_axi_wstrb;
            wready <= 0;
            bvalid <= 1;
            wr_state <= WR_STORE;
          end
        end
        WR_STORE: begin
          regval   <= wdata;
          awready  <= 1;
          wready   <= 1;
          bvalid   <= 0;
          wr_state <= WR_ADDR;
        end
        default: begin
          // Impossible, just to satisfy linter.
        end
      endcase
    end
  end

  /*
   * Read interface.
   */

  localparam RD_INIT = 2'b00, RD_ADDR = 2'b01, RD_FETCH = 2'b10, RD_DATA = 2'b11;
  reg [2:0] rd_state;

  reg [S_AXI_ADDR_WIDTH-1:0] rd_addr;
  reg rvalid, arready;
  reg [S_AXI_DATA_WIDTH-1:0] rdata;

  assign s_axi_arready = arready;
  assign s_axi_rvalid  = rvalid;
  assign s_axi_rdata   = rdata;
  assign s_axi_rresp   = 0;

  always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if (~s_axi_aresetn) begin
      arready <= 0;
      rdata <= 0;
      rvalid <= 0;
      rd_state <= RD_INIT;
    end else begin
      case (rd_state)
        RD_INIT: begin
          arready  <= 1;
          rd_state <= RD_ADDR;
        end
        RD_ADDR: begin
          if (s_axi_arvalid) begin
            rd_addr  <= s_axi_araddr;
            arready  <= 0;
            rd_state <= RD_FETCH;
          end
        end
        RD_FETCH: begin
          rdata <= regval;
          rvalid <= 1;
          rd_state <= RD_DATA;
        end
        RD_DATA: begin
          if (s_axi_rready) begin
            rdata <= 0;
            rvalid <= 0;
            arready <= 1;
            rd_state <= RD_ADDR;
          end
        end
        default: begin
          // Impossible, just to satisfy linter.
        end
      endcase
    end
  end

endmodule
