cmake_minimum_required(VERSION 3.2...3.15)

project(HelloCpp
        VERSION 1.0
        DESCRIPTION "Hello world C++ NuttX"
)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
# set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_C_STANDARD 99)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SRC_DIR}/arm-none-eabi-gcc.cmake)

set(NUTTX_PATH "${CMAKE_SOURCE_DIR}/nuttx-export-12.4.0-RC0")

# include(cmake/stm32f4discovery.cmake)

set(MCU_LINKER_SCRIPT "${NUTTX_PATH}/scripts/ld.script")

set(COMPILER_PREFIX arm-none-eabi-)


set(AC_HW_FLAGS         "-mcpu=cortex-m4 -mthumb -mfloat-abi=soft ")
set(AC_HW_FLAGS         "${AC_HW_FLAGS} -isystem ${NUTTX_PATH}/include")
set(AC_HW_FLAGS         "${AC_HW_FLAGS} -pipe")
set(AC_LINKER_FLAGS     "--entry=__start -nostdlib -T${MCU_LINKER_SCRIPT}")

set(AC_COMMON_FLAGS "${AC_COMMON_FLAGS} -Wall -Wshadow -Wundef -fno-strict-aliasing -Os")
set(AC_COMMON_FLAGS "${AC_COMMON_FLAGS} -D_DEBUG -D_LIBCPP_BUILD_STATIC -D_LIBCPP_NO_EXCEPTIONS -D__NuttX__ ")
set(AC_COMMON_FLAGS "${AC_COMMON_FLAGS} -fno-exceptions -fcheck-new -fno-rtti -pedantic ")
set(AC_COMMON_FLAGS "${AC_COMMON_FLAGS} -nostdinc++")

set(AC_DEFINES "${AC_DEFINES} -DCONFIG_WCHAR_BUILTIN")

include_directories(
        src
        ${NUTTX_PATH}/include
        ${NUTTX_PATH}/include/libcxx
        ${NUTTX_PATH}/arch/chip
)

set(EXE_NAME hellocpp)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${AC_HW_FLAGS} ${AC_DEFINES}")
set(CMAKE_CXX_FLAGS     "${AC_HW_FLAGS} ${AC_DEFINES} ${AC_COMMON_FLAGS} ${AC_CXX_EXTRA_FLAGS}")
if (PARAM_DEBUG)
    set(CMAKE_CXX_FLAGS     "${CMAKE_CXX_FLAGS} -g")
endif()

set(CMAKE_SKIP_RPATH ON)
set(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_LINKER} ${AC_LINKER_FLAGS} -o ${EXE_NAME}.elf <OBJECTS> <LINK_LIBRARIES>")
set(BUILD_SHARED_LIBS OFF)
add_subdirectory(src)
