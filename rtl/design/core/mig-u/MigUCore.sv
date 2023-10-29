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
    localparam INSN_WIDTH = INSN_SIZE * 8,
    localparam INSN_SIZE_BITS = RISCV_INSN_SIZE_BITS
)(
    input  wire                               clk,
    input  wire                               rst,
    input  wire [ADDR_WIDTH-1:INSN_SIZE_BITS] rst_addr
);

    initial begin
    InsnSizeIs32: assert(MigUCore.INSN_WIDTH == 32)
        else $error("instruction size must be 32 bits");
    end

    localparam MEM_ADDR_WIDTH = ADDR_WIDTH - INSN_SIZE_BITS;

    wire [ADDR_WIDTH-1:INSN_SIZE_BITS] fetch_pc;
    wire fetch_en;

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

    assign sram_rd_en = fetch_en;
    assign sram_wr_en = 0;
    assign sram_rd_addr = fetch_pc;
    assign sram_wr_addr = 0;
    assign sram_wr_data = 0;

    NextIP #(ADDR_WIDTH, INSN_SIZE_BITS)
    _nextIP(
        .clk(clk), .rst(rst), .rst_pc(rst_addr),
        .fetch_en(fetch_en),
        .fetch_pc(fetch_pc),
        .next_pc_valid(fetch_en),
        .next_pc(fetch_pc)
    );

    export "DPI-C" function public_get_PC;
    function int unsigned public_get_PC();
        public_get_PC = 32'({fetch_pc, 2'b00});
    endfunction

endmodule: MigUCore
