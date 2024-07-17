MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 512K
    RAM (xrw) : ORIGIN = 0x20000000, LENGTH = 96K
}

SECTIONS 
{
     .text : {
        _stext = .;
        KEEP(*(.isr_vector))
        *(.text .text.*)
        *(.rodata .rodata*)
        _etext = .;
     } > FLASH

     .data : {
        _sidata = LOADADDR(.data);
        _sdata = .;
        *(.data .data.*)
        _edata = .;
     } > RAM AT > FLASH

     .bss : {
        _sbss = .;
        __bss_start__ = .;
        *(.bss .bss.*)
        *(COMMON)
        __bss_end__ = .;
        _ebss = .;
     } > RAM

     .heap : {
        end = .;
        _heap_end = .;
        _end = .;
        _end_of_heap = .;
     } > RAM
}