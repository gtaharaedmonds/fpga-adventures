#![no_std]

pub mod gpio;
pub mod uart;

pub const CLK_HZ: usize = 100_000_000; // 100MHz

pub const GPIO_BASE: *mut gpio::GpioRegs = 0xFFFC0000 as *mut gpio::GpioRegs;
pub const UART0_BASE: *mut uart::UartRegs = 0xFFF50000 as *mut uart::UartRegs;
pub const UART1_BASE: *mut uart::UartRegs = 0xFFF60000 as *mut uart::UartRegs;
