/**@file
 * @brief
 * @author Igor Lesik 2023
 * @copyright Igor Lesik 2023
 *
 */

module NextIP #(
    parameter ADDR_WIDTH,
    parameter INSN_SIZE_BITS
)(
    input  wire                               clk,
    input  wire                               rst,
    input  wire [ADDR_WIDTH-1:INSN_SIZE_BITS] rst_pc,
    input  wire                               fetch_en,
    input  wire [ADDR_WIDTH-1:INSN_SIZE_BITS] fetch_pc,
    output  reg                               next_pc_valid,
    output  reg [ADDR_WIDTH-1:INSN_SIZE_BITS] next_pc
);
    reg rst_delay1;
    wire [ADDR_WIDTH-1:INSN_SIZE_BITS] fetch_pc_plus1;
    wire addr_overflow;

    Incr16 _incr(.in(fetch_pc), .out(fetch_pc_plus1), .cy(addr_overflow));

    always @ (posedge clk)
    begin
        rst_delay1 <= rst;
        if (rst || rst_delay1) begin
            next_pc <= rst_pc;
            next_pc_valid <= ~rst;
        end
        else if (fetch_en) begin
            next_pc <= fetch_pc_plus1;
            next_pc_valid <= ~rst;
        end
        else begin
            next_pc <= fetch_pc;
            next_pc_valid <= 0;
        end

        $display("%0t Next IP: %x, en: %d, rst: %d",
            $time, {fetch_pc, 2'b00}, fetch_en, rst);
    end

 endmodule: NextIP