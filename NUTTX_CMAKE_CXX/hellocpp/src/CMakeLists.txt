set(HEADER_FILES
        HelloWorld.h
)

set(SOURCE_FILES
        HelloWorld.cpp
)

link_directories(${EXE_NAME} ${NUTTX_PATH}/libs)

add_executable(${EXE_NAME} ${SOURCE_FILES} main.cpp ${HEADER_FILES})

add_custom_command(
        TARGET ${EXE_NAME}
        POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} ARGS -S -O binary ${CMAKE_BINARY_DIR}/${EXE_NAME}.elf ${CMAKE_BINARY_DIR}/${EXE_NAME}.bin
)

#target_link_libraries(${EXE_NAME} PUBLIC --start-group)

target_link_libraries(${EXE_NAME} PUBLIC sched)
target_link_libraries(${EXE_NAME} PUBLIC drivers)
target_link_libraries(${EXE_NAME} PUBLIC boards)
target_link_libraries(${EXE_NAME} PUBLIC c)
target_link_libraries(${EXE_NAME} PUBLIC mm)
target_link_libraries(${EXE_NAME} PUBLIC arch)
target_link_libraries(${EXE_NAME} PUBLIC xx)
target_link_libraries(${EXE_NAME} PUBLIC apps)
target_link_libraries(${EXE_NAME} PUBLIC fs)
target_link_libraries(${EXE_NAME} PUBLIC binfmt)
target_link_libraries(${EXE_NAME} PUBLIC board)
target_link_libraries(${EXE_NAME} PUBLIC gcc)
#target_link_libraries(${EXE_NAME} supc++)
target_link_libraries(${EXE_NAME} PUBLIC m)

add_dependencies(${EXE_NAME} gtest)
link_directories(${CMAKE_BINARY_DIR}/lib)
link_directories(${EXE_NAME} ${NUTTX_PATH}/libs)

target_link_libraries(${EXE_NAME} PUBLIC gtest)
#target_link_libraries(${EXE_NAME} PUBLIC --end-group)



