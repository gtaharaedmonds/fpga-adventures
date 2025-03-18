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

    logic eth_mdio_mdio_o, eth_mdio_mdio_i, eth_mdio_mdio_t;

    IOBUF eth_mdio_mdio_iobuf (
        .I (eth_mdio_mdio_o),
        .IO(eth_mdio_mdio_io),
        .O (eth_mdio_mdio_i),
        .T (eth_mdio_mdio_t)
    );

    neorv32_system neorv32_system_unit (.*);

endmodule
