#include "stm32f4xx.h"
#include "system_stm32f4xx.h"

void delay(volatile uint32_t count) {
    while(count--) {
    }
}

void SystemClock_Config(void);

int main(void) {
    SystemClock_Config();

    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOBEN;

    GPIOB->MODER |= GPIO_MODER_MODER5_0;
    GPIOB->MODER &= ~GPIO_MODER_MODER5_1;

    while(1) {
        GPIOB->ODR ^= GPIO_ODR_ODR_5;
        delay(1000000);
    }

    return 0;
}

void SystemClock_Config(void) {

    // Enable HSI
    RCC->CR |= ((uint32_t)RCC_CR_HSION);

    // Wait until the HSI is ready and if the time out is reached, exit.
    while((RCC->CR & RCC_CR_HSIRDY) == 0);

    // Select HSI as the system clock source
    RCC->CFGR &= ~RCC_CFGR_SW;
    RCC->CFGR |= RCC_CFGR_SW_HSI;

    // Wait until HSI is used as the system clock source
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_HSI);

    SystemCoreClockUpdate();
}