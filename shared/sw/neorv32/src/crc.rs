#[repr(C)]
#[doc = "Register block"]
pub struct RegisterBlock {
    mode: Mode,
    poly: Poly,
    data: Data,
    sreg: Sreg,
}
impl RegisterBlock {
    #[doc = "0x00 - CRC mode control (CRC8, CRC16, CRC32)"]
    #[inline(always)]
    pub const fn mode(&self) -> &Mode {
        &self.mode
    }
    #[doc = "0x04 - CRC polynomial"]
    #[inline(always)]
    pub const fn poly(&self) -> &Poly {
        &self.poly
    }
    #[doc = "0x08 - LSB-aligned data input (bytes)"]
    #[inline(always)]
    pub const fn data(&self) -> &Data {
        &self.data
    }
    #[doc = "0x0c - CRC shift register"]
    #[inline(always)]
    pub const fn sreg(&self) -> &Sreg {
        &self.sreg
    }
}
#[doc = "MODE (rw) register accessor: CRC mode control (CRC8, CRC16, CRC32)\n\nYou can [`read`](crate::Reg::read) this register and get [`mode::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`mode::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@mode`] module"]
#[doc(alias = "MODE")]
pub type Mode = crate::Reg<mode::ModeSpec>;
#[doc = "CRC mode control (CRC8, CRC16, CRC32)"]
pub mod mode;
#[doc = "POLY (rw) register accessor: CRC polynomial\n\nYou can [`read`](crate::Reg::read) this register and get [`poly::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`poly::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@poly`] module"]
#[doc(alias = "POLY")]
pub type Poly = crate::Reg<poly::PolySpec>;
#[doc = "CRC polynomial"]
pub mod poly;
#[doc = "DATA (rw) register accessor: LSB-aligned data input (bytes)\n\nYou can [`read`](crate::Reg::read) this register and get [`data::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`data::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@data`] module"]
#[doc(alias = "DATA")]
pub type Data = crate::Reg<data::DataSpec>;
#[doc = "LSB-aligned data input (bytes)"]
pub mod data;
#[doc = "SREG (rw) register accessor: CRC shift register\n\nYou can [`read`](crate::Reg::read) this register and get [`sreg::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`sreg::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@sreg`] module"]
#[doc(alias = "SREG")]
pub type Sreg = crate::Reg<sreg::SregSpec>;
#[doc = "CRC shift register"]
pub mod sreg;
