
#[[ =====================================================================================================
    =========================================== Preamble ================================================ 
    ===================================================================================================== ]]

                                cmake_minimum_required(VERSION 3.9 FATAL_ERROR)
                                       project(kakuteh7v2-STCube-Vanilla)
                                            enable_language(CXX C ASM)


#[[ =====================================================================================================
    ====================================== Language Options  ============================================ 
    ===================================================================================================== ]]

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g3")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -g0")

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SRC_DIR}/arm-none-eabi-gcc.cmake)
#set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11") // Required ??


#[[ =====================================================================================================
    ======================================== Source Files  ============================================== 
    ===================================================================================================== ]]

file(GLOB STM32_CUBE_GEN
     "BSP/Drivers/STM32H7xx_HAL_Driver/Src/*.c"
     "BSP/Core/Src/main.c"
     "BSP/Core/Src/stm32h7xx_hal_msp.c"
     "BSP/Core/Src/stm32h7xx_it.c"
     "BSP/Core/Src/sysmem.c"
     "BSP/Core/Src/system_stm32h7xx.c"
     "BSP/Core/Startup/*.s"
)

file(GLOB APPLICATION_FILES
     "BSP/application/src/*.cpp"
)

list(REMOVE_ITEM STM32_CUBE_GEN "BSP/Core/Src/syscalls.c")
set_source_files_properties(${STM32_CUBE_GEN} PROPERTIES COMPILE_FLAGS -Wno-unused-parameter)


#[[ =====================================================================================================
    ========================================= Executeable =============================================== 
    ===================================================================================================== ]]

set(EXECUTABLE ${PROJECT_NAME}.out)

#link_directories(${GTEST_LIB_DIR})
add_executable(${EXECUTABLE} ${STM32_CUBE_GEN} ${APPLICATION_FILES})

# Improve clean target
set_target_properties(${EXECUTABLE} PROPERTIES ADDITIONAL_CLEAN_FILES
        "${PROJECT_NAME}.bin;${PROJECT_NAME}.hex;${PROJECT_NAME}.map;${PROJECT_NAME}.elf")




#[[ =====================================================================================================
    ========================================= Include Dir  ============================================== 
    ===================================================================================================== ]]

target_compile_definitions(${EXECUTABLE} PRIVATE
        -DUSE_HAL_DRIVER
        -DSTM32H743xx
        -DGTEST_OS_NONE
        )

target_include_directories(${EXECUTABLE} SYSTEM PRIVATE 
        BSP/Core/Inc
        BSP/Drivers/STM32H7xx_HAL_Driver/Inc
        BSP/Drivers/CMSIS/Device/ST/STM32H7xx/Include
        BSP/Drivers/CMSIS/Include
        )

target_include_directories(${EXECUTABLE} PRIVATE
        BSP/application/inc
)

#[[ =====================================================================================================
    ====================================== Compile/Link Flags =========================================== 
    ===================================================================================================== ]]

set(CMAKE_C_FLAGS "-mcpu=cortex-m7 -mthumb -mfpu=fpv5-sp-d16 -mfloat-abi=hard" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "-mcpu=cortex-m7 -mthumb -mfpu=fpv5-sp-d16 -mfloat-abi=hard" CACHE STRING "" FORCE)
set(CMAKE_ASM_FLAGS "-mcpu=cortex-m7 -mthumb -mfpu=fpv5-sp-d16 -mfloat-abi=hard -D__ASSEMBLY__" CACHE STRING "" FORCE)

target_compile_options(${EXECUTABLE} PRIVATE
        -mabi=aapcs
        -fdata-sections
        -ffunction-sections
        -Wall
        -Wextra
        -pedantic

        $<$<COMPILE_LANGUAGE:CXX>:@${CMAKE_SOURCE_DIR}/gcc-options-cxx.txt>
        $<$<COMPILE_LANGUAGE:C>:@${CMAKE_SOURCE_DIR}/gcc-options-c.txt>
        $<$<CONFIG:Debug>:-Og>
        )

#[[
SET(CMAKE_C_FLAGS "-nostdlib -mthumb -fno-builtin -fmessage-length=0 -fsigned-char -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mlittle-endian -mfloat-abi=hard -Wall -std=gnu11 -ffunction-sections -fdata-sections -fno-common -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "c compiler flags")

SET(CMAKE_CXX_FLAGS "-mthumb -fno-builtin -fmessage-length=0 -fsigned-char -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mlittle-endian -mfloat-abi=hard -Wall -std=gnu++11 -ffunction-sections -fdata-sections -fno-common -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "cxx compiler flags")

SET(CMAKE_ASM_FLAGS "-nostdlib -mthumb -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -x assembler-with-cpp" CACHE INTERNAL "asm compiler flags")
SET(CMAKE_MODULE_LINKER_FLAGS "-mthumb -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mabi=aapcs" CACHE INTERNAL "module linker flags")
SET(CMAKE_SHARED_LINKER_FLAGS "-mthumb -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mabi=aapcs" CACHE INTERNAL "shared linker flags")
]]


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


#[[ =====================================================================================================
    ===================================== Build Post Processing ========================================= 
    ===================================================================================================== ]]

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
