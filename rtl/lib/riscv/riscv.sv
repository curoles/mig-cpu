/**@file
 * @brief
 * @author Igor Lesik 2023
 * @copyright Igor Lesik 2023
 *
 */
package riscv;

typedef logic [31:0] insn_t;

typedef struct packed {
    logic [6:0] opcode;
    logic [4:0] rd, rs1, rs2;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [31:0] imm;
} insn_info_t;

endpackage: riscv
