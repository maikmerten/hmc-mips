/*  Harvey Mudd College VLSI MIPS Project
 * Nathaniel Pinckney
 * Spring, 2007
 *
 * Test 017
 *
 * Created: 2/10/07
 *
 *   Cache invalidation, uncache write, cached read test.
 */

#include <limits.h>

// This is the boot loader code...
  // swap
  asm("swapon: addi  $9, $0, 1;
      sll $9,$9,17
      mtc0  $9, $12;
      nop;
      nop;
      nop");
  
  // Invalidate entire instruction cache
  asm("addi $10, $0, 256;
       addi $11, $0, 0x400;
       loop1:
       sb $0,0($11);
       addi $11,$11,4;
       addi $10,$10,-1;
       bnez $10,loop1");

  // unswap
  asm("swapoff: addi  $9, $0, 0;
      mtc0  $9, $12;
      nop;
      nop;
      nop");

  // Invalidate entire data cache
  asm("addi $10, $0, 256;
       addi $11, $0, 0x400;
       loop2:
       sb $0,0($11);
       addi $11,$11,4;
       addi $10,$10,-1;
       bnez $10,loop2");

//  In order to run the first function, first initialize stack pointer
asm("li $sp,0x200");

// And jumped to the cached address for main()
// Note: the jumped address must be changed manually, labels
// didn't seem to work.
asm("addi $8, $0, 116
     jr $8");

// bootstrap test, to invalidate both caches.
void test()
{
   long *successptr;
   int i;
   unsigned char *ptr;

   successptr = (long *) 0x0;

   *successptr = 0xdeadbeef;
   while(1);

   /*
  asm("addi  $9, $0, 1;
      sll $9,$9,17
      mtc0  $9, $12;
      nop;
      nop;
      nop"
      :
      :
      : "$8", "$9");

  asm("addi  $9, $0, 0;
      mtc0  $9, $12;
      nop;
      nop;
      nop"
      :
      :
      : "$8", "$9");
*/
  
   /*
   // Swap the caches
  asm("addi  $9, $0, -1        # $3 = 0xffffffff
      mtc0  $9, $12
      nop;
      nop;
      nop"
      :
      :
      : "$8", "$9");
 */
   /*
   // Swap the caches
  asm("mfc0 $8,$12;
      addi $9,$0,1;
      sll $9,$9,$17;
      xor $8,$8,$9;
      nop;
      nop;
      nop;
      mtc0 $8,$12;
      nop;
      nop;
      nop"
      :
      :
      : "$8", "$9");
      */

}

  /*
void test_017()
{
  int i;

  long *cachedptr, *uncachedptr;
  cachedptr = (long *) 0x200;
  uncachedptr = (long *) 0xbfc00200;
  for(i = 0; i < 2; i++) {
	*cachedptr = *uncachedptr;
	cachedptr += 1;
	uncachedptr += 1;
  }

  testfunc();
}

  */
/*
void testfunc() {
  long *testvar;
  long *ptr;

  testvar = 0x0;
  ptr = 0xbfc00200;

  *ptr = 0xdeadbeef;
  ptr = 0x00000200;
  *testvar = *ptr;
}
  */      
/*
// Initializes caches, by invalidating them.
// When it returns, it returns to a cached instruction address.
// Currently only clears from 0x200 and above.
// We could have this just read everything into cache...
void init_cache() {
	int i;
	long *cachedptr, *uncachedptr;
	cachedptr = (long *) 0x0;
	uncachedptr = (long *) 0xbfc00000;
	for(i = 0; i < 1024; i++) {
		*cachedptr = *uncachedptr;
		cachedptr += 1;
		uncachedptr += 1;
	}
}
*/
