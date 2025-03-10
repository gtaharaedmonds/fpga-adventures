#[doc = "Register `DC[2]` reader"]
pub type R = crate::R<Dc2Spec>;
#[doc = "Register `DC[2]` writer"]
pub type W = crate::W<Dc2Spec>;
impl core::fmt::Debug for R {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{}", self.bits())
    }
}
impl W {}
#[doc = "Duty cycle register 2\n\nYou can [`read`](crate::Reg::read) this register and get [`dc2::R`](R). You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`dc2::W`](W). You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api)."]
pub struct Dc2Spec;
impl crate::RegisterSpec for Dc2Spec {
    type Ux = u32;
}
#[doc = "`read()` method returns [`dc2::R`](R) reader structure"]
impl crate::Readable for Dc2Spec {}
#[doc = "`write(|w| ..)` method takes [`dc2::W`](W) writer structure"]
impl crate::Writable for Dc2Spec {
    type Safety = crate::Unsafe;
}
#[doc = "`reset()` method sets DC[2] to value 0"]
impl crate::Resettable for Dc2Spec {}
