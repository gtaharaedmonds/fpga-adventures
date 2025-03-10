#[repr(C)]
#[doc = "Register block"]
pub struct RegisterBlock {
    ctrl: Ctrl,
    dc0: Dc0,
    dc1: Dc1,
    dc2: Dc2,
}
impl RegisterBlock {
    #[doc = "0x00 - Control register"]
    #[inline(always)]
    pub const fn ctrl(&self) -> &Ctrl {
        &self.ctrl
    }
    #[doc = "0x04 - Duty cycle register 0"]
    #[inline(always)]
    pub const fn dc0(&self) -> &Dc0 {
        &self.dc0
    }
    #[doc = "0x08 - Duty cycle register 1"]
    #[inline(always)]
    pub const fn dc1(&self) -> &Dc1 {
        &self.dc1
    }
    #[doc = "0x0c - Duty cycle register 2"]
    #[inline(always)]
    pub const fn dc2(&self) -> &Dc2 {
        &self.dc2
    }
}
#[doc = "CTRL (rw) register accessor: Control register\n\nYou can [`read`](crate::Reg::read) this register and get [`ctrl::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`ctrl::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@ctrl`] module"]
#[doc(alias = "CTRL")]
pub type Ctrl = crate::Reg<ctrl::CtrlSpec>;
#[doc = "Control register"]
pub mod ctrl;
#[doc = "DC[0] (rw) register accessor: Duty cycle register 0\n\nYou can [`read`](crate::Reg::read) this register and get [`dc0::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`dc0::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@dc0`] module"]
#[doc(alias = "DC[0]")]
pub type Dc0 = crate::Reg<dc0::Dc0Spec>;
#[doc = "Duty cycle register 0"]
pub mod dc0;
#[doc = "DC[1] (rw) register accessor: Duty cycle register 1\n\nYou can [`read`](crate::Reg::read) this register and get [`dc1::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`dc1::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@dc1`] module"]
#[doc(alias = "DC[1]")]
pub type Dc1 = crate::Reg<dc1::Dc1Spec>;
#[doc = "Duty cycle register 1"]
pub mod dc1;
#[doc = "DC[2] (rw) register accessor: Duty cycle register 2\n\nYou can [`read`](crate::Reg::read) this register and get [`dc2::R`]. You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`dc2::W`]. You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api).\n\nFor information about available fields see [`mod@dc2`] module"]
#[doc(alias = "DC[2]")]
pub type Dc2 = crate::Reg<dc2::Dc2Spec>;
#[doc = "Duty cycle register 2"]
pub mod dc2;
