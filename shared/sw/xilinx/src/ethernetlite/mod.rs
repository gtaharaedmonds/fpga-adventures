pub mod packet_buffer;
pub mod regs;

use bilge::prelude::*;
use heapless::Vec;
use neorv32::{clint::delay_ms, print, println};
use packet_buffer::{MAX_DATA_SIZE, PacketBuffer};
use regs::*;

#[bitsize(1)]
#[derive(FromBits, Debug, Clone, Copy)]
pub enum PhySpeed {
    Speed10M = 0,
    Speed100M = 1,
}

#[bitsize(16)]
#[derive(DebugBits, Clone, Copy, FromBits)]
struct PhyControlReg {
    reserved: u13,
    speed: PhySpeed,
    loopback: bool,
    reset: bool,
}

impl PhyControlReg {
    const ADDR: u8 = 0;
}

#[bitsize(16)]
#[derive(DebugBits, Clone, Copy, FromBits)]
struct PhyStatusReg {
    reserved: u3,
    auto_negotation: bool,
    reserved: u7,
    half_duplex_10M: bool,
    full_duplex_10M: bool,
    reserved: u3,
}

impl PhyStatusReg {
    const ADDR: u8 = 1;
}

#[repr(transparent)]
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
    mac: MacAddress,
}

impl EthernetLite {
    pub fn new(base: usize, mac: MacAddress) -> Self {
        Self {
            regs: EthernetLiteRegs::new(base),
            mac,
        }
    }

    pub fn init(&mut self) {
        unsafe {
            self.regs
                .tx_control
                .control
                .write(TxControlReg::new(false, false, true, false));
            self.regs
                .tx_control
                .global_interrupt_enable
                .write(TxGlobalInterruptEnableReg::new(true));
            self.regs
                .rx_control
                .control
                .write(RxControlReg::new(false, true));
        };

        // Set MAC address.
        self.set_mac_address();
    }

    fn set_mac_address(&mut self) {
        // Write MAC address to TX ping buffer.
        self.regs.tx_buffer.write_aligned(&PacketBuffer::new(
            self.mac,
            MacAddress::new([0; 6]),
            Vec::new(),
        ));

        // Set packet length register.
        unsafe {
            self.regs
                .tx_control
                .packet_length
                .write(TxPacketLengthReg::new(self.mac.0.len() as u16));
        };

        // Set program and status bit.
        unsafe {
            self.regs.tx_control.control.modify(|mut control| {
                control.set_program_mac(true);
                control.set_busy(true);
                control
            })
        };

        // Wait until program and status bit cleared.
        while {
            let control = self.regs.tx_control.control.read();
            control.program_mac() || control.busy()
        } {}
    }

    pub fn mac_address(&self) -> &MacAddress {
        &self.mac
    }

    fn phy_busy(&self) -> bool {
        self.regs.mdio.control.read().busy()
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
                control.set_busy(true);
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
            self.regs
                .mdio
                .addr
                .write(MdioAddrReg::new(u5::new(reg_addr), u5::new(phy_addr), true))
        }

        // Set MDIO enable and status bits.
        unsafe {
            self.regs.mdio.control.modify(|mut control| {
                control.set_busy(true);
                control.set_enable(true);
                control
            })
        };

        // Block until transaction complete.
        while self.phy_busy() {}

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

    pub fn phy_detect(&mut self) -> Result<u8, ()> {
        for addr in (0..32).rev() {
            let reg = self.phy_read(addr, PhyStatusReg::ADDR);
            if reg == 0xFFFF {
                continue;
            }

            let status = PhyStatusReg::from(reg);
            if status.auto_negotation() && status.half_duplex_10M() && status.full_duplex_10M() {
                return Ok(addr);
            }
        }

        Err(())
    }

    pub fn phy_configure_loopback(&mut self, phy_addr: u8, speed: PhySpeed) {
        // Set speed and put phy in reset.
        self.phy_write(
            phy_addr,
            PhyControlReg::ADDR,
            PhyControlReg::new(speed, false, true).value,
        );

        // Delay for phy to reset.
        delay_ms(4000);

        // Enable loopback.
        self.phy_write(
            phy_addr,
            PhyControlReg::ADDR,
            PhyControlReg::new(speed, true, false).value,
        );

        // Delay for loopback to enable.
        delay_ms(1000);

        println!(
            "Register value after write: {:?}",
            PhyControlReg::from(self.phy_read(phy_addr, PhyControlReg::ADDR))
        );
    }

    fn tx_busy(&mut self) -> bool {
        self.regs.tx_control.control.read().busy()
    }

    pub fn transmit_frame(&mut self, dest: MacAddress, data: Vec<u8, MAX_DATA_SIZE>) {
        while self.tx_busy() {}

        // Write TX buffer.
        let packet_buffer = PacketBuffer::new(dest, self.mac, data);
        self.regs.tx_buffer.write_aligned(&packet_buffer);

        // Write length of payload and header to TX control register bank.
        println!(
            "Writing length: {:?}",
            TxPacketLengthReg::new(packet_buffer.packet_len() as u16)
        );
        unsafe {
            self.regs
                .tx_control
                .packet_length
                .write(TxPacketLengthReg::new(packet_buffer.packet_len() as u16));
        }

        println!(
            "Starting to send frame: {:?} -> {:?}",
            self.regs.rx_control.control.read(),
            self.regs.rx_buffer.read_aligned()
        );
        print_bytes(self.regs.rx_buffer.read_aligned().bytes());

        // Dispatch the transaction.
        unsafe {
            self.regs.tx_control.control.modify(|mut control| {
                // control.set_loopback(true);
                control.set_busy(true);
                control
            });
        }

        // // Spin until complete.
        // while self.tx_busy() {}
    }

    fn rx_done(&mut self) -> bool {
        self.regs.rx_control.control.read().done()
    }

    // pub fn receive_frame(&mut self) -> Result<PacketBuffer, ()> {
    //     println!(
    //         "Waiting for frame: {:?} -> {:?}",
    //         self.regs.rx_control.control.read(),
    //         self.regs.rx_buffer.read_aligned()
    //     );

    //     if self.rx_done() {
    //         Ok(self.regs.rx_buffer.read_aligned())
    //     } else {
    //         Err(())
    //     }
    // }

    pub fn receive_frame(&mut self) {
        println!("Waiting for frame...");

        println!(
            "Waiting for frame: {:?} -> {:?}",
            self.regs.rx_control.control.read(),
            self.regs.rx_buffer.read_aligned()
        );

        while !self.rx_done() {
            println!(
                "Spinning: {:?} -> {:?}",
                self.regs.rx_control.control.read(),
                self.regs.rx_buffer.read_aligned(),
            );
            print_bytes(self.regs.rx_buffer.read_aligned().bytes());
            delay_ms(1000);
        }

        println!(
            "Packet received: {:?} -> {:?}",
            self.regs.rx_control.control.read(),
            self.regs.rx_buffer.read_aligned()
        );
        print_bytes(self.regs.rx_buffer.read_aligned().bytes());
    }

    pub fn flush_receive(&mut self) {
        unsafe {
            self.regs.rx_control.control.modify(|mut control| {
                control.set_done(false);
                control
            });
        }
    }
}

fn print_bytes(bytes: &[u8]) {
    for byte in bytes {
        print!("{:02X} ", byte);
    }
    println!("");
}
