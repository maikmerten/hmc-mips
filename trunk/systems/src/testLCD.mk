# test_lcd.mk
#
# Defines the dependencies for making test_lcd

test_lcd.asm: test_lcd.c muddCLib/muddCLib.h boot_start.dat boot_loader.dat
	$(CC) $(CFLAGS) -S test_lcd.c -o test_lcd.asm

test_lcd.out: test_lcd.o muddCLib/muddCLib.o
	$(LD) -EL -Ttext=$(PROG_LOC) -o test_lcd.out test_lcd.o muddCLib/muddCLib.o

