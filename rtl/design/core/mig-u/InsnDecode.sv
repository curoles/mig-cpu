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

    /*output  reg*/ wire [6:0]  opcode;
    /*output  reg*/ wire [4:0]  rd, rs1, rs2;
    /*output  reg*/ wire [2:0]  funct3;
    /*output  reg*/ wire [6:0]  funct7;
    /*output  reg*/ wire [31:0] imm;

    RiscvInsnTypeDecode _insn_type_decode(
        .clk(clk), .insn(insn),
        .opcode(opcode),
        .rd(rd), .rs1(rs1), .rs2(rs2),
        .funct3(funct3), .funct7(funct7),
        .imm(imm)
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