/* 3-input Majority gate.
 *
 *
 */
module Maj3 #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    input  wire [WIDTH-1:0] in3,
    output wire [WIDTH-1:0] out
);

    wire [WIDTH-1:0] i12, i23, i13;

    and _and12(i12, in1, in2);
    and _and23(i23, in2, in3);
    and _and13(i13, in1, in3);

    or _or12_23_13(out, i12, i23, i13);

endmodule
