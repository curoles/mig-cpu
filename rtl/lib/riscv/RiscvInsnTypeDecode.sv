/**@file
* @brief
* @author Igor Lesik 2023
* @copyright Igor Lesik 2023
*
* http://www.sunburst-design.com/papers/CummingsDesignCon2005_SystemVerilog_ImplicitPorts.pdf
*
*/
//import riscv_insn_types::*;


module RiscvInsnTypeDecode(
    input  wire        clk,
    input  wire [31:0] insn,
    output  reg [6:0]  opcode,
    output  reg [4:0]  rd, rs1, rs2,
    output  reg [2:0]  funct3,
    output  reg [6:0]  funct7,
    output  reg [31:0] imm
);
import riscv_insn_types::*;

    always @ (posedge clk)
    begin
        if (is_type_R(insn)) begin
            type_R_extract_fields(insn,
                opcode, rd, rs1, rs2, funct3, funct7, imm);
        end
        else begin
            //FIXME
            type_R_extract_fields(insn,
                opcode, rd, rs1, rs2, funct3, funct7, imm);
        end
    end

endmodule
