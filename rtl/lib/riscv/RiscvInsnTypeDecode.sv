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
            type_R_extract_fields(.insn(insn), .info(info));
        end
        else begin
            //FIXME
            type_R_extract_fields(.insn(insn), .info(info));
        end
    end

endmodule
