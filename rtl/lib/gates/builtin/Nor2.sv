/* 2-input NOR gate.
 */
module Nor2 #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    output wire [WIDTH-1:0] out
);

    nor /*(strength)*/ /*#(3 delays)*/ _nor(out, in1, in2);

endmodule
