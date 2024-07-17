# STM32F4xx MakeFile

TARGET = main
SRC = src/main.c
OBJ = main.o

# Toolchain
CC = arm-none-eabi-gcc
CCFLAGS = -mcpu=cortex-m4 -mthumb -Wall -std=c99
LDFLAGS = -T stm32f4.ld
LDSCRIPT = stm32f4.ld

# STM32F4xx Standard Peripheral Library
PERIPH_DRIVER_PATH = Drivers/STM32F4xx_StdPeriph_Driver

# Inlcudes
INC_DIRS = -I Inlcudes \
			-I $(PERIPH_DRIVER_PATH)/inc


# Compile
$(OBJ): $(SRC)
	$(CC) $(CCFLAGS) $(INC_DIRS) -c $< -o $@

# Link
$(TARGET).elf: $(OBJ)
	$(CC) $(CCFLAGS) $(LDFLAGS) $^ -o $@

# Convert ELF to binary
$(TARGET).bin: $(TARGET).elf
	arm-none-eabi-objcopy -O binary $< $@

# Clean
clean:
	rm -f $(OBJ) $(TARGET).elf $(TARGET).bin

.PHONY: clean