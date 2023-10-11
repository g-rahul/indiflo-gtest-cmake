################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../application/src/app.cpp 

OBJS += \
./application/src/app.o 

CPP_DEPS += \
./application/src/app.d 


# Each subdirectory must supply rules for building sources it contributes
application/src/%.o application/src/%.su application/src/%.cyclo: ../application/src/%.cpp application/src/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H743xx -c -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"/home/rahul/Desktop/workbench/ST-KH7-CMAKE-VANILLA/KH7STCUBE-Printf/BSP/application/inc" -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-application-2f-src

clean-application-2f-src:
	-$(RM) ./application/src/app.cyclo ./application/src/app.d ./application/src/app.o ./application/src/app.su

.PHONY: clean-application-2f-src

