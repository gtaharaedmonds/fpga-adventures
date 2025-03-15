#![no_std]
#![no_main]

use neorv32 as _;
use riscv_rt::entry;

use neorv32::gpio::*;

#[entry]
fn main() -> ! {
    let mut gpio = Gpio::new(neorv32::GPIO_BASE);

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
            enabled = !enabled;
            i = 0;
        }
    }
}
