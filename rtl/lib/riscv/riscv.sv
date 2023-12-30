/**@file
 * @brief
 * @author Igor Lesik 2023
 * @copyright Igor Lesik 2023
 *
 */
package riscv;

typedef logic [31:0] insn_t;

/* Instruction type.
 *
 * `riscv::insn_type_t t; $display("%s", t.name())`
 */
typedef enum logic [2:0] {
    RISCV_INSN_TYPE_UNDEF,
    RISCV_INSN_TYPE_R,
    RISCV_INSN_TYPE_I,
    RISCV_INSN_TYPE_S,
    RISCV_INSN_TYPE_B,
    RISCV_INSN_TYPE_U,
    RISCV_INSN_TYPE_J
} insn_type_t;

typedef struct packed {
    logic [6:0] opcode;
    logic [4:0] rd, rs1, rs2;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [19:0] imm;
    insn_type_t itype;
} insn_info_t;

endpackage: riscv
