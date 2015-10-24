**Test 17**

The main portion of this test is written in C and is meant to represent a bootloader and program running on the processor, with cached instruction memory.  The test invalidates both instruction and data cache.  Jumps to a program at a cached instruction address, which calls another function (at a cached instruction address) and tests basic read/write of cached data.  All other tests use uncached instructions unless otherwise noted.

**Test 20**

A basic read/write functionality test of the cache and write buffer, to verify data is being written correctly from the processor's point of view.  It writes six values to uncached  addresses then immediately reads them, to verify values were written correctly.  It repeats this for cached addresses.  Lastly, it writes one uncached value and immediately reads it back in.

**Test 21**

This test is identical to test 20 except it first swaps the caches and performs the test on the instruction cache.

**Test 22**

Tests byteen functionality of the caches by writing byte values to the cache and reading the resulting word value.

**Test 23**

Tests bypassing the cache by:
# writing to the cache, bypassing the cache, and verifying the original value is read from the cached address.
# Verifying newer value is read from uncached (cache bypass) address.
# Verifying invalidating the cache with a byte-sized write works.

**Test 24**

This test is similar to test 22 except it first enables the RE bit (reverse endian) in the status register.  It also loads half-word values instead of word values.

**Test 25**

Tests data with identical tags (i.e. lower 8 bits of address are the same) but different data/address locations (upper bits of address are different).