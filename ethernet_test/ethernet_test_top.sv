module ethernet_test_top (
    input logic rst_n,
    input logic sys_clk,
    // PHY I/O.
    output logic eth_refclk,
    input logic eth_crsdv,
    output logic eth_rxerr,
    input logic [1:0] eth_rxd,
    output logic [1:0] eth_txd,
    output logic eth_txen,
    output logic eth_rstn,
    output logic eth_mdc,
    inout logic eth_mdio,
    input eth_intn
);
  logic phy_rst_n;
  logic clk_50MHz;
  logic
      mac_mii_crs,
      mac_mii_rxrst,
      mac_mii_rxc,
      mac_mii_rxdv,
      mac_mii_rxer,
      mac_mii_txrst,
      mac_mii_txc,
      mac_mii_txen,
      mac_mii_txer;
  logic [3:0] mac_mii_rxd, mac_mii_txd;
  logic mdio_in, mdio_out, mdio_tri;

  assign eth_refclk = clk_50MHz;

  IOBUF mdio_iobuf (
      .O (mdio_in),   // Output to fabric (input)
      .I (mdio_out),  // Input from fabric (output)
      .T (mdio_tri),  // Tristate control
      .IO(eth_mdio)   // Bidirectional external pin
  );

  axi_ethernetlite_0 axi_ethernetlite_unit (
      // Interrupt signal (unused).
      .ip2intc_irpt(),
      // Connect to MII -> RMII adapter.
      .phy_tx_clk(mac_mii_txc),
      .phy_rx_clk(mac_mii_rxc),
      .phy_crs(mac_mii_crs),
      .phy_dv(mac_mii_rxdv),
      .phy_rx_data(mac_mii_rxd),
      .phy_col(0),
      .phy_rx_er(mac_mii_rxer),
      .phy_rst_n(phy_rst_n),
      .phy_tx_en(mac_mii_txen),
      .phy_tx_data(mac_mii_txd),
      // MDIO / MDC go directly to PHY.
      .phy_mdio_i(mdio_in),
      .phy_mdio_o(phy_mdio_o),
      .phy_mdio_t(mdio_tri),
      .phy_mdc(eth_mdc)
  );

  rmii_phy_if rmii_phy_if_unit (
      .rstn_async(phy_rst_n),
      // Configures in 100MB mode.
      .mode_speed(1),
      // MII to connect to MAC.
      .mac_mii_crs(mac_mii_crs),
      .mac_mii_rxrst(mac_mii_rxrst),
      .mac_mii_rxc(mac_mii_rxc),
      .mac_mii_rxdv(mac_mii_rxdv),
      .mac_mii_rxer(mac_mii_rxer),
      .mac_mii_rxd(mac_mii_rxd),
      .mac_mii_txrst(mac_mii_txrst),
      .mac_mii_txc(mac_mii_txc),
      .mac_mii_txen(mac_mii_txen),
      .mac_mii_txer(mac_mii_txer),
      .mac_mii_txd(mac_mii_txd),
      // RMII output to PHY.
      .phy_rmii_ref_clk(eth_refclk),
      .phy_rmii_crsdv(eth_crsdv),
      .phy_rmii_rxer(eth_rxerr),
      .phy_rmii_rxd(eth_rxd),
      .phy_rmii_txen(eth_txen),
      .phy_rmii_txd(eth_txd),
  );
endmodule
