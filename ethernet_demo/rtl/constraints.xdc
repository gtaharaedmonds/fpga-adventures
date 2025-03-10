# Clock Signal
set_property -dict { PACKAGE_PIN R4    IOSTANDARD LVCMOS33 } [get_ports { sys_clk }]; #IO_L13P_T2_MRCC_34 Sch=sysclk
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports sys_clk]

# Buttons
set_property -dict { PACKAGE_PIN G4  IOSTANDARD LVCMOS15 } [get_ports { rst_n }]; #IO_L12N_T1_MRCC_35 Sch=cpu_resetn

# Switches
set_property -dict { PACKAGE_PIN E22  IOSTANDARD LVCMOS12 } [get_ports { gpio_i[0] }]; #IO_L22P_T3_16 Sch=sw[0]
set_property -dict { PACKAGE_PIN F21  IOSTANDARD LVCMOS12 } [get_ports { gpio_i[1] }]; #IO_25_16 Sch=sw[1]
set_property -dict { PACKAGE_PIN G21  IOSTANDARD LVCMOS12 } [get_ports { gpio_i[2] }]; #IO_L24P_T3_16 Sch=sw[2]
set_property -dict { PACKAGE_PIN G22  IOSTANDARD LVCMOS12 } [get_ports { gpio_i[3] }]; #IO_L24N_T3_16 Sch=sw[3]
set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS12 } [get_ports { gpio_i[4] }]; #IO_L6P_T0_15 Sch=sw[4]
set_property -dict { PACKAGE_PIN J16  IOSTANDARD LVCMOS12 } [get_ports { gpio_i[5] }]; #IO_0_15 Sch=sw[5]
set_property -dict { PACKAGE_PIN K13  IOSTANDARD LVCMOS12 } [get_ports { gpio_i[6] }]; #IO_L19P_T3_A22_15 Sch=sw[6]
set_property -dict { PACKAGE_PIN M17  IOSTANDARD LVCMOS12 } [get_ports { gpio_i[7] }]; #IO_25_15 Sch=sw[7]

# LEDs
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS25 } [get_ports { gpio_o[0] }]; #IO_L15P_T2_DQS_13 Sch=led[0]
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS25 } [get_ports { gpio_o[1] }]; #IO_L15N_T2_DQS_13 Sch=led[1]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS25 } [get_ports { gpio_o[2] }]; #IO_L17P_T2_13 Sch=led[2]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS25 } [get_ports { gpio_o[3] }]; #IO_L17N_T2_13 Sch=led[3]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS25 } [get_ports { gpio_o[4] }]; #IO_L14N_T2_SRCC_13 Sch=led[4]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS25 } [get_ports { gpio_o[5] }]; #IO_L16N_T2_13 Sch=led[5]
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS25 } [get_ports { gpio_o[6] }]; #IO_L16P_T2_13 Sch=led[6]
set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS25 } [get_ports { gpio_o[7] }]; #IO_L5P_T0_13 Sch=led[7]

# UART
set_property -dict { PACKAGE_PIN AA19  IOSTANDARD LVCMOS33 } [get_ports { uart_tx }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=uart_rx_out
set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { uart_rx }]; #IO_L14P_T2_SRCC_14 Sch=uart_tx_in

# Ethernet
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS25 } [get_ports { eth_int_b }]; #IO_L6N_T0_VREF_13 Sch=eth_int_b
set_property -dict { PACKAGE_PIN AA16  IOSTANDARD LVCMOS25 } [get_ports { eth_mdio_mdc }]; #IO_L1N_T0_13 Sch=eth_mdc
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS25 } [get_ports { eth_mdio_mdio_io }]; #IO_L1P_T0_13 Sch=eth_mdio
# set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS25 } [get_ports { eth_pme_b }]; #IO_L6P_T0_13 Sch=eth_pme_b
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { eth_rst_n }]; #IO_25_34 Sch=eth_rst_b
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_rxc }]; #IO_L13P_T2_MRCC_13 Sch=eth_rxck
set_property -dict { PACKAGE_PIN W10   IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_rx_ctl }]; #IO_L10N_T1_13 Sch=eth_rxctl
set_property -dict { PACKAGE_PIN AB16  IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_rd[0] }]; #IO_L2P_T0_13 Sch=eth_rxd[0]
set_property -dict { PACKAGE_PIN AA15  IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_rd[1] }]; #IO_L4P_T0_13 Sch=eth_rxd[1]
set_property -dict { PACKAGE_PIN AB15  IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_rd[2] }]; #IO_L4N_T0_13 Sch=eth_rxd[2]
set_property -dict { PACKAGE_PIN AB11  IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_rd[3] }]; #IO_L7P_T1_13 Sch=eth_rxd[3]
set_property -dict { PACKAGE_PIN AA14  IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_txc }]; #IO_L5N_T0_13 Sch=eth_txck
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_tx_ctl }]; #IO_L10P_T1_13 Sch=eth_txctl
set_property -dict { PACKAGE_PIN Y12   IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_td[0] }]; #IO_L11N_T1_SRCC_13 Sch=eth_txd[0]
set_property -dict { PACKAGE_PIN W12   IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_td[1] }]; #IO_L12N_T1_MRCC_13 Sch=eth_txd[1]
set_property -dict { PACKAGE_PIN W11   IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_td[2] }]; #IO_L12P_T1_MRCC_13 Sch=eth_txd[2]
set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS25 } [get_ports { eth_rgmii_td[3] }]; #IO_L11P_T1_SRCC_13 Sch=eth_txd[3]

# Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
