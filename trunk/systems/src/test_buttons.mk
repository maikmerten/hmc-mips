# test_buttons.mk
#
# Defines the dependencies for making test_buttons

test_buttons.asm: test_buttons.c muddCLib/muddCLib.h boot_start.dat boot_loader.dat
	$(CC) $(CFLAGS) -O2 -S $< -o $@

test_buttons.o:	test_buttons.asm
	python checkInstructions.py $<
	$(AS) -EL -o $@ $<

test_buttons.out: test_buttons.o muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $^

