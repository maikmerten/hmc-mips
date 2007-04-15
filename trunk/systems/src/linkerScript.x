SECTIONS
{
	bootstart 0x0 : {
		boot_start.o (.text)
	}
 
	exception 0x100 : {
		boot_loader.o (.text)
	}

	program 0x1000 : {
		*(EXCLUDE_FILE (*boot_start.o *boot_loader.o) .text)
	}

	. = 0x00016A80;

	.data : { *(.data) }
	.bss : { *(.bss) }
}
