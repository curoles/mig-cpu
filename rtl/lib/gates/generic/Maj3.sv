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

    assign out = (in1 & in2) | (in2 & in3) | (in1 & in3);

endmodule
