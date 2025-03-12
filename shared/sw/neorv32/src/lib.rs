#![no_std]

pub mod gpio;
pub mod uart;

pub const CLK_HZ: usize = 100_000_000; // 100MHz

pub const GPIO_BASE: *mut gpio::GpioRegs = 0xFFFC0000 as *mut gpio::GpioRegs;
pub const UART0_BASE: *mut uart::UartRegs = 0xFFF50000 as *mut uart::UartRegs;
pub const UART1_BASE: *mut uart::UartRegs = 0xFFF60000 as *mut uart::UartRegs;

pub fn delay_ms(duration: usize) {
    let cycles = duration * (CLK_HZ / 10_000);

    unsafe {
        core::arch::asm!(
            "1:",
            "addi {0}, {0}, -1",  // Decrement counter
            "bnez {0}, 1b",       // Branch if not zero
            inout(reg) cycles => _,
            options(nomem, nostack)
        );
    }
}
