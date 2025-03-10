#[doc = "Register `CTRL` reader"]
pub type R = crate::R<CtrlSpec>;
#[doc = "Register `CTRL` writer"]
pub type W = crate::W<CtrlSpec>;
#[doc = "Field `NEOLED_CTRL_EN` reader - NEOLED enable flag"]
pub type NeoledCtrlEnR = crate::BitReader;
#[doc = "Field `NEOLED_CTRL_EN` writer - NEOLED enable flag"]
pub type NeoledCtrlEnW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `NEOLED_CTRL_MODE` reader - TX mode (0=24-bit, 1=32-bit)"]
pub type NeoledCtrlModeR = crate::BitReader;
#[doc = "Field `NEOLED_CTRL_MODE` writer - TX mode (0=24-bit, 1=32-bit)"]
pub type NeoledCtrlModeW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `NEOLED_CTRL_STROBE` reader - Strobe (0=send normal data, 1=send RESET command on data write)"]
pub type NeoledCtrlStrobeR = crate::BitReader;
#[doc = "Field `NEOLED_CTRL_STROBE` writer - Strobe (0=send normal data, 1=send RESET command on data write)"]
pub type NeoledCtrlStrobeW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `NEOLED_CTRL_PRSC` reader - Clock prescaler select"]
pub type NeoledCtrlPrscR = crate::FieldReader;
#[doc = "Field `NEOLED_CTRL_PRSC` writer - Clock prescaler select"]
pub type NeoledCtrlPrscW<'a, REG> = crate::FieldWriter<'a, REG, 3>;
#[doc = "Field `NEOLED_CTRL_BUFS` reader - log2(tx buffer size)"]
pub type NeoledCtrlBufsR = crate::FieldReader;
#[doc = "Field `NEOLED_CTRL_T_TOT` reader - pulse-clock ticks per total period bit"]
pub type NeoledCtrlTTotR = crate::FieldReader;
#[doc = "Field `NEOLED_CTRL_T_TOT` writer - pulse-clock ticks per total period bit"]
pub type NeoledCtrlTTotW<'a, REG> = crate::FieldWriter<'a, REG, 5>;
#[doc = "Field `NEOLED_CTRL_T_ZERO_H` reader - pulse-clock ticks per ZERO high-time"]
pub type NeoledCtrlTZeroHR = crate::FieldReader;
#[doc = "Field `NEOLED_CTRL_T_ZERO_H` writer - pulse-clock ticks per ZERO high-time"]
pub type NeoledCtrlTZeroHW<'a, REG> = crate::FieldWriter<'a, REG, 5>;
#[doc = "Field `NEOLED_CTRL_T_ONE_H` reader - pulse-clock ticks per ONE high-time"]
pub type NeoledCtrlTOneHR = crate::FieldReader;
#[doc = "Field `NEOLED_CTRL_T_ONE_H` writer - pulse-clock ticks per ONE high-time"]
pub type NeoledCtrlTOneHW<'a, REG> = crate::FieldWriter<'a, REG, 5>;
#[doc = "Field `NEOLED_CTRL_IRQ_CONF` reader - TX FIFO interrupt: 0=IRQ if FIFO is less than half-full, 1=IRQ if FIFO is empty"]
pub type NeoledCtrlIrqConfR = crate::BitReader;
#[doc = "Field `NEOLED_CTRL_IRQ_CONF` writer - TX FIFO interrupt: 0=IRQ if FIFO is less than half-full, 1=IRQ if FIFO is empty"]
pub type NeoledCtrlIrqConfW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `NEOLED_CTRL_TX_EMPTY` reader - TX FIFO is empty"]
pub type NeoledCtrlTxEmptyR = crate::BitReader;
#[doc = "Field `NEOLED_CTRL_TX_HALF` reader - TX FIFO is at least half-full"]
pub type NeoledCtrlTxHalfR = crate::BitReader;
#[doc = "Field `NEOLED_CTRL_TX_FULL` reader - TX FIFO is full"]
pub type NeoledCtrlTxFullR = crate::BitReader;
#[doc = "Field `NEOLED_CTRL_TX_BUSY` reader - busy flag"]
pub type NeoledCtrlTxBusyR = crate::BitReader;
impl R {
    #[doc = "Bit 0 - NEOLED enable flag"]
    #[inline(always)]
    pub fn neoled_ctrl_en(&self) -> NeoledCtrlEnR {
        NeoledCtrlEnR::new((self.bits & 1) != 0)
    }
    #[doc = "Bit 1 - TX mode (0=24-bit, 1=32-bit)"]
    #[inline(always)]
    pub fn neoled_ctrl_mode(&self) -> NeoledCtrlModeR {
        NeoledCtrlModeR::new(((self.bits >> 1) & 1) != 0)
    }
    #[doc = "Bit 2 - Strobe (0=send normal data, 1=send RESET command on data write)"]
    #[inline(always)]
    pub fn neoled_ctrl_strobe(&self) -> NeoledCtrlStrobeR {
        NeoledCtrlStrobeR::new(((self.bits >> 2) & 1) != 0)
    }
    #[doc = "Bits 3:5 - Clock prescaler select"]
    #[inline(always)]
    pub fn neoled_ctrl_prsc(&self) -> NeoledCtrlPrscR {
        NeoledCtrlPrscR::new(((self.bits >> 3) & 7) as u8)
    }
    #[doc = "Bits 6:9 - log2(tx buffer size)"]
    #[inline(always)]
    pub fn neoled_ctrl_bufs(&self) -> NeoledCtrlBufsR {
        NeoledCtrlBufsR::new(((self.bits >> 6) & 0x0f) as u8)
    }
    #[doc = "Bits 10:14 - pulse-clock ticks per total period bit"]
    #[inline(always)]
    pub fn neoled_ctrl_t_tot(&self) -> NeoledCtrlTTotR {
        NeoledCtrlTTotR::new(((self.bits >> 10) & 0x1f) as u8)
    }
    #[doc = "Bits 15:19 - pulse-clock ticks per ZERO high-time"]
    #[inline(always)]
    pub fn neoled_ctrl_t_zero_h(&self) -> NeoledCtrlTZeroHR {
        NeoledCtrlTZeroHR::new(((self.bits >> 15) & 0x1f) as u8)
    }
    #[doc = "Bits 20:24 - pulse-clock ticks per ONE high-time"]
    #[inline(always)]
    pub fn neoled_ctrl_t_one_h(&self) -> NeoledCtrlTOneHR {
        NeoledCtrlTOneHR::new(((self.bits >> 20) & 0x1f) as u8)
    }
    #[doc = "Bit 27 - TX FIFO interrupt: 0=IRQ if FIFO is less than half-full, 1=IRQ if FIFO is empty"]
    #[inline(always)]
    pub fn neoled_ctrl_irq_conf(&self) -> NeoledCtrlIrqConfR {
        NeoledCtrlIrqConfR::new(((self.bits >> 27) & 1) != 0)
    }
    #[doc = "Bit 28 - TX FIFO is empty"]
    #[inline(always)]
    pub fn neoled_ctrl_tx_empty(&self) -> NeoledCtrlTxEmptyR {
        NeoledCtrlTxEmptyR::new(((self.bits >> 28) & 1) != 0)
    }
    #[doc = "Bit 29 - TX FIFO is at least half-full"]
    #[inline(always)]
    pub fn neoled_ctrl_tx_half(&self) -> NeoledCtrlTxHalfR {
        NeoledCtrlTxHalfR::new(((self.bits >> 29) & 1) != 0)
    }
    #[doc = "Bit 30 - TX FIFO is full"]
    #[inline(always)]
    pub fn neoled_ctrl_tx_full(&self) -> NeoledCtrlTxFullR {
        NeoledCtrlTxFullR::new(((self.bits >> 30) & 1) != 0)
    }
    #[doc = "Bit 31 - busy flag"]
    #[inline(always)]
    pub fn neoled_ctrl_tx_busy(&self) -> NeoledCtrlTxBusyR {
        NeoledCtrlTxBusyR::new(((self.bits >> 31) & 1) != 0)
    }
}
impl W {
    #[doc = "Bit 0 - NEOLED enable flag"]
    #[inline(always)]
    pub fn neoled_ctrl_en(&mut self) -> NeoledCtrlEnW<CtrlSpec> {
        NeoledCtrlEnW::new(self, 0)
    }
    #[doc = "Bit 1 - TX mode (0=24-bit, 1=32-bit)"]
    #[inline(always)]
    pub fn neoled_ctrl_mode(&mut self) -> NeoledCtrlModeW<CtrlSpec> {
        NeoledCtrlModeW::new(self, 1)
    }
    #[doc = "Bit 2 - Strobe (0=send normal data, 1=send RESET command on data write)"]
    #[inline(always)]
    pub fn neoled_ctrl_strobe(&mut self) -> NeoledCtrlStrobeW<CtrlSpec> {
        NeoledCtrlStrobeW::new(self, 2)
    }
    #[doc = "Bits 3:5 - Clock prescaler select"]
    #[inline(always)]
    pub fn neoled_ctrl_prsc(&mut self) -> NeoledCtrlPrscW<CtrlSpec> {
        NeoledCtrlPrscW::new(self, 3)
    }
    #[doc = "Bits 10:14 - pulse-clock ticks per total period bit"]
    #[inline(always)]
    pub fn neoled_ctrl_t_tot(&mut self) -> NeoledCtrlTTotW<CtrlSpec> {
        NeoledCtrlTTotW::new(self, 10)
    }
    #[doc = "Bits 15:19 - pulse-clock ticks per ZERO high-time"]
    #[inline(always)]
    pub fn neoled_ctrl_t_zero_h(&mut self) -> NeoledCtrlTZeroHW<CtrlSpec> {
        NeoledCtrlTZeroHW::new(self, 15)
    }
    #[doc = "Bits 20:24 - pulse-clock ticks per ONE high-time"]
    #[inline(always)]
    pub fn neoled_ctrl_t_one_h(&mut self) -> NeoledCtrlTOneHW<CtrlSpec> {
        NeoledCtrlTOneHW::new(self, 20)
    }
    #[doc = "Bit 27 - TX FIFO interrupt: 0=IRQ if FIFO is less than half-full, 1=IRQ if FIFO is empty"]
    #[inline(always)]
    pub fn neoled_ctrl_irq_conf(&mut self) -> NeoledCtrlIrqConfW<CtrlSpec> {
        NeoledCtrlIrqConfW::new(self, 27)
    }
}
#[doc = "Control register\n\nYou can [`read`](crate::Reg::read) this register and get [`ctrl::R`](R). You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`ctrl::W`](W). You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api)."]
pub struct CtrlSpec;
impl crate::RegisterSpec for CtrlSpec {
    type Ux = u32;
}
#[doc = "`read()` method returns [`ctrl::R`](R) reader structure"]
impl crate::Readable for CtrlSpec {}
#[doc = "`write(|w| ..)` method takes [`ctrl::W`](W) writer structure"]
impl crate::Writable for CtrlSpec {
    type Safety = crate::Unsafe;
}
#[doc = "`reset()` method sets CTRL to value 0"]
impl crate::Resettable for CtrlSpec {}
