#![no_std]
#![no_main]

use panic_halt as _;
use riscv_rt::entry;

#[repr(C)]
struct GpioRegs {
    port_in: u32,
    port_out: u32,
    reserved: [u32; 2],
    irq_type: u32,
    irq_polarity: u32,
    irq_enable: u32,
    irq_pending: u32,
}

struct Gpio {
    regs: &'static mut GpioRegs,
}

const NEORV32_GPIO_REGS: *mut GpioRegs = 0xFFFC0000 as *mut GpioRegs;

impl Gpio {
    fn new(regs: &'static mut GpioRegs) -> Self {
        Self { regs }
    }

    fn read_input(&self, pin: usize) -> bool {
        let port_in = unsafe { core::ptr::read_volatile(core::ptr::addr_of!(self.regs.port_in)) };
        (port_in & (1 << pin)) != 0
    }

    fn write_output(&mut self, pin: usize, value: bool) {
        let mut port_out =
            unsafe { core::ptr::read_volatile(core::ptr::addr_of!(self.regs.port_out)) };

        if value {
            port_out |= 1 << pin;
        } else {
            port_out &= !(1 << pin);
        }

        unsafe { core::ptr::write_volatile(core::ptr::addr_of_mut!(self.regs.port_out), port_out) }
    }
}

#[entry]
fn main() -> ! {
    let gpio_regs = unsafe { &mut *NEORV32_GPIO_REGS };
    let mut gpio = Gpio::new(gpio_regs);

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
