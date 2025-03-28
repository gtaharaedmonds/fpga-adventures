// MEMORY MAP
//
// Status register (0x00) (read only)
//
// XEDCBA
//
// - A: new_weight_rdy
// - B: data_in_rdy
// - C: acc_out_rdy
// - D: weight_ld_rdy
// - E: mult_rdy
// - F: mult_done
// - X: unused
//
// Control register (0x04) (write only)
//
// XFEDCBA
//
// - A: new_weight_push
// - B: data_in_push
// - C: acc_out_pop
// - D: weight_ld_start
// - E: weight_swap
// - F: mult_start
// - X: unused
//
// New weight buffer (0x04) (read/write)
//
// N x N bytes
//
// Data input buffer (0x04 + NxN) (read/write)
//
// N x N bytes
//
// Accumulated outputs buffer (0x04 + 2xNxN)  (read only)
//
// N x N x 4 bytes
//

module mmu_axi #(
    parameter integer S_AXI_DATA_WIDTH = 32,
    parameter integer S_AXI_ADDR_WIDTH = 4,
    parameter integer NUM_WORDS = 4,
    parameter SIZE = 64,
    parameter WEIGHT_FIFO_DEPTH = 3,
    parameter DATA_FIFO_DEPTH = 3,
    parameter OUT_FIFO_DEPTH = 3
) (
    // Global signals.
    input logic s_axi_aclk,
    input logic s_axi_aresetn,

    // Write address channel.
    input logic [S_AXI_ADDR_WIDTH-1:0] s_axi_awaddr,
    input logic [2:0] s_axi_awprot,
    input logic s_axi_awvalid,
    output logic s_axi_awready,

    // Write data channel.
    input logic [S_AXI_DATA_WIDTH-1:0] s_axi_wdata,
    input logic [(S_AXI_DATA_WIDTH/8)-1:0] s_axi_wstrb,
    input logic s_axi_wvalid,
    output logic s_axi_wready,

    // Write response channel.
    output logic [1:0] s_axi_bresp,
    output logic s_axi_bvalid,
    input logic s_axi_bready,

    // Read address channel.
    input logic [S_AXI_ADDR_WIDTH-1:0] s_axi_araddr,
    input logic [2:0] s_axi_arprot,
    input logic s_axi_arvalid,
    output logic s_axi_arready,

    // Read data/response channel.
    output logic [S_AXI_DATA_WIDTH-1:0] s_axi_rdata,
    output logic [1:0] s_axi_rresp,
    output logic s_axi_rvalid,
    input logic s_axi_rready
);

  logic rst_n;
  logic clk;

  assign rst_n = s_axi_aresetn;
  assign clk   = s_axi_aclk;

  /*
   * MMU instance.
   */

  // Push a new weight into the weight FIFO.
  logic [7:0] new_weight_in[SIZE][SIZE];
  logic new_weight_rdy, new_weight_push;

  // Push new activations into the data FIFO.
  logic [7:0] data_in[SIZE][SIZE];
  logic data_in_rdy, data_in_push;

  // Pop new results off the result FIFO.
  logic [31:0] acc_out[SIZE][SIZE];
  logic acc_out_rdy, acc_out_pop;

  // Load new weights into array.
  logic weight_ld_rdy, weight_ld_start, weight_ld_done, weight_swap;

  // Run a matrix multiplication.
  logic mult_rdy, mult_start, mult_done;

  mmu #(
      .SIZE(SIZE),
      .WEIGHT_FIFO_DEPTH(WEIGHT_FIFO_DEPTH),
      .DATA_FIFO_DEPTH(DATA_FIFO_DEPTH),
      .OUT_FIFO_DEPTH(OUT_FIFO_DEPTH)
  ) mmu_unit (
      .*
  );

  /*
   * Write interface.
   */

  localparam WR_INIT = 2'b00, WR_ADDR = 2'b01, WR_DATA = 2'b10, WR_STORE = 2'b11;
  logic [2:0] wr_state;

  logic [S_AXI_ADDR_WIDTH-1:0] waddr;
  logic [S_AXI_DATA_WIDTH-1:0] wdata;
  logic [(S_AXI_DATA_WIDTH/8)-1:0] wstrb;
  logic wready, awready, bvalid;

  assign s_axi_awready = awready;
  assign s_axi_wready  = wready;
  assign s_axi_bvalid  = bvalid;
  assign s_axi_bresp   = 2'b00;  // Writes always succeed

  always_ff @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if (~s_axi_aresetn) begin
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
              bvalid <= 1;  // Set valid response
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
            bvalid <= 1;  // Set valid response
            wr_state <= WR_STORE;
          end
        end
        WR_STORE: begin
          awready  <= 1;
          wready   <= 1;
          bvalid   <= 0;  // Clear valid response
          wr_state <= WR_ADDR;
        end
        default: begin
          // Impossible, just to satisfy linter.
        end
      endcase
    end
  end

  //   genvar i;
  //   generate
  //     for (i = 0; i < NUM_BYTES_PER_DATA_WORD; i = i + 1) begin
  //       always_ff @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
  //         if (~s_axi_aresetn) begin
  //         //   mmap[waddr] <= 0;
  //         end else begin
  //           //   if (wr_state == WR_STORE) begin
  //           //     if (wstrb[i]) begin
  //           //       mmap[waddr] <= wdata;
  //           //     end
  //           //   end

  //           if (wr_state == WR_STORE) begin
  //             if (awaddr == h00 && i == 0 && wstrb[0]) begin
  //               // Only first byte is used for this register.
  //               new_weight_push <= wdata[0];
  //               data_in_push <= wdata[1];
  //               acc_out_pop <= wdata[2];
  //               weight_ld_start <= wdata[3];
  //               weight_swap <= wdata[4];
  //               mult_start <= wdata[5];
  //             end
  //           end
  //         end
  //       end
  //     end
  //   endgenerate

  /*
   * Read interface.
   */

  localparam RD_INIT = 2'b00, RD_ADDR = 2'b01, RD_LOAD = 2'b10, RD_RESP = 2'b11;
  logic [2:0] rd_state;

  logic [S_AXI_ADDR_WIDTH-1:0] araddr;
  logic rvalid, arready;
  logic [S_AXI_DATA_WIDTH-1:0] rdata;

  assign s_axi_arready = arready;
  assign s_axi_rvalid  = rvalid;
  assign s_axi_rdata   = rdata;
  assign s_axi_rresp   = 0;

  always_ff @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if (~s_axi_aresetn) begin
      arready  <= 0;
      rvalid   <= 0;
      rd_state <= RD_INIT;
    end else begin
      case (rd_state)
        RD_INIT: begin
          arready  <= 1;
          rd_state <= RD_ADDR;
        end
        RD_ADDR: begin
          if (s_axi_arvalid) begin
            araddr   <= s_axi_araddr;
            arready  <= 0;
            rd_state <= RD_LOAD;
          end
        end
        RD_LOAD: begin
          rvalid   <= 1;
          rd_state <= RD_RESP;
        end
        RD_RESP: begin
          if (s_axi_rready) begin
            rvalid   <= 0;
            arready  <= 1;
            rd_state <= RD_ADDR;
          end
        end
        default: begin
          // Impossible, just to satisfy linter.
        end
      endcase
    end
  end

  always_ff @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if (~s_axi_aresetn) begin
      rdata <= 0;
    end else begin
      if (rd_state == RD_LOAD) begin
        if (araddr == 'h0) begin
          rdata[0] <= new_weight_rdy;
          rdata[1] <= data_in_rdy;
          rdata[2] <= acc_out_rdy;
          rdata[3] <= weight_ld_rdy;
          rdata[4] <= mult_rdy;
          rdata[5] <= mult_done;
        end
      end else begin
        rdata <= 0;
      end
    end
  end

endmodule
