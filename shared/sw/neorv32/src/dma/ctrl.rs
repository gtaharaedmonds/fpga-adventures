#[doc = "Register `CTRL` reader"]
pub type R = crate::R<CtrlSpec>;
#[doc = "Register `CTRL` writer"]
pub type W = crate::W<CtrlSpec>;
#[doc = "Field `DMA_CTRL_EN` reader - DMA enable flag"]
pub type DmaCtrlEnR = crate::BitReader;
#[doc = "Field `DMA_CTRL_EN` writer - DMA enable flag"]
pub type DmaCtrlEnW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `DMA_CTRL_START` reader - Start programmed DMA transfer"]
pub type DmaCtrlStartR = crate::BitReader;
#[doc = "Field `DMA_CTRL_START` writer - Start programmed DMA transfer"]
pub type DmaCtrlStartW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `DMA_CTRL_ERROR_RD` reader - Error during last read access"]
pub type DmaCtrlErrorRdR = crate::BitReader;
#[doc = "Field `DMA_CTRL_ERROR_WR` reader - Error during last write access"]
pub type DmaCtrlErrorWrR = crate::BitReader;
#[doc = "Field `DMA_CTRL_DONE` reader - Transfer done; auto-clears on write access"]
pub type DmaCtrlDoneR = crate::BitReader;
#[doc = "Field `DMA_CTRL_DONE` writer - Transfer done; auto-clears on write access"]
pub type DmaCtrlDoneW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `DMA_CTRL_BUSY` reader - Transfer in progress"]
pub type DmaCtrlBusyR = crate::BitReader;
impl R {
    #[doc = "Bit 0 - DMA enable flag"]
    #[inline(always)]
    pub fn dma_ctrl_en(&self) -> DmaCtrlEnR {
        DmaCtrlEnR::new((self.bits & 1) != 0)
    }
    #[doc = "Bit 1 - Start programmed DMA transfer"]
    #[inline(always)]
    pub fn dma_ctrl_start(&self) -> DmaCtrlStartR {
        DmaCtrlStartR::new(((self.bits >> 1) & 1) != 0)
    }
    #[doc = "Bit 28 - Error during last read access"]
    #[inline(always)]
    pub fn dma_ctrl_error_rd(&self) -> DmaCtrlErrorRdR {
        DmaCtrlErrorRdR::new(((self.bits >> 28) & 1) != 0)
    }
    #[doc = "Bit 29 - Error during last write access"]
    #[inline(always)]
    pub fn dma_ctrl_error_wr(&self) -> DmaCtrlErrorWrR {
        DmaCtrlErrorWrR::new(((self.bits >> 29) & 1) != 0)
    }
    #[doc = "Bit 30 - Transfer done; auto-clears on write access"]
    #[inline(always)]
    pub fn dma_ctrl_done(&self) -> DmaCtrlDoneR {
        DmaCtrlDoneR::new(((self.bits >> 30) & 1) != 0)
    }
    #[doc = "Bit 31 - Transfer in progress"]
    #[inline(always)]
    pub fn dma_ctrl_busy(&self) -> DmaCtrlBusyR {
        DmaCtrlBusyR::new(((self.bits >> 31) & 1) != 0)
    }
}
impl W {
    #[doc = "Bit 0 - DMA enable flag"]
    #[inline(always)]
    pub fn dma_ctrl_en(&mut self) -> DmaCtrlEnW<CtrlSpec> {
        DmaCtrlEnW::new(self, 0)
    }
    #[doc = "Bit 1 - Start programmed DMA transfer"]
    #[inline(always)]
    pub fn dma_ctrl_start(&mut self) -> DmaCtrlStartW<CtrlSpec> {
        DmaCtrlStartW::new(self, 1)
    }
    #[doc = "Bit 30 - Transfer done; auto-clears on write access"]
    #[inline(always)]
    pub fn dma_ctrl_done(&mut self) -> DmaCtrlDoneW<CtrlSpec> {
        DmaCtrlDoneW::new(self, 30)
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
