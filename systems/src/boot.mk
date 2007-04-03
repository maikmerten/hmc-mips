# boot.mk
# 
# This defines the dependencies for the boot_start and boot_load files.
#

boot_start.out: boot_start.o
	$(LD) -EL -Ttext=$(RESET_LOC) -o $@ $<

boot_loader.out: boot_loader.o
	$(LD) -EL -Ttext=$(BOOT_LOC) -o $@ $<

