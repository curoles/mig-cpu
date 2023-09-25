# Author: Igor Lesik 2020-2023

enable_testing()

set(TB_TOP TbTop)
set(TB_TOP_FILE ${CMAKE_CURRENT_SOURCE_DIR}/TbTop.sv)
set(TB_MAIN_CPP ${CMAKE_CURRENT_SOURCE_DIR}/sim_main.cpp)

set(TEST_NAME GenericGates)
set(TB_FLIST -F ${CMAKE_SOURCE_DIR}/rtl/lib/gates/generic/gates.flist)
include(${CMAKE_CURRENT_SOURCE_DIR}/../helper/simple_test.cmake)

set(TEST_NAME BuiltinGates)
set(TB_FLIST -F ${CMAKE_SOURCE_DIR}/rtl/lib/gates/builtin/gates.flist)
include(${CMAKE_CURRENT_SOURCE_DIR}/../helper/simple_test.cmake)

set(TEST_NAME TsmcGates)
set(TB_FLIST -F ${CMAKE_SOURCE_DIR}/rtl/lib/gates/tsmc/gates.flist)
include(${CMAKE_CURRENT_SOURCE_DIR}/../helper/simple_test.cmake)

set(TEST_NAME CmosGates)
set(TB_FLIST -F ${CMAKE_SOURCE_DIR}/rtl/lib/gates/cmos/gates.flist)
include(${CMAKE_CURRENT_SOURCE_DIR}/../helper/simple_test.cmake)


