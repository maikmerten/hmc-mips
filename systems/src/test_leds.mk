# test_leds.mk
#
# Gives the dependencies for building test_leds

test_leds.asm: test_leds.c muddCLib/muddCLib.h boot_start.dat boot_loader.dat
	$(CC) $(CFLAGS) -S test_leds.c -o test_leds.asm

test_leds.out: test_leds.o muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o test_leds.out test_leds.o muddCLib/muddCLib.o

