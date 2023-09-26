/* 2-input NOR gate.
 * Author: Igor Lesik 2020-2023
 *
 */

module Nor2 #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    output wire [WIDTH-1:0] out
);

    genvar i;
    generate
    for (i = 0; i < WIDTH; i = i + 1) begin
        NOR2 _nor2(.in1(in1[i]), .in2(in2[i]), .out(out[i]));
    end
    endgenerate

endmodule
