use core::{cell::RefCell, task::Context};

use critical_section::Mutex;
use riscv::interrupt::Interrupt;
use volatile_register::{RO, RW};

pub const MAX_NUM_HARTS: usize = 4096;
pub const TIMER_FREQ_HZ: usize = 1000;

#[repr(C)]
pub struct ClintRegs {
    _mswi: [RO<u32>; MAX_NUM_HARTS],
    mtimecmp: [RW<u64>; MAX_NUM_HARTS - 1],
    mtime: RW<u64>,
}

unsafe impl Sync for ClintRegs {}

pub struct Clint {
    regs: &'static ClintRegs,
}

impl Clint {
    pub fn new(regs: *mut ClintRegs) -> Self {
        Self {
            regs: unsafe { &mut *regs },
        }
    }

    pub fn init(&mut self) {
        critical_section::with(|cs| {
            let mut ctx = MACHINE_TIMER_HANDLER_CTX.borrow_ref_mut(cs);
            *ctx = Some(MachineTimerCtx {
                tick: 0,
                regs: self.regs,
            });
        });

        unsafe {
            riscv::register::mie::set_mtimer(); // Enable machine timer interrupt.
            riscv::register::mie::set_msoft(); // Enable machine software interrupt.
            riscv::register::mstatus::set_mie(); // Enable machine interrupts?

            // Set machine time back to 0.
            self.regs.mtime.write(0);
        }

        let timecmp = super::CLK_HZ / TIMER_FREQ_HZ;
        let hart = riscv::register::mhartid::read();
        unsafe { self.regs.mtimecmp[hart].write(timecmp as u64) };
    }
}

struct MachineTimerCtx {
    tick: usize,
    regs: &'static ClintRegs,
}

static MACHINE_TIMER_HANDLER_CTX: Mutex<RefCell<Option<MachineTimerCtx>>> =
    Mutex::new(RefCell::new(None));

#[riscv_rt::core_interrupt(Interrupt::MachineTimer)]
fn timer_handler() {
    critical_section::with(|cs| {
        let mut ctx_maybe = MACHINE_TIMER_HANDLER_CTX.borrow_ref_mut(cs);
        let ctx = ctx_maybe.as_mut().unwrap();

        // Increment global tick.
        ctx.tick += 1;

        // Reset mtime back to 0.
        unsafe { ctx.regs.mtime.write(0) };
    })
}

fn get_machine_timer_tick() -> usize {
    critical_section::with(|cs| {
        let mut ctx_maybe = MACHINE_TIMER_HANDLER_CTX.borrow_ref_mut(cs);
        let ctx = ctx_maybe.as_mut().unwrap();
        ctx.tick
    })
}

pub fn delay_ms(delay: usize) {
    let start = get_machine_timer_tick();
    while get_machine_timer_tick() - start < delay {}
}

pub trait InterruptCtx: Sync {
    fn handle(&self);
}

struct ExternalInterruptCtx<'a> {
    ctx: &'a dyn InterruptCtx,
}

static EXTERNAL_CTX: Mutex<RefCell<Option<ExternalInterruptCtx>>> = Mutex::new(RefCell::new(None));

#[riscv_rt::core_interrupt(Interrupt::MachineExternal)]
fn external_handler() {
    critical_section::with(|cs| {
        let mut ctx_maybe = EXTERNAL_CTX.borrow_ref_mut(cs);
        let ctx = ctx_maybe.as_mut().unwrap();
        ctx.ctx.handle();
    })
}

pub fn install_external_handler(external_ctx: &'static dyn InterruptCtx) {
    critical_section::with(|cs| {
        let mut ctx_maybe = EXTERNAL_CTX.borrow_ref_mut(cs);
        ctx_maybe.replace(ExternalInterruptCtx { ctx: external_ctx });
    })
}
