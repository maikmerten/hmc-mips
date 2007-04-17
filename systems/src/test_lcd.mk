# test_lcd.mk
#
# Defines the dependencies for making test_lcd

test_lcd.asm: test_lcd.c $(SRC)/muddCLib/muddCLib.h boot_start.dat boot_loader.dat
	$(CC) $(CFLAGS) -O2 -S $< -o $@ 

test_lcd.o: test_lcd.asm
	python $(SRC)/checkInstructions.py $<
	$(AS) -o $@ $<

test_lcd.out: test_lcd.o $(SRC)/muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $^

clean-test_lcd:
	rm -f test_lcd.asm

