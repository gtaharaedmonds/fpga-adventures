module tpu (
    input logic rst_n,
    input logic sys_clk,

    // GPIO I/O.
    input  logic [7:0] gpio_i,
    output logic [7:0] gpio_o,

    // UART I/O.
    output logic uart_tx,
    input  logic uart_rx,

    // Ethernet I/O.
    inout logic eth_intn,
    output logic eth_mdio_mdc,
    inout logic eth_mdio_mdio_io,
    output logic eth_refclk,
    input logic eth_rmii_crs_dv,
    input logic eth_rmii_rx_er,
    input logic [1:0] eth_rmii_rxd,
    output logic eth_rmii_tx_en,
    output logic [1:0] eth_rmii_txd,
    output logic [0:0] eth_rst_n
);

  localparam integer S_AXI_DATA_WIDTH = 32;
  localparam integer S_AXI_ADDR_WIDTH = 4;
  localparam integer NUM_WORDS = 4;

  // Global signals.
  logic s_axi_aclk, s_axi_aresetn;

  // Write address channel.
  logic [S_AXI_ADDR_WIDTH-1:0] s_axi_awaddr;
  logic [2:0] s_axi_awprot;
  logic s_axi_awvalid;
  logic s_axi_awready;

  // Write data channel.
  logic [S_AXI_DATA_WIDTH-1:0] s_axi_wdata;
  logic [(S_AXI_DATA_WIDTH/8)-1:0] s_axi_wstrb;
  logic s_axi_wvalid;
  logic s_axi_wready;

  // Write response channel.
  logic [1:0] s_axi_bresp;
  logic s_axi_bvalid;
  logic s_axi_bready;

  // Read address channel.
  logic [S_AXI_ADDR_WIDTH-1:0] s_axi_araddr;
  logic [2:0] s_axi_arprot;
  logic s_axi_arvalid;
  logic s_axi_arready;

  // Read data/response channel.
  logic [S_AXI_DATA_WIDTH-1:0] s_axi_rdata;
  logic [1:0] s_axi_rresp;
  logic s_axi_rvalid;
  logic s_axi_rready;

  // Ethernet signals.
  logic eth_mdio_mdio_o, eth_mdio_mdio_i, eth_mdio_mdio_t;

  IOBUF eth_mdio_mdio_iobuf (
      .I (eth_mdio_mdio_o),
      .IO(eth_mdio_mdio_io),
      .O (eth_mdio_mdio_i),
      .T (eth_mdio_mdio_t)
  );

  neorv32_system neorv32_system_unit (.*);

  mmu_axi mmu_axi_unit (.*);

endmodule
