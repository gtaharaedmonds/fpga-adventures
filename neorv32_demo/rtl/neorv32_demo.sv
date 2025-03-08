module neorv32_demo (
    input logic sys_clk,
    input logic rst_n,
    input logic [7:0] gpio_i,
    output logic [7:0] gpio_o
);

  neorv32_system neorv32_system_unit (
      .*,
      .time_irq(0),
      .sw_irq  (0),
      .ext_irq (0),
      .jtag_tdi(),
      .jtag_tdo(),
      .jtag_tck(),
      .jtag_tms()
  );

endmodule
