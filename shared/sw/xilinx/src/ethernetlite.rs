use bilge::prelude::*;
use neorv32::println;
use volatile_register::{RO, RW};

#[bitsize(32)]
#[derive(DebugBits, Clone, Copy)]
struct TxLengthReg {
    length: u16,
    reserved: u16,
}

#[bitsize(32)]
#[derive(DebugBits, Clone, Copy)]
struct TxGlobalInterruptEnableReg {
    reserved: u31,
    enable: bool,
}

#[bitsize(32)]
#[derive(DebugBits, Clone, Copy)]
struct TxControlReg {
    status: bool,
    program: bool,
    interrupt_enable: bool,
    loopback: bool,
    reserved: u28,
}

#[repr(C)]
pub struct TxControlRegs {
    length: RW<TxLengthReg>,
    global_interrupt_enable: RW<TxGlobalInterruptEnableReg>,
    control: RW<TxControlReg>,
}

#[bitsize(32)]
#[derive(DebugBits, Clone, Copy)]
struct TxBufferReg0 {
    dest_addr_ls4b: u32,
}

#[bitsize(32)]
#[derive(DebugBits, Clone, Copy)]
struct TxBufferReg1 {
    dest_addr_ms2b: u16,
    src_addr_ls2b: u16,
}

#[bitsize(32)]
#[derive(DebugBits, Clone, Copy)]
struct TxBufferReg2 {
    src_addr_ms4b: u32,
}

#[bitsize(32)]
#[derive(DebugBits, Clone, Copy)]
struct TxBufferLengthReg {
    length: u16,
    reserved: u16,
}

#[repr(C)]
pub struct TxBufferRegs {
    reg0: RW<TxBufferReg0>,
    reg1: RW<TxBufferReg1>,
    reg2: RW<TxBufferReg2>,
    length: RW<TxBufferLengthReg>,
}

#[bitsize(32)]
#[derive(DebugBits, Clone, Copy)]
struct MdioAddrReg {
    reg_addr: u5,
    phy_addr: u5,
    operation_rw: bool,
    reserved: u21,
}

#[bitsize(32)]
#[derive(DebugBits, Clone, Copy)]
struct MdioDataReg {
    data: u16,
    reserved: u16,
}

#[bitsize(32)]
#[derive(DebugBits, Clone, Copy)]
struct MdioControlReg {
    status: bool,
    reserved: u2,
    enable: bool,
    reserved: u28,
}

#[repr(C)]
pub struct MdioRegs {
    addr: RW<MdioAddrReg>,
    write_data: RW<MdioDataReg>,
    read_data: RO<MdioDataReg>,
    control: RW<MdioControlReg>,
}

pub struct EthernetLiteRegs {
    tx_buffer: &'static mut TxBufferRegs,
    tx_control: &'static mut TxControlRegs,
    mdio: &'static mut MdioRegs,
}

impl EthernetLiteRegs {
    const TX_BUF_REGS_OFFSET: usize = 0x000;
    const TX_CONTROL_REGS_OFFSET: usize = 0x7FC;
    const MDIO_REGS_OFFSET: usize = 0x7E4;

    pub fn new(base: usize) -> Self {
        unsafe {
            Self {
                tx_buffer: &mut *((base + Self::TX_BUF_REGS_OFFSET) as *mut TxBufferRegs),
                tx_control: &mut *((base + Self::TX_CONTROL_REGS_OFFSET) as *mut TxControlRegs),
                mdio: &mut *((base + Self::MDIO_REGS_OFFSET) as *mut MdioRegs),
            }
        }
    }
}

#[bitsize(1)]
#[derive(FromBits, Debug, Clone, Copy)]
pub enum PhySpeed {
    Speed10M,
    Speed100M,
}

#[bitsize(16)]
#[derive(DebugBits, Clone, Copy)]
struct PhyControlReg {
    reserved: u6,
    speed: PhySpeed,
    reserved: u7,
    loopback: bool,
    reset: bool,
}

#[derive(Clone, Copy)]
pub struct MacAddress([u8; 6]);

impl MacAddress {
    pub fn new(address_raw: [u8; 6]) -> Self {
        Self(address_raw)
    }
}

impl core::fmt::Debug for MacAddress {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        write!(
            f,
            "{:02X}:{:02x}:{:02X}:{:02X}:{:02X}:{:02X}",
            self.0[0], self.0[1], self.0[2], self.0[3], self.0[4], self.0[5]
        )
    }
}

impl From<MacAddress> for u64 {
    fn from(mac: MacAddress) -> Self {
        let mut bytes = [0; 8];
        bytes[..6].copy_from_slice(&mac.0);
        u64::from_le_bytes(bytes)
    }
}

pub struct EthernetLite {
    regs: EthernetLiteRegs,
}

impl EthernetLite {
    pub fn new(base: usize) -> Self {
        Self {
            regs: EthernetLiteRegs::new(base),
        }
    }

    pub fn init(&mut self) {
        unsafe {
            self.regs
                .tx_control
                .control
                .write(TxControlReg::new(false, false, false, false))
        };
    }

    pub fn set_mac_address(&mut self, mac: MacAddress) {
        // Write MAC address to TX ping buffer.
        unsafe {
            self.regs
                .tx_buffer
                .reg0
                .write(TxBufferReg0::new(u32::from_le_bytes(
                    mac.0[0..4].try_into().unwrap(),
                )));
            self.regs.tx_buffer.reg1.write(TxBufferReg1::new(
                u16::from_le_bytes(mac.0[4..6].try_into().unwrap()),
                0,
            ));
        };

        // Write length register.
        unsafe {
            self.regs
                .tx_control
                .length
                .write(TxLengthReg::new(mac.0.len() as u16));
        };

        // Set program and status bit.
        unsafe {
            self.regs.tx_control.control.modify(|mut control| {
                control.set_status(true);
                control.set_program(true);
                control
            })
        };

        // Wait until program and status bit cleared.
        while {
            let control = self.regs.tx_control.control.read();
            control.program() || control.status()
        } {}
    }

    fn phy_busy(&self) -> bool {
        self.regs.mdio.control.read().status()
    }

    fn phy_write(&mut self, phy_addr: u8, reg_addr: u8, data: u16) {
        while self.phy_busy() {}

        // Write MDIO address register.
        unsafe {
            self.regs.mdio.addr.write(MdioAddrReg::new(
                u5::new(reg_addr),
                u5::new(phy_addr),
                false,
            ))
        }

        // Write to data register.
        unsafe { self.regs.mdio.write_data.write(MdioDataReg::new(data)) }

        // Set MDIO enable and status bits.
        unsafe {
            self.regs.mdio.control.modify(|mut control| {
                control.set_status(true);
                control.set_enable(true);
                control
            })
        };

        // Block until transaction complete.
        while self.phy_busy() {}

        // Disable MDIO.
        unsafe {
            self.regs.mdio.control.modify(|mut control| {
                control.set_enable(false);
                control
            })
        }
    }

    fn phy_read(&mut self, phy_addr: u8, reg_addr: u8) -> u16 {
        while self.phy_busy() {}

        // Write MDIO address register.
        unsafe {
            self.regs.mdio.addr.write(MdioAddrReg::new(
                u5::new(reg_addr),
                u5::new(phy_addr),
                false,
            ))
        }

        // Set MDIO enable and status bits.
        unsafe {
            self.regs.mdio.control.modify(|mut control| {
                control.set_status(true);
                control.set_enable(true);
                control
            })
        };

        // Block until transaction complete.
        while self.regs.mdio.control.read().status() {}

        // Data is now available on the read register.
        let data = self.regs.mdio.read_data.read().data();

        // Disable MDIO.
        unsafe {
            self.regs.mdio.control.modify(|mut control| {
                control.set_enable(false);
                control
            })
        }

        data
    }

    pub fn phy_read_regs(&mut self) {
        for addr in (0..32).rev() {
            println!(
                "PHY {} regs: {} {} {} {}",
                addr,
                self.phy_read(addr, 0),
                self.phy_read(addr, 1),
                self.phy_read(addr, 2),
                self.phy_read(addr, 3),
            );
        }
    }
}
