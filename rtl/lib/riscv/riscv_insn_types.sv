/**@file
 * @brief
 * @author Igor Lesik 2023
 * @copyright Igor Lesik 2023
 *
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

function automatic void type_R_extract_fields(
    input insn_t insn,
    output insn_info_t info
);
begin
    info.itype  = RISCV_INSN_TYPE_R;
    info.opcode = insn[6:0];
    info.rd     = insn[11:7];
    info.funct3 = insn[14:12];
    info.rs1    = insn[19:15];
    info.rs2    = insn[24:20];
    info.funct7 = insn[31:25];
    info.imm    = 0;//FIXME imm;
end
endfunction

endpackage: riscv_insn_types
