#[doc = "Register `CTRL` reader"]
pub type R = crate::R<CtrlSpec>;
#[doc = "Register `CTRL` writer"]
pub type W = crate::W<CtrlSpec>;
#[doc = "Field `SLINK_CTRL_EN` reader - SLINK enable flag"]
pub type SlinkCtrlEnR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_EN` writer - SLINK enable flag"]
pub type SlinkCtrlEnW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SLINK_CTRL_RX_CLR` reader - Clear RX FIFO (auto-clears)"]
pub type SlinkCtrlRxClrR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_RX_CLR` writer - Clear RX FIFO (auto-clears)"]
pub type SlinkCtrlRxClrW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SLINK_CTRL_TX_CLR` reader - Clear TX FIFO (auto-clears)"]
pub type SlinkCtrlTxClrR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_TX_CLR` writer - Clear TX FIFO (auto-clears)"]
pub type SlinkCtrlTxClrW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SLINK_CTRL_RX_LAST` reader - RX link end-of-stream delimiter"]
pub type SlinkCtrlRxLastR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_RX_LAST` writer - RX link end-of-stream delimiter"]
pub type SlinkCtrlRxLastW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SLINK_CTRL_RX_EMPTY` reader - RX FIFO empty"]
pub type SlinkCtrlRxEmptyR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_RX_HALF` reader - RX FIFO at least half full"]
pub type SlinkCtrlRxHalfR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_RX_FULL` reader - RX FIFO full"]
pub type SlinkCtrlRxFullR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_TX_EMPTY` reader - TX FIFO empty"]
pub type SlinkCtrlTxEmptyR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_TX_HALF` reader - TX FIFO at least half full"]
pub type SlinkCtrlTxHalfR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_TX_FULL` reader - TX FIFO full"]
pub type SlinkCtrlTxFullR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_IRQ_RX_NEMPTY` reader - RX interrupt if RX FIFO not empty"]
pub type SlinkCtrlIrqRxNemptyR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_IRQ_RX_NEMPTY` writer - RX interrupt if RX FIFO not empty"]
pub type SlinkCtrlIrqRxNemptyW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SLINK_CTRL_IRQ_RX_HALF` reader - RX interrupt if RX FIFO at least half full"]
pub type SlinkCtrlIrqRxHalfR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_IRQ_RX_HALF` writer - RX interrupt if RX FIFO at least half full"]
pub type SlinkCtrlIrqRxHalfW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SLINK_CTRL_IRQ_RX_FULL` reader - RX interrupt if RX FIFO full"]
pub type SlinkCtrlIrqRxFullR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_IRQ_RX_FULL` writer - RX interrupt if RX FIFO full"]
pub type SlinkCtrlIrqRxFullW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SLINK_CTRL_IRQ_TX_EMPTY` reader - TX interrupt if TX FIFO empty"]
pub type SlinkCtrlIrqTxEmptyR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_IRQ_TX_EMPTY` writer - TX interrupt if TX FIFO empty"]
pub type SlinkCtrlIrqTxEmptyW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SLINK_CTRL_IRQ_TX_NHALF` reader - TX interrupt if TX FIFO not at least half full"]
pub type SlinkCtrlIrqTxNhalfR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_IRQ_TX_NHALF` writer - TX interrupt if TX FIFO not at least half full"]
pub type SlinkCtrlIrqTxNhalfW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SLINK_CTRL_IRQ_TX_NFULL` reader - TX interrupt if TX FIFO not full"]
pub type SlinkCtrlIrqTxNfullR = crate::BitReader;
#[doc = "Field `SLINK_CTRL_IRQ_TX_NFULL` writer - TX interrupt if TX FIFO not full"]
pub type SlinkCtrlIrqTxNfullW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `SLINK_CTRL_RX_FIFO` reader - log2(RX FIFO size)"]
pub type SlinkCtrlRxFifoR = crate::FieldReader;
#[doc = "Field `SLINK_CTRL_TX_FIFO` reader - log2(TX FIFO size)"]
pub type SlinkCtrlTxFifoR = crate::FieldReader;
impl R {
    #[doc = "Bit 0 - SLINK enable flag"]
    #[inline(always)]
    pub fn slink_ctrl_en(&self) -> SlinkCtrlEnR {
        SlinkCtrlEnR::new((self.bits & 1) != 0)
    }
    #[doc = "Bit 1 - Clear RX FIFO (auto-clears)"]
    #[inline(always)]
    pub fn slink_ctrl_rx_clr(&self) -> SlinkCtrlRxClrR {
        SlinkCtrlRxClrR::new(((self.bits >> 1) & 1) != 0)
    }
    #[doc = "Bit 2 - Clear TX FIFO (auto-clears)"]
    #[inline(always)]
    pub fn slink_ctrl_tx_clr(&self) -> SlinkCtrlTxClrR {
        SlinkCtrlTxClrR::new(((self.bits >> 2) & 1) != 0)
    }
    #[doc = "Bit 4 - RX link end-of-stream delimiter"]
    #[inline(always)]
    pub fn slink_ctrl_rx_last(&self) -> SlinkCtrlRxLastR {
        SlinkCtrlRxLastR::new(((self.bits >> 4) & 1) != 0)
    }
    #[doc = "Bit 8 - RX FIFO empty"]
    #[inline(always)]
    pub fn slink_ctrl_rx_empty(&self) -> SlinkCtrlRxEmptyR {
        SlinkCtrlRxEmptyR::new(((self.bits >> 8) & 1) != 0)
    }
    #[doc = "Bit 9 - RX FIFO at least half full"]
    #[inline(always)]
    pub fn slink_ctrl_rx_half(&self) -> SlinkCtrlRxHalfR {
        SlinkCtrlRxHalfR::new(((self.bits >> 9) & 1) != 0)
    }
    #[doc = "Bit 10 - RX FIFO full"]
    #[inline(always)]
    pub fn slink_ctrl_rx_full(&self) -> SlinkCtrlRxFullR {
        SlinkCtrlRxFullR::new(((self.bits >> 10) & 1) != 0)
    }
    #[doc = "Bit 11 - TX FIFO empty"]
    #[inline(always)]
    pub fn slink_ctrl_tx_empty(&self) -> SlinkCtrlTxEmptyR {
        SlinkCtrlTxEmptyR::new(((self.bits >> 11) & 1) != 0)
    }
    #[doc = "Bit 12 - TX FIFO at least half full"]
    #[inline(always)]
    pub fn slink_ctrl_tx_half(&self) -> SlinkCtrlTxHalfR {
        SlinkCtrlTxHalfR::new(((self.bits >> 12) & 1) != 0)
    }
    #[doc = "Bit 13 - TX FIFO full"]
    #[inline(always)]
    pub fn slink_ctrl_tx_full(&self) -> SlinkCtrlTxFullR {
        SlinkCtrlTxFullR::new(((self.bits >> 13) & 1) != 0)
    }
    #[doc = "Bit 16 - RX interrupt if RX FIFO not empty"]
    #[inline(always)]
    pub fn slink_ctrl_irq_rx_nempty(&self) -> SlinkCtrlIrqRxNemptyR {
        SlinkCtrlIrqRxNemptyR::new(((self.bits >> 16) & 1) != 0)
    }
    #[doc = "Bit 17 - RX interrupt if RX FIFO at least half full"]
    #[inline(always)]
    pub fn slink_ctrl_irq_rx_half(&self) -> SlinkCtrlIrqRxHalfR {
        SlinkCtrlIrqRxHalfR::new(((self.bits >> 17) & 1) != 0)
    }
    #[doc = "Bit 18 - RX interrupt if RX FIFO full"]
    #[inline(always)]
    pub fn slink_ctrl_irq_rx_full(&self) -> SlinkCtrlIrqRxFullR {
        SlinkCtrlIrqRxFullR::new(((self.bits >> 18) & 1) != 0)
    }
    #[doc = "Bit 19 - TX interrupt if TX FIFO empty"]
    #[inline(always)]
    pub fn slink_ctrl_irq_tx_empty(&self) -> SlinkCtrlIrqTxEmptyR {
        SlinkCtrlIrqTxEmptyR::new(((self.bits >> 19) & 1) != 0)
    }
    #[doc = "Bit 20 - TX interrupt if TX FIFO not at least half full"]
    #[inline(always)]
    pub fn slink_ctrl_irq_tx_nhalf(&self) -> SlinkCtrlIrqTxNhalfR {
        SlinkCtrlIrqTxNhalfR::new(((self.bits >> 20) & 1) != 0)
    }
    #[doc = "Bit 21 - TX interrupt if TX FIFO not full"]
    #[inline(always)]
    pub fn slink_ctrl_irq_tx_nfull(&self) -> SlinkCtrlIrqTxNfullR {
        SlinkCtrlIrqTxNfullR::new(((self.bits >> 21) & 1) != 0)
    }
    #[doc = "Bits 24:27 - log2(RX FIFO size)"]
    #[inline(always)]
    pub fn slink_ctrl_rx_fifo(&self) -> SlinkCtrlRxFifoR {
        SlinkCtrlRxFifoR::new(((self.bits >> 24) & 0x0f) as u8)
    }
    #[doc = "Bits 28:31 - log2(TX FIFO size)"]
    #[inline(always)]
    pub fn slink_ctrl_tx_fifo(&self) -> SlinkCtrlTxFifoR {
        SlinkCtrlTxFifoR::new(((self.bits >> 28) & 0x0f) as u8)
    }
}
impl W {
    #[doc = "Bit 0 - SLINK enable flag"]
    #[inline(always)]
    pub fn slink_ctrl_en(&mut self) -> SlinkCtrlEnW<CtrlSpec> {
        SlinkCtrlEnW::new(self, 0)
    }
    #[doc = "Bit 1 - Clear RX FIFO (auto-clears)"]
    #[inline(always)]
    pub fn slink_ctrl_rx_clr(&mut self) -> SlinkCtrlRxClrW<CtrlSpec> {
        SlinkCtrlRxClrW::new(self, 1)
    }
    #[doc = "Bit 2 - Clear TX FIFO (auto-clears)"]
    #[inline(always)]
    pub fn slink_ctrl_tx_clr(&mut self) -> SlinkCtrlTxClrW<CtrlSpec> {
        SlinkCtrlTxClrW::new(self, 2)
    }
    #[doc = "Bit 4 - RX link end-of-stream delimiter"]
    #[inline(always)]
    pub fn slink_ctrl_rx_last(&mut self) -> SlinkCtrlRxLastW<CtrlSpec> {
        SlinkCtrlRxLastW::new(self, 4)
    }
    #[doc = "Bit 16 - RX interrupt if RX FIFO not empty"]
    #[inline(always)]
    pub fn slink_ctrl_irq_rx_nempty(&mut self) -> SlinkCtrlIrqRxNemptyW<CtrlSpec> {
        SlinkCtrlIrqRxNemptyW::new(self, 16)
    }
    #[doc = "Bit 17 - RX interrupt if RX FIFO at least half full"]
    #[inline(always)]
    pub fn slink_ctrl_irq_rx_half(&mut self) -> SlinkCtrlIrqRxHalfW<CtrlSpec> {
        SlinkCtrlIrqRxHalfW::new(self, 17)
    }
    #[doc = "Bit 18 - RX interrupt if RX FIFO full"]
    #[inline(always)]
    pub fn slink_ctrl_irq_rx_full(&mut self) -> SlinkCtrlIrqRxFullW<CtrlSpec> {
        SlinkCtrlIrqRxFullW::new(self, 18)
    }
    #[doc = "Bit 19 - TX interrupt if TX FIFO empty"]
    #[inline(always)]
    pub fn slink_ctrl_irq_tx_empty(&mut self) -> SlinkCtrlIrqTxEmptyW<CtrlSpec> {
        SlinkCtrlIrqTxEmptyW::new(self, 19)
    }
    #[doc = "Bit 20 - TX interrupt if TX FIFO not at least half full"]
    #[inline(always)]
    pub fn slink_ctrl_irq_tx_nhalf(&mut self) -> SlinkCtrlIrqTxNhalfW<CtrlSpec> {
        SlinkCtrlIrqTxNhalfW::new(self, 20)
    }
    #[doc = "Bit 21 - TX interrupt if TX FIFO not full"]
    #[inline(always)]
    pub fn slink_ctrl_irq_tx_nfull(&mut self) -> SlinkCtrlIrqTxNfullW<CtrlSpec> {
        SlinkCtrlIrqTxNfullW::new(self, 21)
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
