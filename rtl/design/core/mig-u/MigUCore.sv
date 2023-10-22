/**@file
 * @brief
 * @author Igor Lesik 2023
 * @copyright Igor Lesik 2023
 *
 * https://github.com/riscv/riscv-v-spec
 * https://github.com/riscv/riscv-v-spec/blob/master/v-spec.adoc#risc-v-v-vector-extension
 */

localparam RISCV_INSN_SIZE = 4;
localparam RISCV_INSN_WIDTH = RISCV_INSN_SIZE * 8;
localparam RISCV_INSN_SIZE_BITS = $clog2(RISCV_INSN_SIZE);

/* Mig-U (micro) core.
 *
 */
module MigUCore #(
    parameter ADDR_WIDTH,
    localparam INSN_SIZE = RISCV_INSN_SIZE,
    localparam INSN_WIDTH = INSN_SIZE * 8
)(
    input  wire                  clk,
    input  wire                  rst,
    input  wire [ADDR_WIDTH-1:2] rst_addr
);

    initial begin
    InsnSizeIs32: assert(MigUCore.INSN_WIDTH == 32)
        else $error("instruction size must be 32 bits");
    end

endmodule: MigUCore
