set(RISCV_CC ${RISCV}/bin/riscv64-unknown-elf-gcc)
set(RISCV_OBJCOPY ${RISCV}/bin/riscv64-unknown-elf-objcopy)
set(CFLAGS_FOR_STANDALONE_BUILD -static -ffreestanding -nostartfiles -nodefaultlibs)
set(TEST_CFLAGS ${CFLAGS_FOR_STANDALONE_BUILD}) # -Wall -Werror)
set(COMPILE_TEST ${RISCV_CC} ${TEST_CFLAGS} -T ${CMAKE_CURRENT_SOURCE_DIR}/bare.ld ) # ${CMAKE_CURRENT_SOURCE_DIR}/../bare.S)

set(ASM_TESTS
    test0001
)

foreach(testname ${ASM_TESTS})
    set(tn ${testname})
    add_custom_command(OUTPUT ${tn}.out ${tn}.hex
        COMMAND ${COMPILE_TEST} ${CMAKE_CURRENT_SOURCE_DIR}/${testname}.S -o ${tn}.out
        COMMAND ${RISCV_OBJCOPY} -O verilog --verilog-data-width=4 ${tn}.out ${tn}.hex
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/${testname}.S
        #DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/../bare.S
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/bare.ld
    )
    add_custom_target(migu_asm_test_${tn} ALL DEPENDS ${tn}.out)

    set(TEST_PLUS_ARGS +MEMFILE=${CMAKE_CURRENT_BINARY_DIR}/${tn}.hex)
    add_test(NAME ${TEST_NAME}_asm_test_${tn}
        COMMAND ${CMAKE_CURRENT_BINARY_DIR}/../obj_dir_${TEST_NAME}/V${TB_TOP} ${TEST_PLUS_ARGS}
    )
endforeach()
