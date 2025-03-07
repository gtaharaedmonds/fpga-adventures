# Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { sys_clk }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {sys_clk}];

# # Buttons
# set_property -dict { PACKAGE_PIN C12   IOSTANDARD LVCMOS33 } [get_ports { rst_n }]; #IO_L3P_T0_DQS_AD1P_15 Sch=cpu_resetn

# # 7 segment displays
# set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { cathodes_7seg[0] }]; #IO_L24N_T3_A00_D16_14 Sch=ca
# set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { cathodes_7seg[1] }]; #IO_25_14 Sch=cb
# set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { cathodes_7seg[2] }]; #IO_25_15 Sch=cc
# set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { cathodes_7seg[3] }]; #IO_L17P_T2_A26_15 Sch=cd
# set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { cathodes_7seg[4] }]; #IO_L13P_T2_MRCC_14 Sch=ce
# set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { cathodes_7seg[5] }]; #IO_L19P_T3_A10_D26_14 Sch=cf
# set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { cathodes_7seg[6] }]; #IO_L4P_T0_D04_14 Sch=cg
# # set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { cathode_dp }]; #IO_L19N_T3_A21_VREF_15 Sch=dp

# set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { anodes_7seg[0] }]; #IO_L23P_T3_FOE_B_15 Sch=an[0]
# set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { anodes_7seg[1] }]; #IO_L23N_T3_FWE_B_15 Sch=an[1]
# set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { anodes_7seg[2] }]; #IO_L24P_T3_A01_D17_14 Sch=an[2]
# set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { anodes_7seg[3] }]; #IO_L19P_T3_A22_15 Sch=an[3]
# set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { anodes_7seg[4] }]; #IO_L8N_T1_D12_14 Sch=an[4]
# set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { anodes_7seg[5] }]; #IO_L14P_T2_SRCC_14 Sch=an[5]
# set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { anodes_7seg[6] }]; #IO_L23P_T3_35 Sch=an[6]
# set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { anodes_7seg[7] }]; #IO_L23N_T3_A02_D18_14 Sch=an[7]

# # Switches
# set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { debug_addr[0] }]; #IO_L24N_T3_RS0_15 Sch=sw[0]
# set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { debug_addr[1] }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=sw[1]
# set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { debug_addr[2] }]; #IO_L6N_T0_D08_VREF_14 Sch=sw[2]
# set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { debug_addr[3] }]; #IO_L13N_T2_MRCC_14 Sch=sw[3]
# set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { debug_addr[4] }]; #IO_L12N_T1_MRCC_14 Sch=sw[4]
# set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { debug_addr[5] }]; #IO_L7N_T1_D10_14 Sch=sw[5]
# set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { debug_addr[6] }]; #IO_L17N_T2_A13_D29_14 Sch=sw[6]
# set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { debug_addr[7] }]; #IO_L5N_T0_D07_14 Sch=sw[7]

#USB-RS232 Interface

set_property -dict { PACKAGE_PIN C4    IOSTANDARD LVCMOS33 } [get_ports { uart_rx }]; #IO_L7P_T1_AD6P_35 Sch=uart_txd_in
set_property -dict { PACKAGE_PIN D4    IOSTANDARD LVCMOS33 } [get_ports { uart_tx }]; #IO_L11N_T1_SRCC_35 Sch=uart_rxd_out
set_property -dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33 } [get_ports { uart_ctx }]; #IO_L12N_T1_MRCC_35 Sch=uart_cts
set_property -dict { PACKAGE_PIN E5    IOSTANDARD LVCMOS33 } [get_ports { uart_rts }]; #IO_L5N_T0_AD13N_35 Sch=uart_rts