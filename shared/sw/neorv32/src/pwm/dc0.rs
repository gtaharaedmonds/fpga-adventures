#[doc = "Register `DC[0]` reader"]
pub type R = crate::R<Dc0Spec>;
#[doc = "Register `DC[0]` writer"]
pub type W = crate::W<Dc0Spec>;
impl core::fmt::Debug for R {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{}", self.bits())
    }
}
impl W {}
#[doc = "Duty cycle register 0\n\nYou can [`read`](crate::Reg::read) this register and get [`dc0::R`](R). You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`dc0::W`](W). You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api)."]
pub struct Dc0Spec;
impl crate::RegisterSpec for Dc0Spec {
    type Ux = u32;
}
#[doc = "`read()` method returns [`dc0::R`](R) reader structure"]
impl crate::Readable for Dc0Spec {}
#[doc = "`write(|w| ..)` method takes [`dc0::W`](W) writer structure"]
impl crate::Writable for Dc0Spec {
    type Safety = crate::Unsafe;
}
#[doc = "`reset()` method sets DC[0] to value 0"]
impl crate::Resettable for Dc0Spec {}
