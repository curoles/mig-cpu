/**@file
 * @brief
 * @author Igor Lesik 2023
 * @copyright Igor Lesik 2023
 *
 * References:
 * - https://github.com/srpoyrek/RISC-V/blob/master/instruction_decoder/src/instruction_decoder.v
 */
package riscv_insn_types;

import riscv::*;
export riscv::*; // package chaining


localparam logic [6:0] type_R_mask   = 7'b0110011;
localparam logic [6:0] type_S_mask   = 7'b0100011;
localparam logic [6:0] type_B_mask   = 7'b1100011;
localparam logic [6:0] type_U_mask1  = 7'b0110111;
localparam logic [6:0] type_U_mask2  = 7'b0010111;
localparam logic [6:0] type_J_mask   = 7'b1101111;

// immediate inst, load inst, jp and link reg, envirnoment call & break
localparam logic [6:0] type_I_mask1  = 7'b0010011;
localparam logic [6:0] type_I_mask2  = 7'b0000011;
localparam logic [6:0] type_I_mask3  = 7'b1100111;
localparam logic [6:0] type_I_mask4  = 7'b1110011;

function automatic bit is_type_R(input insn_t insn);
begin
    is_type_R = (insn[6:0] == type_R_mask);
end
endfunction

function automatic bit is_type_I(input insn_t insn);
begin
    is_type_I = (insn[6:0] == type_I_mask1 || insn[6:0] == type_I_mask2 ||
        insn[6:0] == type_I_mask3 || insn[6:0] == type_I_mask4);
end
endfunction

function automatic bit is_type_S(input insn_t insn);
begin
    is_type_S = (insn[6:0] == type_S_mask);
end
endfunction

function automatic bit is_type_B(input insn_t insn);
begin
    is_type_B = (insn[6:0] == type_B_mask);
end
endfunction

function automatic bit is_type_U(input insn_t insn);
begin
    is_type_U = (insn[6:0] == type_U_mask1 || insn[6:0] == type_U_mask2);
end
endfunction

function automatic bit is_type_J(input insn_t insn);
begin
    is_type_J = (insn[6:0] == type_J_mask);
end
endfunction

function automatic insn_info_t type_R_extract_fields(
    input insn_t insn
);
begin
    insn_info_t info;
    info.itype  = RISCV_INSN_TYPE_R;
    info.opcode = insn[6:0];
    info.rd     = insn[11:7];
    info.funct3 = insn[14:12];
    info.rs1    = insn[19:15];
    info.rs2    = insn[24:20];
    info.funct7 = insn[31:25];
    info.imm    = '0;
    return info;
end
endfunction

// immediate inst, load inst, jp and link reg, envirnoment call & break
function automatic insn_info_t type_I_extract_fields(
    input insn_t insn
);
begin
    insn_info_t info;
    info.itype  = RISCV_INSN_TYPE_I;
    info.opcode = insn[6:0];
    info.rd     = insn[11:7];
    info.funct3 = insn[14:12];
    info.rs1    = insn[19:15];
    info.rs2    = '0;
    info.funct7 = '0;
    info.imm    = {8'h0, insn[31:20]};
    return info;
end
endfunction

function automatic insn_info_t type_S_extract_fields(
    input insn_t insn
);
begin
    insn_info_t info;
    info.itype  = RISCV_INSN_TYPE_S;
    info.opcode = insn[6:0];
    info.rd     = '0;
    info.funct3 = insn[14:12];
    info.rs1    = insn[19:15];
    info.rs2    = insn[24:20];
    info.funct7 = '0;
    info.imm    = {8'h0, insn[31:25], insn[11:7]};
    return info;
end
endfunction

function automatic insn_info_t type_B_extract_fields(
    input insn_t insn
);
begin
    insn_info_t info;
    info.itype  = RISCV_INSN_TYPE_B;
    info.opcode = insn[6:0];
    info.rd     = '0;
    info.funct3 = insn[14:12];
    info.rs1    = insn[19:15];
    info.rs2    = insn[24:20];
    info.funct7 = '0;
    info.imm    = {7'h0, insn[31], insn[7], insn[30:25], insn[11:8], 1'b0};
    return info;
end
endfunction

function automatic insn_info_t type_U_extract_fields(
    input insn_t insn
);
begin
    insn_info_t info;
    info.itype  = RISCV_INSN_TYPE_U;
    info.opcode = insn[6:0];
    info.rd     = '0;
    info.funct3 = '0;
    info.rs1    = '0;
    info.rs2    = '0;
    info.funct7 = '0;
    info.imm    = {insn[31:12]};
    return info;
end
endfunction

function automatic insn_info_t type_J_extract_fields(
    input insn_t insn
);
begin
    insn_info_t info;
    info.itype  = RISCV_INSN_TYPE_J;
    info.opcode = insn[6:0];
    info.rd     = '0;
    info.funct3 = '0;
    info.rs1    = '0;
    info.rs2    = '0;
    info.funct7 = '0;
    info.imm    = {insn[31], insn[19:12], insn[20], insn[30:21]};
    return info;
end
endfunction

endpackage: riscv_insn_types
