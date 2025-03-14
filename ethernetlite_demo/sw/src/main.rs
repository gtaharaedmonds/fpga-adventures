#![no_std]
#![no_main]

use heapless::Vec;
use panic_halt as _;
use riscv_rt::entry;

use neorv32::{
    clint::{Clint, delay_ms},
    gpio::*,
    println,
    uart::{Uart, init_uart_print},
};
use xilinx::ethernetlite::{EthernetLite, MacAddress, packet_buffer::MAX_DATA_SIZE, phy::PhySpeed};

const PHY_ADDR: u8 = 1;

#[entry]
fn main() -> ! {
    let mut gpio = Gpio::new(neorv32::GPIO_BASE);
    let mut uart = Uart::new(neorv32::UART0_BASE);
    let mut clint = Clint::new(neorv32::CLINT_BASE);

    uart.init(19200);
    init_uart_print(uart);
    println!("Initialized UART printing");

    clint.init();
    println!("Initialized CLINT timer");

    let mac = MacAddress::new([0x00, 0x0A, 0x35, 0x01, 0x02, 0x03]);
    let mut ethernet = EthernetLite::new(0xF000_0000, mac);

    ethernet.init();
    println!("Done initializing ethernet");

    let mut phy = ethernet.phy(PHY_ADDR);
    phy.configure_loopback(PhySpeed::Speed100M);
    println!("Done configuring PHY");

    ethernet.flush_receive();
    println!("Flushed RX buffer");

    loop {
        gpio.write_output(7, true);
        delay_ms(500);

        gpio.write_output(7, false);
        delay_ms(500);

        for pin in 0..7 {
            gpio.write_output(pin, gpio.read_input(pin));
        }

        println!("Hello, world (at 1Hz)");

        let data: Vec<u8, MAX_DATA_SIZE> = (0..100).collect();
        ethernet.transmit_frame(mac, data);
        println!("Sent frame!");

        println!("Received frame: {:?}", ethernet.receive_frame());
    }
}
