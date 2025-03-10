#[repr(C)]
#[doc = "Register block"]
pub struct RegisterBlock {
    ctrl: Ctrl,
    src_base: SrcBase,
    dst_base: DstBase,
    ttype: Ttype,
}
impl RegisterBlock {
    #[doc = "0x00 - Control register"]
    #[inline(always)]
    pub const fn ctrl(&self) -> &Ctrl {
        &self.ctrl
    }
    #[doc = "0x04 - Source base address; shows the last accessed read address on read access"]
    #[inline(always)]
    pub const fn src_base(&self) -> &SrcBase {
        &self.src_base
    }
    #[doc = "0x08 - Destination base address; shows the last accessed write address on read access"]
    #[inline(always)]
    pub const fn dst_base(&self) -> &DstBase {
        &self.dst_base
    }
    #[doc = "0x0c - Destination base address; shows the last accessed write address on read access"]
    #[inline(always)]
    pub const fn ttype(&self) -> &Ttype {
        &self.ttype
    }
}
#[doc = "CTRL (rw) register accessor: Control register\n\nYou can [`read`](crate::Reg::read) this register and get [`ctrl::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`ctrl::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@ctrl`] module"]
#[doc(alias = "CTRL")]
pub type Ctrl = crate::Reg<ctrl::CtrlSpec>;
#[doc = "Control register"]
pub mod ctrl;
#[doc = "SRC_BASE (rw) register accessor: Source base address; shows the last accessed read address on read access\n\nYou can [`read`](crate::Reg::read) this register and get [`src_base::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`src_base::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@src_base`] module"]
#[doc(alias = "SRC_BASE")]
pub type SrcBase = crate::Reg<src_base::SrcBaseSpec>;
#[doc = "Source base address; shows the last accessed read address on read access"]
pub mod src_base;
#[doc = "DST_BASE (rw) register accessor: Destination base address; shows the last accessed write address on read access\n\nYou can [`read`](crate::Reg::read) this register and get [`dst_base::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`dst_base::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@dst_base`] module"]
#[doc(alias = "DST_BASE")]
pub type DstBase = crate::Reg<dst_base::DstBaseSpec>;
#[doc = "Destination base address; shows the last accessed write address on read access"]
pub mod dst_base;
#[doc = "TTYPE (rw) register accessor: Destination base address; shows the last accessed write address on read access\n\nYou can [`read`](crate::Reg::read) this register and get [`ttype::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`ttype::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@ttype`] module"]
#[doc(alias = "TTYPE")]
pub type Ttype = crate::Reg<ttype::TtypeSpec>;
#[doc = "Destination base address; shows the last accessed write address on read access"]
pub mod ttype;
