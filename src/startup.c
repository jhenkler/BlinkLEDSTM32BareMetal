#include "stm32f4xx.h"

extern int main(void);

void Rest_Handler(void) {
    extern uint32_t _sidata, _sdata, _edata, _sbss, _ebss;
    uint32_t *src, *dst;

    src = &_sidata;
    for(dst = &_sdata; dst < &_edata;) {
        *(dst++) = *(src++);
    }
    for(dst = &_sbss; dst < &_ebss;) {
        *(dst++) = 0;
    }

    main();
}

void Default_Handler(void) {
    while(1);
}

__attribute__ ((section(".isr_vector")))
uint32_t *vector_table[] = {
    (uint32_t *) 0x20018000,
    (uint32_t *) Rest_Handler,
    (uint32_t *) Default_Handler,
    (uint32_t *) Default_Handler
};