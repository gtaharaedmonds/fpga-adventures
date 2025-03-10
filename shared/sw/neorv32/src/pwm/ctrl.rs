#[doc = "Register `CTRL` reader"]
pub type R = crate::R<CtrlSpec>;
#[doc = "Register `CTRL` writer"]
pub type W = crate::W<CtrlSpec>;
#[doc = "Field `PWM_CTRL_EN` reader - PWM controller enable flag"]
pub type PwmCtrlEnR = crate::BitReader;
#[doc = "Field `PWM_CTRL_EN` writer - PWM controller enable flag"]
pub type PwmCtrlEnW<'a, REG> = crate::BitWriter<'a, REG>;
#[doc = "Field `PWM_CTRL_PRSCx` reader - Clock prescaler select"]
pub type PwmCtrlPrscxR = crate::FieldReader;
#[doc = "Field `PWM_CTRL_PRSCx` writer - Clock prescaler select"]
pub type PwmCtrlPrscxW<'a, REG> = crate::FieldWriter<'a, REG, 3>;
impl R {
    #[doc = "Bit 0 - PWM controller enable flag"]
    #[inline(always)]
    pub fn pwm_ctrl_en(&self) -> PwmCtrlEnR {
        PwmCtrlEnR::new((self.bits & 1) != 0)
    }
    #[doc = "Bits 1:3 - Clock prescaler select"]
    #[inline(always)]
    pub fn pwm_ctrl_prscx(&self) -> PwmCtrlPrscxR {
        PwmCtrlPrscxR::new(((self.bits >> 1) & 7) as u8)
    }
}
impl W {
    #[doc = "Bit 0 - PWM controller enable flag"]
    #[inline(always)]
    pub fn pwm_ctrl_en(&mut self) -> PwmCtrlEnW<CtrlSpec> {
        PwmCtrlEnW::new(self, 0)
    }
    #[doc = "Bits 1:3 - Clock prescaler select"]
    #[inline(always)]
    pub fn pwm_ctrl_prscx(&mut self) -> PwmCtrlPrscxW<CtrlSpec> {
        PwmCtrlPrscxW::new(self, 1)
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
