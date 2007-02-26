/* boot_start.c
 * 
 * Author:  Matt McKnett, HMC '08
 * Created: 2/26/07
 *
 * This code begins the startup sequence by branching to the bootloader.
 * As stated in "See MIPS Run" p. 110, we want to have some initial code
 * branch to the bootloader so that we don't run over the uncached exception
 * entry points.
 *
 * MODIFY THIS CODE when we know where the bootloader will start!
 */

asm("lui $t0, 0xbfc0");
asm("ori $t0, $t0, 0xbeef");  // This loads the address 0xbfc0beef into $t1
asm("jr  $t0");		      // And jumps to the address

void dummyfunc()
{
  2;
}
