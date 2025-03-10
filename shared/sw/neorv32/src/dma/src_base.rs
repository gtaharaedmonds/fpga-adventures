#[doc = "Register `SRC_BASE` reader"]
pub type R = crate::R<SrcBaseSpec>;
#[doc = "Register `SRC_BASE` writer"]
pub type W = crate::W<SrcBaseSpec>;
impl core::fmt::Debug for R {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{}", self.bits())
    }
}
impl W {}
#[doc = "Source base address; shows the last accessed read address on read access\n\nYou can [`read`](crate::Reg::read) this register and get [`src_base::R`](R). You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`src_base::W`](W). You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api)."]
pub struct SrcBaseSpec;
impl crate::RegisterSpec for SrcBaseSpec {
    type Ux = u32;
}
#[doc = "`read()` method returns [`src_base::R`](R) reader structure"]
impl crate::Readable for SrcBaseSpec {}
#[doc = "`write(|w| ..)` method takes [`src_base::W`](W) writer structure"]
impl crate::Writable for SrcBaseSpec {
    type Safety = crate::Unsafe;
}
#[doc = "`reset()` method sets SRC_BASE to value 0"]
impl crate::Resettable for SrcBaseSpec {}
