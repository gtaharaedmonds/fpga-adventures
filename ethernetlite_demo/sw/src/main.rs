#![no_std]
#![no_main]

// use heapless::Vec;
use panic_halt as _;
use riscv_rt::entry;

use neorv32::{
    clint::{Clint, delay_ms},
    gpio::*,
    println,
    uart::{Uart, init_uart_print},
};
use xilinx::ethernetlite::{EthernetLite, MacAddress, PhySpeed, packet_buffer::MAX_DATA_SIZE};

#[entry]
fn main() -> ! {
    let mut gpio = Gpio::new(neorv32::GPIO_BASE);
    let mut uart = Uart::new(neorv32::UART0_BASE);
    let mut clint = Clint::new(neorv32::CLINT_BASE);

    uart.init(19200);
    init_uart_print(uart);
    println!("Setup printing!");

    clint.init();
    println!("Initialized!");

    // clint.set_timer_freq(1);
    // println!("Set frequency!");

    // // let mac = MacAddress::new([0x00, 0x00, 0x5E, 0x00, 0xFA, 0xCE]);
    // let mac = MacAddress::new([0x00, 0x0A, 0x35, 0x01, 0x02, 0x03]);
    // let broadcast = MacAddress::new([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]);
    // let mut ethernet = EthernetLite::new(0xF000_0000, mac);

    // println!("Initializing ethernet!");
    // ethernet.init();
    // println!("Done initializing ethernet");

    // let phy_addr = ethernet.phy_detect().unwrap();
    // println!("PHY address: {:?}", phy_addr);

    // ethernet.phy_configure_loopback(phy_addr, PhySpeed::Speed100M);
    // println!("Done initializing ethernet!");

    // ethernet.flush_receive();
    // println!("Flushed RX buffer");

    // // let mut iter = 0;
    // //

    // // loop {
    // let data: Vec<u8, MAX_DATA_SIZE> = (0..100).collect();
    // ethernet.transmit_frame(broadcast, data);
    // println!("Sent frame!");
    // delay_ms(1000);
    // ethernet.receive_frame();
    // // println!("Result: {:?}",);
    // // }

    loop {
        gpio.write_output(7, true);
        delay_ms(500);

        gpio.write_output(7, false);
        delay_ms(500);

        for pin in 0..7 {
            gpio.write_output(pin, gpio.read_input(pin));
        }

        println!("Hello, world (at 1Hz)");

        // delay_ms(1000);
    }
}
