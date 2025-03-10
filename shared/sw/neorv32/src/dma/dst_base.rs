#[doc = "Register `DST_BASE` reader"]
pub type R = crate::R<DstBaseSpec>;
#[doc = "Register `DST_BASE` writer"]
pub type W = crate::W<DstBaseSpec>;
impl core::fmt::Debug for R {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{}", self.bits())
    }
}
impl W {}
#[doc = "Destination base address; shows the last accessed write address on read access\n\nYou can [`read`](crate::Reg::read) this register and get [`dst_base::R`](R). You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`dst_base::W`](W). You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api)."]
pub struct DstBaseSpec;
impl crate::RegisterSpec for DstBaseSpec {
    type Ux = u32;
}
#[doc = "`read()` method returns [`dst_base::R`](R) reader structure"]
impl crate::Readable for DstBaseSpec {}
#[doc = "`write(|w| ..)` method takes [`dst_base::W`](W) writer structure"]
impl crate::Writable for DstBaseSpec {
    type Safety = crate::Unsafe;
}
#[doc = "`reset()` method sets DST_BASE to value 0"]
impl crate::Resettable for DstBaseSpec {}
