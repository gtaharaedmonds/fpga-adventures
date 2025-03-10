#![no_std]
#![no_main]

use panic_halt as _;
use riscv_rt::entry;

use neorv32::{
    gpio::*,
    println,
    uart::{Uart, init_uart_print},
};

#[entry]
fn main() -> ! {
    let mut gpio = Gpio::new(neorv32::GPIO_BASE);
    let uart = Uart::new(neorv32::UART0_BASE);

    // uart.init(19200); <-- If I re-initialize this UART stops working?
    init_uart_print(uart);

    let mut iter = 0;
    let mut i = 0;
    let mut enabled = false;

    loop {
        gpio.write_output(7, enabled);

        for pin in 0..7 {
            gpio.write_output(pin, gpio.read_input(pin));
        }

        if i < 100_000 {
            i += 1;
        } else {
            println!("Hello, world! {}", iter);
            iter += 1;

            enabled = !enabled;
            i = 0;
        }
    }
}
