cmake_minimum_required(VERSION 3.15.3)

project(kakuteh7v2-STCube-Vanilla)

enable_language(CXX C ASM)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

#set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g3")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -g0")
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SRC_DIR}/arm-none-eabi-gcc.cmake)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
set(GTEST_LIB_DIR third-party/out/lib/gtest)

set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
add_definitions(-DGTEST_OS_NONE)

set(STM32CUBEMX_GENERATED_FILES
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_tim.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_tim_ex.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_uart.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_uart_ex.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc_ex.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash_ex.c
        #BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash_ramfunc.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_gpio.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_dma_ex.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_dma.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr_ex.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_cortex.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_exti.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_hsem.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_i2c.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_i2c_ex.c
        BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_mdma.c
        #BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pcd.c
        #BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pcd_ex.c
        #BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_usb.c

        BSP/Core/Inc/main.h
        BSP/Core/Inc/stm32h7xx_hal_conf.h
        BSP/Core/Inc/stm32h7xx_it.h

        BSP/Core/Src/main.c
        BSP/Core/Src/stm32h7xx_hal_msp.c
        BSP/Core/Src/stm32h7xx_it.c
        #BSP/Core/Src/syscalls.c
        BSP/Core/Src/sysmem.c
        BSP/Core/Src/system_stm32h7xx.c

        BSP/Core/Startup/startup_stm32h743vihx.s)

set(APPLICATION_SRC_FILES
        BSP/application/src/app.cpp
        tests/dummy_test.cpp
)

set_source_files_properties(BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_exti.c
            BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash.c
            BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash_ex.c
            BSP/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr.c
            PROPERTIES
            COMPILE_FLAGS -Wno-unused-parameter)


set(EXECUTABLE ${PROJECT_NAME}.out)

link_directories(${GTEST_LIB_DIR})
add_executable(${EXECUTABLE} ${STM32CUBEMX_GENERATED_FILES} ${APPLICATION_SRC_FILES})
target_link_libraries(${EXECUTABLE} libgtest.a)

# Improve clean target
set_target_properties(${EXECUTABLE} PROPERTIES ADDITIONAL_CLEAN_FILES
        "${PROJECT_NAME}.bin;${PROJECT_NAME}.hex;${PROJECT_NAME}.map;${PROJECT_NAME}.elf")

target_compile_definitions(${EXECUTABLE} PRIVATE
        -DUSE_HAL_DRIVER
        -DSTM32H743xx
        )

target_include_directories(${EXECUTABLE} SYSTEM PRIVATE 
        BSP/Core/Inc
        BSP/Drivers/STM32H7xx_HAL_Driver/Inc
        BSP/Drivers/CMSIS/Device/ST/STM32H7xx/Include
        BSP/Drivers/CMSIS/Include

        )

target_include_directories(${EXECUTABLE} PRIVATE
        BSP/application/inc
        third-party/out/include/gtest_includes
)

#[[
target_compile_options(${EXECUTABLE} PRIVATE
        -mcpu=cortex-m7
        -mthumb
        -mfpu=fpv5-sp-d16
        -mfloat-abi=hard
        -mabi=aapcs
        -fdata-sections
        -ffunction-sections

        $<$<COMPILE_LANGUAGE:CXX>:@${CMAKE_SOURCE_DIR}/gcc-options-cxx.txt>
        $<$<COMPILE_LANGUAGE:C>:@${CMAKE_SOURCE_DIR}/gcc-options-c.txt>

        -Wall
        -Wextra
        -pedantic
    
        $<$<CONFIG:Debug>:-Og>
        )
]]


SET(CMAKE_C_FLAGS "-nostdlib -mthumb -fno-builtin -fmessage-length=0 -fsigned-char -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mlittle-endian -mfloat-abi=hard -Wall -std=gnu11 -ffunction-sections -fdata-sections -fno-common -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "c compiler flags")

SET(CMAKE_CXX_FLAGS "-mthumb -fno-builtin -fmessage-length=0 -fsigned-char -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mlittle-endian -mfloat-abi=hard -Wall -std=gnu++11 -ffunction-sections -fdata-sections -fno-common -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "cxx compiler flags")

SET(CMAKE_ASM_FLAGS "-nostdlib -mthumb -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -x assembler-with-cpp" CACHE INTERNAL "asm compiler flags")
SET(CMAKE_MODULE_LINKER_FLAGS "-mthumb -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mabi=aapcs" CACHE INTERNAL "module linker flags")
SET(CMAKE_SHARED_LINKER_FLAGS "-mthumb -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mabi=aapcs" CACHE INTERNAL "shared linker flags")

target_link_options(${EXECUTABLE} PRIVATE
        -T${CMAKE_SOURCE_DIR}/BSP/STM32H743VIHX_FLASH.ld
        -mcpu=cortex-m7
        -mthumb
        -mfpu=fpv5-sp-d16
        -mfloat-abi=hard
        -specs=nosys.specs
        -lc
        -lm
        -lnosys
        -Wl,-Map=${PROJECT_NAME}.map,--cref
        -Wl,--gc-sections

        -mlittle-endian
        -O0 
        -fmessage-length=0
        -fsigned-char
        -ffunction-sections
        -fdata-sections
        -fno-common
        -ffreestanding
        -fno-builtin
        -g3 
        -Xlinker
        )

#find_library(LIB_GTEST libgtest HINTS ${GTEST_LIB_DIR}/)
#message(Lib path : ${LIB_GTEST})


# Print executable size
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND arm-none-eabi-size ${EXECUTABLE})

# Create hex file
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND arm-none-eabi-objcopy -O elf32-little ${EXECUTABLE} ${PROJECT_NAME}.elf
        COMMAND arm-none-eabi-objcopy -O ihex ${EXECUTABLE} ${PROJECT_NAME}.hex
        COMMAND arm-none-eabi-objcopy -O binary ${EXECUTABLE} ${PROJECT_NAME}.bin)