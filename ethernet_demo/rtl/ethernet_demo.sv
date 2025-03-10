module ethernet_demo (
    input logic rst_n,
    input logic sys_clk,

    // GPIO I/O.
    input logic [7:0] gpio_i,
    output logic [7:0] gpio_o,

    // UART I/O.
    output logic uart_tx,
    input logic uart_rx,

    // Ethernet I/O.
    input logic eth_int_b,
    input logic [3:0] eth_rgmii_rd,
    input logic eth_rgmii_rx_ctl,
    input logic eth_rgmii_rxc,
    output logic [3:0] eth_rgmii_td,
    output logic eth_rgmii_tx_ctl,
    output logic eth_rgmii_txc,
    output logic eth_rst_n,
    output logic eth_mdio_mdc,
    inout logic eth_mdio_mdio_io
);

    logic eth_mdio_mdio_o, eth_mdio_mdio_i, eth_mdio_mdio_t;

IOBUF eth_mdio_mdio_iobuf
     (.I(eth_mdio_mdio_o),
      .IO(eth_mdio_mdio_io),
      .O(eth_mdio_mdio_i),
      .T(eth_mdio_mdio_t));

  neorv32_system neorv32_system_unit (.*);

endmodule
