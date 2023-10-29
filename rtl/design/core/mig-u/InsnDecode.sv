/**@file
 * @brief
 * @author Igor Lesik 2023
 * @copyright Igor Lesik 2023
 *
 */

module InsnDecode #(
    parameter ADDR_WIDTH,
    localparam INSN_SIZE = 4,
    localparam INSN_WIDTH = INSN_SIZE * 8,
    localparam INSN_SIZE_BITS = $clog2(INSN_SIZE)
)(
    input  wire                               clk,
    input  wire                               rst,
    input  wire                               fetch_en,
    input  wire [ADDR_WIDTH-1:INSN_SIZE_BITS] fetch_pc,
    input  wire [INSN_WIDTH-1:0]              insn
);

    always @ (posedge clk)
    begin
        if (!fetch_en) begin
            //
        end
        else begin
            //

            $display("%0t Decode: pc:%x, en: %d, data: %x",
                $time, {fetch_pc, 2'b00}, fetch_en, insn);
        end
    end

 endmodule: InsnDecode