PROG = program
BUILD_DIR = build
DEB = 1

S_LIST = \
src/startup_code.s

C_LIST = \
src/main.c \
src/test.c

O_LIST =
O_LIST += $(addprefix $(BUILD_DIR)/, $(notdir $(S_LIST:.s=.o)))
O_LIST += $(addprefix $(BUILD_DIR)/, $(notdir $(C_LIST:.c=.o)))

I_LIST =\
-Iinc

vpath %.c $(sort $(dir $(C_LIST)))
vpath %.s $(sort $(dir $(S_LIST)))

F_D = -g -gdwarf-2 -fdebug-prefix-map==../
MCU = -mcpu=cortex-m3 -mthumb
F_A = $(MCU)
F_C = $(MCU)

ifeq ($(DEB), 1)
F_A += $(F_D)
endif

ifeq ($(DEB), 1)
F_C += $(F_D)
endif

F_C += -MMD -MP -mlong-calls $(I_LIST)

LD = arm-none-eabi-ld.exe -T
HX = arm-none-eabi-objcopy.exe -O ihex
AS = arm-none-eabi-gcc.exe -c -x assembler
CC = arm-none-eabi-gcc.exe -c

ls = linker_script.ld

all: $(BUILD_DIR)/$(PROG).hex $(BUILD_DIR)/$(PROG).elf

$(BUILD_DIR)/$(PROG).hex : $(BUILD_DIR)/$(PROG).elf
	$(HX) $(<) $(@)

$(BUILD_DIR)/$(PROG).elf : $(O_LIST) makefile
	$(LD) $(ls) -o $(@) $(O_LIST)

$(BUILD_DIR)/%.o : %.s makefile | $(BUILD_DIR)
	$(AS) $(F_A) -o $(@) $(<)

$(BUILD_DIR)/%.o : %.c makefile | $(BUILD_DIR)
	$(CC) $(F_C) -o $(@) $(<)

$(BUILD_DIR) :
	mkdir $(@)
	
clean :
	rm -rf $(BUILD_DIR)
	
-include $(wildcard $(BUILD_DIR)/*.d)