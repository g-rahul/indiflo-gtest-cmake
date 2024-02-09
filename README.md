
# ST-KH7-CMAKE-VANILLA

KH7 CMake Vanilla Project to test middleware integration




## Run Locally

Clone the project

```bash
  git clone https://github.com/g-rahul/ST-KH7-CMAKE-VANILLA
```

Go to the project directory

```bash
mkdir build
cd build
cmake -G "Ninja" -DCMAKE_TOOLCHAIN_FILE=../arm-none-eabi-gcc.cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build . -- -j4
```

Cmake Clean
```bash
cmake --build . --target clean
```




## Related

Here are some related projects

[tfazli/stm_cmake_template](https://github.com/tfazli/stm_cmake_template)

[Pierre Gradot/CMake on SMT32](https://dev.to/younup/cmake-on-stm32-the-beginning-3766)

# NUTTX CMAKE LIBCXX

Go to the project directory NUTTX_CMAKE_CXX
Pull Nuttx and Apps as required 

Note :
1) CONFIG_ARCH_BOARD_COMMON must be set under boards to generate libboard.a - ref# https://github.com/apache/nuttx/issues/10388

2) __NUTTX__ must be defined to include libcxx without errors - ref# https://github.com/apache/nuttx/issues/5530

3) config LIBSUPCXX to enable low-level cxx gnu lib

```bash
cd hellocpp
mkdir build
cd build
cmake -G "Ninja" -DCMAKE_TOOLCHAIN_FILE=../arm-none-eabi-gcc.cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build . -- -j4
```
