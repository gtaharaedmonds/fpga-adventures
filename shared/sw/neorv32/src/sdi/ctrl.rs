#[doc = "Register `CTRL` reader"]
pub type R = crate::R<CtrlSpec>;
#[doc = "Register `CTRL` writer"]
pub type W = crate::W<CtrlSpec>;
#[doc = "Field `SDI_CTRL_EN` reader - SDI enable flag"]
pub type SdiCtrlEnR = crate::BitReader;
#[doc = "Field `SDI_CTRL_EN` writer - SDI enable flag"]
pub type SdiCtrlEnW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SDI_CTRL_FIFO` reader - Log2 of SDI FIFO size"]
pub type SdiCtrlFifoR = crate::FieldReader;
#[doc = "Field `SDI_CTRL_FIFO` writer - Log2 of SDI FIFO size"]
pub type SdiCtrlFifoW<'a, REG> = crate::FieldWriter<'a, REG, 4>;
#[doc = "Field `SDI_CTRL_IRQ_RX_AVAIL` reader - Fire interrupt if RX FIFO is not empty"]
pub type SdiCtrlIrqRxAvailR = crate::BitReader;
#[doc = "Field `SDI_CTRL_IRQ_RX_AVAIL` writer - Fire interrupt if RX FIFO is not empty"]
pub type SdiCtrlIrqRxAvailW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SDI_CTRL_IRQ_RX_HALF` reader - Fire interrupt if RX FIFO is at least half full"]
pub type SdiCtrlIrqRxHalfR = crate::BitReader;
#[doc = "Field `SDI_CTRL_IRQ_RX_HALF` writer - Fire interrupt if RX FIFO is at least half full"]
pub type SdiCtrlIrqRxHalfW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SDI_CTRL_IRQ_RX_FULL` reader - Fire interrupt if RX FIFO is full"]
pub type SdiCtrlIrqRxFullR = crate::BitReader;
#[doc = "Field `SDI_CTRL_IRQ_RX_FULL` writer - Fire interrupt if RX FIFO is full"]
pub type SdiCtrlIrqRxFullW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SDI_CTRL_IRQ_TX_EMPTY` reader - Fire interrupt if TX FIFO is empty"]
pub type SdiCtrlIrqTxEmptyR = crate::BitReader;
#[doc = "Field `SDI_CTRL_IRQ_TX_EMPTY` writer - Fire interrupt if TX FIFO is empty"]
pub type SdiCtrlIrqTxEmptyW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SDI_CTRL_IRQ_TX_NHALF` reader - Fire interrupt if TX FIFO is not at least half full"]
pub type SdiCtrlIrqTxNhalfR = crate::BitReader;
#[doc = "Field `SDI_CTRL_IRQ_TX_NHALF` writer - Fire interrupt if TX FIFO is not at least half full"]
pub type SdiCtrlIrqTxNhalfW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SDI_CTRL_RX_AVAIL` reader - RX FIFO not empty (data available)"]
pub type SdiCtrlRxAvailR = crate::BitReader;
#[doc = "Field `SDI_CTRL_RX_HALF` reader - RX FIFO at least half full"]
pub type SdiCtrlRxHalfR = crate::BitReader;
#[doc = "Field `SDI_CTRL_RX_FULL` reader - RX FIFO full"]
pub type SdiCtrlRxFullR = crate::BitReader;
#[doc = "Field `SDI_CTRL_TX_EMPTY` reader - TX FIFO empty"]
pub type SdiCtrlTxEmptyR = crate::BitReader;
#[doc = "Field `SDI_CTRL_TX_NHALF` reader - TX FIFO not at least half full"]
pub type SdiCtrlTxNhalfR = crate::BitReader;
#[doc = "Field `SDI_CTRL_TX_FULL` reader - TX FIFO full"]
pub type SdiCtrlTxFullR = crate::BitReader;
#[doc = "Field `SDI_CTRL_CS_ACTIVE` reader - Chip-select line is active when set"]
pub type SdiCtrlCsActiveR = crate::BitReader;
impl R {
    #[doc = "Bit 0 - SDI enable flag"]
    #[inline(always)]
    pub fn sdi_ctrl_en(&self) -> SdiCtrlEnR {
        SdiCtrlEnR::new((self.bits & 1) != 0)
    }
    #[doc = "Bits 4:7 - Log2 of SDI FIFO size"]
    #[inline(always)]
    pub fn sdi_ctrl_fifo(&self) -> SdiCtrlFifoR {
        SdiCtrlFifoR::new(((self.bits >> 4) & 0x0f) as u8)
    }
    #[doc = "Bit 15 - Fire interrupt if RX FIFO is not empty"]
    #[inline(always)]
    pub fn sdi_ctrl_irq_rx_avail(&self) -> SdiCtrlIrqRxAvailR {
        SdiCtrlIrqRxAvailR::new(((self.bits >> 15) & 1) != 0)
    }
    #[doc = "Bit 16 - Fire interrupt if RX FIFO is at least half full"]
    #[inline(always)]
    pub fn sdi_ctrl_irq_rx_half(&self) -> SdiCtrlIrqRxHalfR {
        SdiCtrlIrqRxHalfR::new(((self.bits >> 16) & 1) != 0)
    }
    #[doc = "Bit 17 - Fire interrupt if RX FIFO is full"]
    #[inline(always)]
    pub fn sdi_ctrl_irq_rx_full(&self) -> SdiCtrlIrqRxFullR {
        SdiCtrlIrqRxFullR::new(((self.bits >> 17) & 1) != 0)
    }
    #[doc = "Bit 18 - Fire interrupt if TX FIFO is empty"]
    #[inline(always)]
    pub fn sdi_ctrl_irq_tx_empty(&self) -> SdiCtrlIrqTxEmptyR {
        SdiCtrlIrqTxEmptyR::new(((self.bits >> 18) & 1) != 0)
    }
    #[doc = "Bit 19 - Fire interrupt if TX FIFO is not at least half full"]
    #[inline(always)]
    pub fn sdi_ctrl_irq_tx_nhalf(&self) -> SdiCtrlIrqTxNhalfR {
        SdiCtrlIrqTxNhalfR::new(((self.bits >> 19) & 1) != 0)
    }
    #[doc = "Bit 23 - RX FIFO not empty (data available)"]
    #[inline(always)]
    pub fn sdi_ctrl_rx_avail(&self) -> SdiCtrlRxAvailR {
        SdiCtrlRxAvailR::new(((self.bits >> 23) & 1) != 0)
    }
    #[doc = "Bit 24 - RX FIFO at least half full"]
    #[inline(always)]
    pub fn sdi_ctrl_rx_half(&self) -> SdiCtrlRxHalfR {
        SdiCtrlRxHalfR::new(((self.bits >> 24) & 1) != 0)
    }
    #[doc = "Bit 25 - RX FIFO full"]
    #[inline(always)]
    pub fn sdi_ctrl_rx_full(&self) -> SdiCtrlRxFullR {
        SdiCtrlRxFullR::new(((self.bits >> 25) & 1) != 0)
    }
    #[doc = "Bit 26 - TX FIFO empty"]
    #[inline(always)]
    pub fn sdi_ctrl_tx_empty(&self) -> SdiCtrlTxEmptyR {
        SdiCtrlTxEmptyR::new(((self.bits >> 26) & 1) != 0)
    }
    #[doc = "Bit 27 - TX FIFO not at least half full"]
    #[inline(always)]
    pub fn sdi_ctrl_tx_nhalf(&self) -> SdiCtrlTxNhalfR {
        SdiCtrlTxNhalfR::new(((self.bits >> 27) & 1) != 0)
    }
    #[doc = "Bit 28 - TX FIFO full"]
    #[inline(always)]
    pub fn sdi_ctrl_tx_full(&self) -> SdiCtrlTxFullR {
        SdiCtrlTxFullR::new(((self.bits >> 28) & 1) != 0)
    }
    #[doc = "Bit 31 - Chip-select line is active when set"]
    #[inline(always)]
    pub fn sdi_ctrl_cs_active(&self) -> SdiCtrlCsActiveR {
        SdiCtrlCsActiveR::new(((self.bits >> 31) & 1) != 0)
    }
}
impl W {
    #[doc = "Bit 0 - SDI enable flag"]
    #[inline(always)]
    pub fn sdi_ctrl_en(&mut self) -> SdiCtrlEnW<CtrlSpec> {
        SdiCtrlEnW::new(self, 0)
    }
    #[doc = "Bits 4:7 - Log2 of SDI FIFO size"]
    #[inline(always)]
    pub fn sdi_ctrl_fifo(&mut self) -> SdiCtrlFifoW<CtrlSpec> {
        SdiCtrlFifoW::new(self, 4)
    }
    #[doc = "Bit 15 - Fire interrupt if RX FIFO is not empty"]
    #[inline(always)]
    pub fn sdi_ctrl_irq_rx_avail(&mut self) -> SdiCtrlIrqRxAvailW<CtrlSpec> {
        SdiCtrlIrqRxAvailW::new(self, 15)
    }
    #[doc = "Bit 16 - Fire interrupt if RX FIFO is at least half full"]
    #[inline(always)]
    pub fn sdi_ctrl_irq_rx_half(&mut self) -> SdiCtrlIrqRxHalfW<CtrlSpec> {
        SdiCtrlIrqRxHalfW::new(self, 16)
    }
    #[doc = "Bit 17 - Fire interrupt if RX FIFO is full"]
    #[inline(always)]
    pub fn sdi_ctrl_irq_rx_full(&mut self) -> SdiCtrlIrqRxFullW<CtrlSpec> {
        SdiCtrlIrqRxFullW::new(self, 17)
    }
    #[doc = "Bit 18 - Fire interrupt if TX FIFO is empty"]
    #[inline(always)]
    pub fn sdi_ctrl_irq_tx_empty(&mut self) -> SdiCtrlIrqTxEmptyW<CtrlSpec> {
        SdiCtrlIrqTxEmptyW::new(self, 18)
    }
    #[doc = "Bit 19 - Fire interrupt if TX FIFO is not at least half full"]
    #[inline(always)]
    pub fn sdi_ctrl_irq_tx_nhalf(&mut self) -> SdiCtrlIrqTxNhalfW<CtrlSpec> {
        SdiCtrlIrqTxNhalfW::new(self, 19)
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
