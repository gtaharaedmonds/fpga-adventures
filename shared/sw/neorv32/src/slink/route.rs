#[doc = "Register `ROUTE` reader"]
pub type R = crate::R<RouteSpec>;
#[doc = "Register `ROUTE` writer"]
pub type W = crate::W<RouteSpec>;
#[doc = "Field `SLINK_ROUTE_DST` reader - TX stream destination address/ID (TDEST)"]
pub type SlinkRouteDstR = crate::FieldReader;
#[doc = "Field `SLINK_ROUTE_DST` writer - TX stream destination address/ID (TDEST)"]
pub type SlinkRouteDstW<'a, REG> = crate::FieldWriter<'a, REG, 4>;
#[doc = "Field `SLINK_ROUTE_SRC` reader - RX stream source address/ID (TID)"]
pub type SlinkRouteSrcR = crate::FieldReader;
impl R {
    #[doc = "Bits 0:3 - TX stream destination address/ID (TDEST)"]
    #[inline(always)]
    pub fn slink_route_dst(&self) -> SlinkRouteDstR {
        SlinkRouteDstR::new((self.bits & 0x0f) as u8)
    }
    #[doc = "Bits 4:7 - RX stream source address/ID (TID)"]
    #[inline(always)]
    pub fn slink_route_src(&self) -> SlinkRouteSrcR {
        SlinkRouteSrcR::new(((self.bits >> 4) & 0x0f) as u8)
    }
}
impl W {
    #[doc = "Bits 0:3 - TX stream destination address/ID (TDEST)"]
    #[inline(always)]
    pub fn slink_route_dst(&mut self) -> SlinkRouteDstW<RouteSpec> {
        SlinkRouteDstW::new(self, 0)
    }
}
#[doc = "Routing information\n\nYou can [`read`](crate::Reg::read) this register and get [`route::R`](R). You can [`reset`](crate::Reg::reset), [`write`](crate::Reg::write), [`write_with_zero`](crate::Reg::write_with_zero) this register using [`route::W`](W). You can also [`modify`](crate::Reg::modify) this register. See [API](https://docs.rs/svd2rust/#read--modify--write-api)."]
pub struct RouteSpec;
impl crate::RegisterSpec for RouteSpec {
    type Ux = u32;
}
#[doc = "`read()` method returns [`route::R`](R) reader structure"]
impl crate::Readable for RouteSpec {}
#[doc = "`write(|w| ..)` method takes [`route::W`](W) writer structure"]
impl crate::Writable for RouteSpec {
    type Safety = crate::Unsafe;
}
#[doc = "`reset()` method sets ROUTE to value 0"]
impl crate::Resettable for RouteSpec {}
