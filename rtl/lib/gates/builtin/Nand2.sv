/* 2-input NAND gate.
 */
module Nand2 #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    output wire [WIDTH-1:0] out
);

    nand /*(strength)*/ /*#(3 delays)*/ _nand(out, in1, in2);

endmodule
