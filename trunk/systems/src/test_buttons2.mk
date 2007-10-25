# test_buttons2.mk
#
# Defines the dependencies for making test_buttons2

test_buttons2.asm: test_buttons2.c muddCLib/muddCLib.h boot_start.dat boot_loader.dat
	$(CC) $(CFLAGS) -O2 -S $< -o $@

test_buttons2.o:	test_buttons2.asm
	python checkInstructions.py $<
	$(AS) -o $@ $<

test_buttons2.out: test_buttons2.o muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $^

clean-test_buttons2:
	rm -f test_buttons2.asm

