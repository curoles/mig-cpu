# Author: Igor Lesik 2020-2023

set(TB_TOP TbTop)
set(TB_TOP_FILE ${CMAKE_CURRENT_SOURCE_DIR}/TbTop.sv)
set(TB_MAIN_CPP ${CMAKE_CURRENT_SOURCE_DIR}/sim_main.cpp)
# set(TB_CPP_FILES
#     ${DARKCIRCUIT_SOURCE_DIR}/rtl/blocks/JtagCoreDbg/cpp/OocdRemoteBitbang.cpp
# )

set(TEST_NAME MigUCpu)
set(TB_FLIST
    -y ${CMAKE_SOURCE_DIR}/rtl/lib/macros
    -F ${CMAKE_SOURCE_DIR}/rtl/lib/gates/generic/gates.flist
    -F ${CMAKE_SOURCE_DIR}/rtl/lib/blocks/blocks.flist
    -F ${CMAKE_SOURCE_DIR}/rtl/lib/riscv/riscv.flist
    -F ${CMAKE_SOURCE_DIR}/rtl/design/core/mig-u/migu_core.flist
)
include(${CMAKE_SOURCE_DIR}/test/verilator/helper/simple_test.cmake)

if(RISCV)
    message(STATUS "Enable Mig-U tests using toolchain: " ${RISCV} )
    add_subdirectory(asm_tests)
else()
    message(STATUS "No path to RISCV toolchain, full chip Mig-U tests DISABLED" )
endif()
