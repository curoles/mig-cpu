localparam MIGU_ALU_CMD_WIDTH   = 4;
localparam MIGU_ALU_NR_COMMANDS = 8+4;

/*typedef enum bit[ALU1_CMD_WIDTH-1:0] {
    ALU1_OP_TRANSFER   = 0,
    ALU1_OP_INC        = 1,
    ALU1_OP_ADD        = 2,
    ALU1_OP_ADD_PLUS1  = 3,
    ALU1_OP_SUB_MINUS1 = 4,
    ALU1_OP_SUB        = 5,
    ALU1_OP_DEC        = 6,
    ALU1_OP_TRANSFER2  = 7,
    ALU1_OP_AND        = 8,
    ALU1_OP_OR         = 9,
    ALU1_OP_XOR        = 10,
    ALU1_OP_NOT        = 11
} Alu1Op;*/

/*
 *
 *
 * Substraction is using 2's complements.
 * Negating B is to find its 2's complement, 2's complement of B is ~B + 1,
 * that is invert and add 1.
 * Therefore A - B = A + B2s = A + ~B + 1.
 * When using RippleCarryAdder we need:
 * 1. set carry in `ci` to HI for +1, ci = sub_add;
 * 2. B' = ~B = B XOR sub_add.
 *
 *
 *
 *
 * References:
 * - https://www.egr.msu.edu/classes/ece410/mason/files/Ch12.pdf
 *
 *
 */
module MigUAlu #(
    parameter WIDTH = 64,
    localparam CMD_WIDTH = MIGU_ALU_CMD_WIDTH
)(
    input  wire [CMD_WIDTH-1:0] cmd,
    input  wire [WIDTH-1:0]     in1,
    input  wire [WIDTH-1:0]     in2,
    output wire                 co,
    output wire [WIDTH-1:0]     out
);

    localparam NR_COMMANDS = MIGU_ALU_NR_COMMANDS;

                                   //S012 C cmd
    localparam CMD_TRANSFER   = 0; // 000 0 0000 out = in1
    localparam CMD_INC        = 1; // 000 1 0001 out = in1 + 1
    localparam CMD_ADD        = 2; // 100 0 0010 out = in1 + in2
    localparam CMD_ADD_PLUS1  = 3; // 100 1 0011 out = in1 + in2 + 1
    localparam CMD_SUB_MINUS1 = 4; // 010 0 0100 out = in1 + ~in2
    localparam CMD_SUB        = 5; // 010 1 0101 out = in1 + ~in2 + 1
    localparam CMD_DEC        = 6; // 110 0 0110 out = in1 - 1 (in1 + 111=in1 + 000 - 1=in1 - 1)
    localparam CMD_TRANSFER2  = 7; // 110 1 0111 out = in1

    localparam CMD_AND        = 8; // 001   1000 out = in1 & in2
    localparam CMD_OR         = 9; // 101   1001 out = in1 | in2
    localparam CMD_XOR        =10; // 011   1010 out = in1 ^ in2
    localparam CMD_NOT        =11; // 111   1011 out = ~in1

    wire [2:0] opsel;

    assign opsel[0] = (cmd == CMD_ADD || cmd == CMD_ADD_PLUS1 ||
        cmd == CMD_DEC || cmd == CMD_TRANSFER2 || cmd == CMD_OR || cmd == CMD_NOT);

    assign opsel[1] = cmd[2] | (cmd[3] & cmd[1]);

    assign opsel[2] = cmd[3];

    wire [WIDTH-1:0] in2_inv;

    Inv#(WIDTH) _inv2(.in(in2), .out(in2_inv));

    wire [WIDTH-1:0] adder_in1;
    wire [WIDTH-1:0] adder_in2;
    wire [WIDTH-1:0] adder_out;
    wire             adder_ci;

    assign adder_in1 = in1;

    assign adder_ci = cmd[0];

    genvar i;
    generate
    for (i = 0; i < WIDTH; i++) begin : in2_sel
        assign adder_in2[i] = (in2[i] & opsel[0]) | (in2_inv[i] & opsel[1]);
    end
    endgenerate

    RippleCarryAdder#(WIDTH) _adder(
        .in1(adder_in1),
        .in2(adder_in2),
        .ci(adder_ci),
        .co(co),
        .sum(adder_out)
    );

    wire [WIDTH-1:0] logic_block_out;

    Mux4#(WIDTH) _logic_block(
        .in1(in1 & in2), // AND
        .in2(in1 | in2), // OR
        .in3(in1 ^ in2), // XOR
        .in4(~in1),      // NOT
        .sel(opsel[1:0]),
        .out(logic_block_out)
    );

    assign out = (opsel[2] == 1)? logic_block_out : adder_out;


endmodule: MigUAlu
