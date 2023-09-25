/* 2-input AND gate.
 *
 *
 * 
 */
module And2 #(
    parameter WIDTH=1
)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    output wire [WIDTH-1:0] out
);
    wire [WIDTH-1:0] nand_output;
    Nand2#(WIDTH)  _nand2(.in1(in1), .in2(in2), .out(nand_output));
    Inv#(WIDTH)   _inv (.in(nand_output), .out(out));

endmodule
