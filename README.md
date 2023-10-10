# ST-KH7-CMAKE-VANILLA
KH7 CMake Vanilla Project to test middleware integration


Build Commands :
mkdir build
cd build
cmake -G "Ninja" -DCMAKE_TOOLCHAIN_FILE=../arm-none-eabi-gcc.cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build . -- -j4

For Clean:
make --build . --target clean
