#[doc = "Register `DC[1]` reader"]
pub type R = crate::R<Dc1Spec>;
#[doc = "Register `DC[1]` writer"]
pub type W = crate::W<Dc1Spec>;
impl core::fmt::Debug for R {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{}", self.bits())
    }
}
impl W {}
#[doc = "Duty cycle register 1\n\nYou can [`read`](crate::Reg::read) this register and get [`dc1::R`](R). You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`dc1::W`](W). You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api)."]
pub struct Dc1Spec;
impl crate::RegisterSpec for Dc1Spec {
    type Ux = u32;
}
#[doc = "`read()` method returns [`dc1::R`](R) reader structure"]
impl crate::Readable for Dc1Spec {}
#[doc = "`write(|w| ..)` method takes [`dc1::W`](W) writer structure"]
impl crate::Writable for Dc1Spec {
    type Safety = crate::Unsafe;
}
#[doc = "`reset()` method sets DC[1] to value 0"]
impl crate::Resettable for Dc1Spec {}
