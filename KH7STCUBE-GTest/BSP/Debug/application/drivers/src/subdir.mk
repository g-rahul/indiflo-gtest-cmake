################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../application/drivers/src/printf.c 

C_DEPS += \
./application/drivers/src/printf.d 

OBJS += \
./application/drivers/src/printf.o 


# Each subdirectory must supply rules for building sources it contributes
application/drivers/src/%.o application/drivers/src/%.su application/drivers/src/%.cyclo: ../application/drivers/src/%.c application/drivers/src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H743xx -c -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"/home/rahul/Desktop/workbench/ST-KH7-CMAKE-VANILLA/KH7STCUBE-Printf/BSP/application/inc" -I"/home/rahul/Desktop/workbench/ST-KH7-CMAKE-VANILLA/KH7STCUBE-Printf/BSP/application/drivers/inc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-application-2f-drivers-2f-src

clean-application-2f-drivers-2f-src:
	-$(RM) ./application/drivers/src/printf.cyclo ./application/drivers/src/printf.d ./application/drivers/src/printf.o ./application/drivers/src/printf.su

.PHONY: clean-application-2f-drivers-2f-src

