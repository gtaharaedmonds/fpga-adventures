#[doc = "Register `SREG` reader"]
pub type R = crate::R<SregSpec>;
#[doc = "Register `SREG` writer"]
pub type W = crate::W<SregSpec>;
impl core::fmt::Debug for R {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{}", self.bits())
    }
}
impl W {}
#[doc = "CRC shift register\n\nYou can [`read`](crate::Reg::read) this register and get [`sreg::R`](R). You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`sreg::W`](W). You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api)."]
pub struct SregSpec;
impl crate::RegisterSpec for SregSpec {
    type Ux = u32;
}
#[doc = "`read()` method returns [`sreg::R`](R) reader structure"]
impl crate::Readable for SregSpec {}
#[doc = "`write(|w| ..)` method takes [`sreg::W`](W) writer structure"]
impl crate::Writable for SregSpec {
    type Safety = crate::Unsafe;
}
#[doc = "`reset()` method sets SREG to value 0"]
impl crate::Resettable for SregSpec {}
