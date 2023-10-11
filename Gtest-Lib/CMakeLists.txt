cmake_minimum_required(VERSION 3.15.3)

project(libgtest)

enable_language(CXX C ASM)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

#set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g3")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -g0")
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SRC_DIR}/arm-none-eabi-gcc.cmake)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")

set(SOURCES_LIBRARY
        googletest/googletest/src/gtest.cc
        googletest/googletest/src/gtest-all.cc               
        googletest/googletest/src/gtest-filepath.cc     
        googletest/googletest/src/gtest-port.cc
        googletest/googletest/src/gtest-assertion-result.cc   
        googletest/googletest/src/gtest-printers.cc
        googletest/googletest/src/gtest.cc                   
        #googletest/googletest/src/gtest_main.cc         
        googletest/googletest/src/gtest-test-part.cc
        #googletest/googletest/src/gtest-death-test.cc        
        googletest/googletest/src/gtest-matchers.cc     
        googletest/googletest/src/gtest-typed-test.cc
  )

set(LIBRARY_NAME gtest)
add_library(${LIBRARY_NAME} STATIC ${SOURCES_LIBRARY})

target_include_directories(${LIBRARY_NAME} PRIVATE 
        googletest/googletest/
        googletest/googletest/include
        )

target_compile_definitions(${LIBRARY_NAME} PRIVATE
        -GTEST_OS_NONE
        -DGTEST_HAS_POSIX_RE
        -DGTEST_HAS_PTHREAD
        -DGTEST_HAS_DEATH_TEST
        -DGTEST_HAS_STREAM_REDIRECTION
        -DESP32
        )


# Improve clean target
set_target_properties(${LIBRARY_NAME} PROPERTIES ADDITIONAL_CLEAN_FILES
        "${LIBRARY_NAME}.a")


SET(CMAKE_C_FLAGS "-nostdlib -mthumb -fno-builtin -fmessage-length=0 -fsigned-char -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mlittle-endian -mfloat-abi=hard -Wall -std=gnu11 -ffunction-sections -fdata-sections -fno-common -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "c compiler flags")

SET(CMAKE_CXX_FLAGS "-mthumb -fno-builtin -fmessage-length=0 -fsigned-char -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mlittle-endian -mfloat-abi=hard -Wall -std=gnu++11 -ffunction-sections -fdata-sections -fno-common -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "cxx compiler flags")

SET(CMAKE_ASM_FLAGS "-nostdlib -mthumb -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -x assembler-with-cpp" CACHE INTERNAL "asm compiler flags")
SET(CMAKE_MODULE_LINKER_FLAGS "-mthumb -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mabi=aapcs" CACHE INTERNAL "module linker flags")
SET(CMAKE_SHARED_LINKER_FLAGS "-mthumb -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mabi=aapcs" CACHE INTERNAL "shared linker flags")


