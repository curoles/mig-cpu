# Author: Igor Lesik 2020-2023

set(TB_TOP TbTop)
set(TB_TOP_FILE ${CMAKE_CURRENT_SOURCE_DIR}/TbTop.sv)
set(TB_MAIN_CPP ${CMAKE_CURRENT_SOURCE_DIR}/sim_main.cpp)

set(TEST_NAME MigUALU)
set(TB_FLIST
    -y ${CMAKE_SOURCE_DIR}/rtl/lib/macros
    -F ${CMAKE_SOURCE_DIR}/rtl/lib/gates/generic/gates.flist
    -F ${CMAKE_SOURCE_DIR}/rtl/lib/blocks/blocks.flist
    -F ${CMAKE_SOURCE_DIR}/rtl/design/core/mig-u/migu_core.flist
)
include(${CMAKE_SOURCE_DIR}/test/verilator/helper/simple_test.cmake)
