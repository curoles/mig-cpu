include(FetchContent)

FetchContent_Declare(
  riscv_opcodes
  GIT_REPOSITORY https://github.com/riscv/riscv-opcodes.git
  #GIT_TAG       master TODO # release-???
)

FetchContent_MakeAvailable(riscv_opcodes)

set(MIGU_SRC_DIR ${CMAKE_SOURCE_DIR}/rtl/design/core/mig-u)
set(MIGU_RISCV_OPCODES ${MIGU_SRC_DIR}/migu_riscv_opcodes.sv)

add_custom_command(OUTPUT ${MIGU_RISCV_OPCODES}
    WORKING_DIRECTORY ${riscv_opcodes_SOURCE_DIR}
    COMMAND ./parse.py -sverilog 'rv_i'
    COMMAND mv inst.sverilog ${MIGU_RISCV_OPCODES}
)
add_custom_target(migu_riscv_decode ALL
    DEPENDS ${MIGU_RISCV_OPCODES}
)