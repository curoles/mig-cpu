/* 2:1 Multiplexer.
 * Author: Igor Lesik 2020-2023
 *
 */
module Mux2  #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    input  wire             sel,
    output wire [WIDTH-1:0] out
);

    genvar i;
    generate
    for (i = 0; i < WIDTH; i = i + 1) begin
        MUX2 _mux2(.in1(in1[i]), .in2(in2[i]), .sel(sel), .out(out[i]));
    end
    endgenerate

endmodule
