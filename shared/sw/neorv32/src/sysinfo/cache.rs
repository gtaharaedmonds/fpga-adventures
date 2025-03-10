#[doc = "Register `CACHE` reader"]
pub type R = crate::R<CacheSpec>;
#[doc = "Field `SYSINFO_CACHE_INST_BLOCK_SIZE` reader - i-cache: log2(Block size in bytes)"]
pub type SysinfoCacheInstBlockSizeR = crate::FieldReader;
#[doc = "Field `SYSINFO_CACHE_INST_NUM_BLOCKS` reader - i-cache: log2(Number of cache blocks)"]
pub type SysinfoCacheInstNumBlocksR = crate::FieldReader;
#[doc = "Field `SYSINFO_CACHE_DATA_BLOCK_SIZE` reader - d-cache: log2(Block size in bytes)"]
pub type SysinfoCacheDataBlockSizeR = crate::FieldReader;
#[doc = "Field `SYSINFO_CACHE_DATA_NUM_BLOCKS` reader - d-cache: log2(Number of cache blocks)"]
pub type SysinfoCacheDataNumBlocksR = crate::FieldReader;
#[doc = "Field `SYSINFO_CACHE_XBUS_BLOCK_SIZE` reader - xbus-cache: log2(Block size in bytes)"]
pub type SysinfoCacheXbusBlockSizeR = crate::FieldReader;
#[doc = "Field `SYSINFO_CACHE_XBUS_NUM_BLOCKS` reader - xbus-cache: log2(Number of cache blocks)"]
pub type SysinfoCacheXbusNumBlocksR = crate::FieldReader;
impl R {
    #[doc = "Bits 0:3 - i-cache: log2(Block size in bytes)"]
    #[inline(always)]
    pub fn sysinfo_cache_inst_block_size(&self) -> SysinfoCacheInstBlockSizeR {
        SysinfoCacheInstBlockSizeR::new((self.bits & 0x0f) as u8)
    }
    #[doc = "Bits 4:7 - i-cache: log2(Number of cache blocks)"]
    #[inline(always)]
    pub fn sysinfo_cache_inst_num_blocks(&self) -> SysinfoCacheInstNumBlocksR {
        SysinfoCacheInstNumBlocksR::new(((self.bits >> 4) & 0x0f) as u8)
    }
    #[doc = "Bits 8:11 - d-cache: log2(Block size in bytes)"]
    #[inline(always)]
    pub fn sysinfo_cache_data_block_size(&self) -> SysinfoCacheDataBlockSizeR {
        SysinfoCacheDataBlockSizeR::new(((self.bits >> 8) & 0x0f) as u8)
    }
    #[doc = "Bits 12:15 - d-cache: log2(Number of cache blocks)"]
    #[inline(always)]
    pub fn sysinfo_cache_data_num_blocks(&self) -> SysinfoCacheDataNumBlocksR {
        SysinfoCacheDataNumBlocksR::new(((self.bits >> 12) & 0x0f) as u8)
    }
    #[doc = "Bits 24:27 - xbus-cache: log2(Block size in bytes)"]
    #[inline(always)]
    pub fn sysinfo_cache_xbus_block_size(&self) -> SysinfoCacheXbusBlockSizeR {
        SysinfoCacheXbusBlockSizeR::new(((self.bits >> 24) & 0x0f) as u8)
    }
    #[doc = "Bits 28:31 - xbus-cache: log2(Number of cache blocks)"]
    #[inline(always)]
    pub fn sysinfo_cache_xbus_num_blocks(&self) -> SysinfoCacheXbusNumBlocksR {
        SysinfoCacheXbusNumBlocksR::new(((self.bits >> 28) & 0x0f) as u8)
    }
}
#[doc = "Cache configuration\n\nYou can [`read`](crate::Reg::read) this register and get [`cache::R`](R). See [API](https://docs.rs/svd2rust/#read--modify--write-api)."]
pub struct CacheSpec;
impl crate::RegisterSpec for CacheSpec {
    type Ux = u32;
}
#[doc = "`read()` method returns [`cache::R`](R) reader structure"]
impl crate::Readable for CacheSpec {}
#[doc = "`reset()` method sets CACHE to value 0"]
impl crate::Resettable for CacheSpec {}
