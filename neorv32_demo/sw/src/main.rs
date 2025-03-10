#![no_std]
#![no_main]

use panic_halt as _;
use riscv_rt::entry;

fn gpio_write(gpio: &mut neorv32::Gpio, pin: usize, value: bool) {
    gpio.port_out().modify(|r, w| unsafe {
        if value {
            w.bits(r.bits() | (1 << pin))
        } else {
            w.bits(r.bits() & !(1 << pin))
        }
    });
}

fn gpio_read(gpio: &neorv32::Gpio, pin: usize) -> bool {
    (gpio.port_in().read().bits() & (1 << pin)) != 0
}

#[entry]
fn main() -> ! {
    let peripherals = unsafe { neorv32::Peripherals::steal() };
    let mut gpio = peripherals.gpio;

    let mut i = 0;
    let mut enabled = false;

    loop {
        gpio_write(&mut gpio, 7, enabled);

        for pin in 0..7 {
            let switched = gpio_read(&gpio, pin);
            gpio_write(&mut gpio, pin, switched);
        }

        if i < 100_000 {
            i += 1;
        } else {
            enabled = !enabled;
            i = 0;
        }
    }
}
