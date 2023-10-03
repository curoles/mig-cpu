set(VERILATOR_PARAMS_${TEST_NAME}
    -sv +systemverilogext+sv
    -O3 -Wall -Wwarn-lint -Wwarn-style -Wno-UNUSED --assert
    --cc --compiler gcc
    --exe ${TB_MAIN_CPP} ${TB_CPP_FILES}
    --clk clk
    --Mdir obj_dir_${TEST_NAME}
    ${TB_FLIST}
    -CFLAGS "-I${MIGCPU_SOURCE_DIR}/test/verilator"
    -CFLAGS "-O3 -march=native"
    -CFLAGS "-std=c++17"
    --top-module ${TB_TOP} ${TB_TOP_FILE}
    ${MIGCPU_SOURCE_DIR}/test/verilator/helper/verilator_tick.cpp
)

add_custom_target(
    EXE_VTB_${TEST_NAME} ALL
    COMMAND verilator ${VERILATOR_PARAMS_${TEST_NAME}}
    COMMAND make -C ${CMAKE_CURRENT_BINARY_DIR}/obj_dir_${TEST_NAME} -j -f V${TB_TOP}.mk V${TB_TOP}
)

add_test(NAME ${TEST_NAME}
    COMMAND ${CMAKE_CURRENT_BINARY_DIR}/obj_dir_${TEST_NAME}/V${TB_TOP} ${TEST_PLUS_ARGS}
)

# TODO
# check chapter "CMake" in https://www.veripool.org/wiki/verilator/Manual-verilator
