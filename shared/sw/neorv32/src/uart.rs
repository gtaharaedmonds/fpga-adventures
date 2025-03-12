#![allow(static_mut_refs)]

use core::fmt::{self, Write};
use modular_bitfield::{bitfield, prelude::*};
use volatile_register::RW;

#[bitfield]
#[derive(Clone, Copy, Debug)]
pub struct UartCtrlReg {
    en: bool,
    sim_mode: bool,
    hw_fc_en: bool,
    prsc: B3,
    baud: B10,
    rx_nempty: bool,
    rx_half: bool,
    rx_full: bool,
    tx_empty: bool,
    tx_nhalf: bool,
    tx_full: bool,
    irq_rx_nempty: bool,
    irq_rx_half: bool,
    irq_rx_full: bool,
    irq_tx_empty: bool,
    irq_tx_nhalf: bool,
    unused: B1,
    rx_clr: bool,
    tx_clr: bool,
    rx_over: bool,
    tx_busy: bool,
}

#[bitfield]
#[derive(Clone, Copy, Debug)]
pub struct UartDataReg {
    rtx_word: u16,
    rx_fifo_size: B4,
    tx_fifo_size: B4,
}

#[repr(C)]
pub struct UartRegs {
    pub ctrl: RW<UartCtrlReg>,
    data: RW<UartDataReg>,
}

pub struct Uart {
    pub regs: &'static mut UartRegs,
}

impl Uart {
    pub fn new(regs: *mut UartRegs) -> Self {
        Self {
            regs: unsafe { &mut *regs },
        }
    }

    pub fn init(&mut self, baudrate: usize) {
        // Reset CTRL word.
        unsafe { self.regs.ctrl.write(UartCtrlReg::new().with_en(false)) };

        let mut baud_div = crate::CLK_HZ / (2 * baudrate);
        let mut prsc_sel = 0;

        // This division process is weird, copied from neorv32's C driver.
        while baud_div >= 0x3ff {
            if prsc_sel == 2 || prsc_sel == 4 {
                baud_div >>= 3;
            } else {
                baud_div >>= 1;
            }

            prsc_sel += 1;
        }

        // Write new CTRL word.
        unsafe {
            self.regs.ctrl.write(
                UartCtrlReg::new()
                    .with_en(true)
                    .with_prsc(prsc_sel as u8)
                    .with_baud((baud_div - 1) as u16),
            );
        }
    }

    pub fn putc(&mut self, chr: u8) {
        while self.regs.ctrl.read().tx_full() {}

        unsafe {
            self.regs
                .data
                .write(UartDataReg::new().with_rtx_word(chr as u16))
        };
    }

    pub fn puts(&mut self, text: &str) {
        for chr in text.bytes() {
            if chr == b'\n' {
                self.putc(b'\r');
            }

            self.putc(chr);
        }
    }
}

pub struct UartWriter {
    uart: Uart,
}

impl Write for UartWriter {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        self.uart.puts(s);
        Ok(())
    }
}

pub static mut UART_WRITER: Option<UartWriter> = None;

pub fn init_uart_print(uart: Uart) {
    unsafe {
        UART_WRITER = Some(UartWriter { uart });
    }
}

#[macro_export]
macro_rules! print {
    ($($arg:tt)*) => ({
        use core::fmt::Write;
        if let Some(writer) = unsafe { &mut $crate::uart::UART_WRITER } {
            let _ = write!(writer, $($arg)*);
        }
    });
}

#[macro_export]
macro_rules! println {
    () => ($crate::custom_print!("\n"));
    ($($arg:tt)*) => ($crate::print!("{}\n", format_args!($($arg)*)));
}
