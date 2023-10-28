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

    localparam MEM_ADDR_WIDTH = ADDR_WIDTH - RISCV_INSN_SIZE_BITS;

    wire sram_rd_en;
    wire [MEM_ADDR_WIDTH-1:0] sram_rd_addr;
    wire sram_rd_valid;
    wire [INSN_WIDTH-1:0] sram_rd_data;
    wire sram_wr_en;
    wire [MEM_ADDR_WIDTH-1:0] sram_wr_addr;
    wire [INSN_WIDTH-1:0] sram_wr_data;

    SimRAM#(.DATA_SIZE_BYTES(INSN_SIZE), .ADDR_WIDTH(MEM_ADDR_WIDTH))
        _sram(.clk(clk),
            .rd_en(sram_rd_en), .rd_addr(sram_rd_addr),
            .rd_valid(sram_rd_valid), .rd_data(sram_rd_data),
            .wr_en(sram_wr_en), .wr_addr(sram_wr_addr), .wr_data(sram_wr_data)
    );

    assign sram_rd_en = 0;
    assign sram_wr_en = 0;
    assign sram_rd_addr = 0;
    assign sram_wr_addr = 0;
    assign sram_wr_data = 0;

endmodule: MigUCore
