#[doc = "Register `TTYPE` reader"]
pub type R = crate::R<TtypeSpec>;
#[doc = "Register `TTYPE` writer"]
pub type W = crate::W<TtypeSpec>;
#[doc = "Field `DMA_TTYPE_NUM` reader - Number of elements to transfer"]
pub type DmaTtypeNumR = crate::FieldReader<u32>;
#[doc = "Field `DMA_TTYPE_NUM` writer - Number of elements to transfer"]
pub type DmaTtypeNumW<'a, REG> = crate::FieldWriter<'a, REG, 24, u32>;
#[doc = "Field `DMA_TTYPE_QSEL` reader - Data quantity select"]
pub type DmaTtypeQselR = crate::FieldReader;
#[doc = "Field `DMA_TTYPE_QSEL` writer - Data quantity select"]
pub type DmaTtypeQselW<'a, REG> = crate::FieldWriter<'a, REG, 2>;
#[doc = "Field `DMA_TTYPE_SRC_INC` reader - Source constant (0) or incrementing (1) address"]
pub type DmaTtypeSrcIncR = crate::BitReader;
#[doc = "Field `DMA_TTYPE_SRC_INC` writer - Source constant (0) or incrementing (1) address"]
pub type DmaTtypeSrcIncW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `DMA_TTYPE_DST_INC` reader - Destination constant (0) or incrementing (1) address"]
pub type DmaTtypeDstIncR = crate::BitReader;
#[doc = "Field `DMA_TTYPE_DST_INC` writer - Destination constant (0) or incrementing (1) address"]
pub type DmaTtypeDstIncW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `DMA_TTYPE_ENDIAN` reader - Convert Endianness when set"]
pub type DmaTtypeEndianR = crate::BitReader;
#[doc = "Field `DMA_TTYPE_ENDIAN` writer - Convert Endianness when set"]
pub type DmaTtypeEndianW<'a, REG> = crate::BitWriter<'a, REG>;
impl R {
    #[doc = "Bits 0:23 - Number of elements to transfer"]
    #[inline(always)]
    pub fn dma_ttype_num(&self) -> DmaTtypeNumR {
        DmaTtypeNumR::new(self.bits & 0x00ff_ffff)
    }
    #[doc = "Bits 27:28 - Data quantity select"]
    #[inline(always)]
    pub fn dma_ttype_qsel(&self) -> DmaTtypeQselR {
        DmaTtypeQselR::new(((self.bits >> 27) & 3) as u8)
    }
    #[doc = "Bit 29 - Source constant (0) or incrementing (1) address"]
    #[inline(always)]
    pub fn dma_ttype_src_inc(&self) -> DmaTtypeSrcIncR {
        DmaTtypeSrcIncR::new(((self.bits >> 29) & 1) != 0)
    }
    #[doc = "Bit 30 - Destination constant (0) or incrementing (1) address"]
    #[inline(always)]
    pub fn dma_ttype_dst_inc(&self) -> DmaTtypeDstIncR {
        DmaTtypeDstIncR::new(((self.bits >> 30) & 1) != 0)
    }
    #[doc = "Bit 31 - Convert Endianness when set"]
    #[inline(always)]
    pub fn dma_ttype_endian(&self) -> DmaTtypeEndianR {
        DmaTtypeEndianR::new(((self.bits >> 31) & 1) != 0)
    }
}
impl W {
    #[doc = "Bits 0:23 - Number of elements to transfer"]
    #[inline(always)]
    pub fn dma_ttype_num(&mut self) -> DmaTtypeNumW<TtypeSpec> {
        DmaTtypeNumW::new(self, 0)
    }
    #[doc = "Bits 27:28 - Data quantity select"]
    #[inline(always)]
    pub fn dma_ttype_qsel(&mut self) -> DmaTtypeQselW<TtypeSpec> {
        DmaTtypeQselW::new(self, 27)
    }
    #[doc = "Bit 29 - Source constant (0) or incrementing (1) address"]
    #[inline(always)]
    pub fn dma_ttype_src_inc(&mut self) -> DmaTtypeSrcIncW<TtypeSpec> {
        DmaTtypeSrcIncW::new(self, 29)
    }
    #[doc = "Bit 30 - Destination constant (0) or incrementing (1) address"]
    #[inline(always)]
    pub fn dma_ttype_dst_inc(&mut self) -> DmaTtypeDstIncW<TtypeSpec> {
        DmaTtypeDstIncW::new(self, 30)
    }
    #[doc = "Bit 31 - Convert Endianness when set"]
    #[inline(always)]
    pub fn dma_ttype_endian(&mut self) -> DmaTtypeEndianW<TtypeSpec> {
        DmaTtypeEndianW::new(self, 31)
    }
}
#[doc = "Destination base address; shows the last accessed write address on read access\n\nYou can [`read`](crate::Reg::read) this register and get [`ttype::R`](R). You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`ttype::W`](W). You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api)."]
pub struct TtypeSpec;
impl crate::RegisterSpec for TtypeSpec {
    type Ux = u32;
}
#[doc = "`read()` method returns [`ttype::R`](R) reader structure"]
impl crate::Readable for TtypeSpec {}
#[doc = "`write(|w| ..)` method takes [`ttype::W`](W) writer structure"]
impl crate::Writable for TtypeSpec {
    type Safety = crate::Unsafe;
}
#[doc = "`reset()` method sets TTYPE to value 0"]
impl crate::Resettable for TtypeSpec {}
