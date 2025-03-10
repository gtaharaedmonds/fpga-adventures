module ethernet_demo (
    input logic sys_clk,
    input logic rst_n,
    input logic [7:0] gpio_i,
    output logic [7:0] gpio_o,
    output logic uart_tx,
    input logic uart_rx
);

  neorv32_system neorv32_system_unit (.*);

endmodule
