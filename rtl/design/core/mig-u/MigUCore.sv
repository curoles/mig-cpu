/**@file
 * @brief
 * @author Igor Lesik 2023
 * @copyright Igor Lesik 2023
 */

/* Mig-U (micro) core.
 *
 */
module MigUCore #(
    parameter ADDR_WIDTH,
    localparam INSN_SIZE = 4,
    localparam INSN_SIZE_BITS = INSN_SIZE * 8
)(
    input  wire                  clk,
    input  wire                  rst,
    input  wire [ADDR_WIDTH-1:2] rst_addr
);

    initial begin
    /*InsnSizeIs32:*/ assert(MigUCore.INSN_SIZE_BITS == 32)
        else $error("instruction size must be 32 bits");
    end

endmodule: MigUCore
