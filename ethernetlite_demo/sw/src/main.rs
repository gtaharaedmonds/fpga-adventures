#![no_std]
#![no_main]

use panic_halt as _;
use riscv_rt::entry;

use neorv32::{
    delay_ms,
    gpio::*,
    println,
    uart::{Uart, init_uart_print},
};
use xilinx::ethernetlite::{EthernetLite, MacAddress};

#[entry]
fn main() -> ! {
    let mut gpio = Gpio::new(neorv32::GPIO_BASE);
    let uart = Uart::new(neorv32::UART0_BASE);

    // uart.init(19200); <-- If I re-initialize this UART stops working?
    init_uart_print(uart);

    let mut ethernet = EthernetLite::new(0xF000_0000);
    println!("Initializing ethernet");
    ethernet.init();

    let mac = MacAddress::new([0x00, 0x0A, 0x35, 0x01, 0x02, 0x03]);
    println!("Writing MAC address to {:?}", mac);
    ethernet.set_mac_address(mac);

    println!("Done initializing ethernet!");

    ethernet.phy_read_regs();

    let mut iter = 0;

    loop {
        gpio.write_output(7, true);
        delay_ms(500);

        gpio.write_output(7, false);
        delay_ms(100);

        for pin in 0..7 {
            gpio.write_output(pin, gpio.read_input(pin));
        }

        // println!("Hello, world! {}", iter);
        iter += 1;
    }
}
