/**@file
* @brief
* @author Igor Lesik 2023
* @copyright Igor Lesik 2023
*
* http://www.sunburst-design.com/papers/CummingsDesignCon2005_SystemVerilog_ImplicitPorts.pdf
*
*/


module RiscvInsnTypeDecode
import riscv_insn_types::*;
(
    input  wire                clk,
    input  riscv::insn_t       insn,
    output riscv::insn_info_t  info
);

    always @ (posedge clk)
    begin
        if (is_type_R(insn)) begin
            info <= type_R_extract_fields(.insn(insn));
        end
        else if (is_type_I(insn)) begin
            info <= type_I_extract_fields(.insn(insn));
        end
        else if (is_type_S(insn)) begin
            info <= type_S_extract_fields(.insn(insn));
        end
        else if (is_type_B(insn)) begin
            info <= type_B_extract_fields(.insn(insn));
        end
        else if (is_type_U(insn)) begin
            info <= type_U_extract_fields(.insn(insn));
        end
        else if (is_type_J(insn)) begin
            info <= type_J_extract_fields(.insn(insn));
        end
        else begin
            //assert(0) else $error("%m: unreached");
            //info <= '{default:0, itype:RISCV_INSN_TYPE_UNDEF};
            info <= info;
        end
    end

endmodule
