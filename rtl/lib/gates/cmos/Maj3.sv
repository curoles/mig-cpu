/* 3-input MAJ3 gate.
 * Author: Igor Lesik 2020-2023
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

    genvar i;
    generate
    for (i = 0; i < WIDTH; i = i + 1) begin
        MAJ3 _maj3(.in1(in1[i]), .in2(in2[i]), .in3(in3[i]), .out(out[i]));
    end
    endgenerate

endmodule
