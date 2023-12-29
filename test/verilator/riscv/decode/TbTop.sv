module TbTop
import riscv::*;
(
    input  wire clk,
    input  riscv::insn_t  insn,
    input  logic [31:0] test_id, // position in the test array
    output riscv::insn_info_t decoded_info
);

    RiscvInsnTypeDecode _insn_type_decode(
        .clk(clk),
        .insn(insn),
        .info(decoded_info)
    );

endmodule : TbTop
