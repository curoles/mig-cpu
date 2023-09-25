/* Inverter.
 *
 *
 */
module Inv #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] in,
    output wire [WIDTH-1:0] out // out = ~in
);
    genvar i;
    generate
    for (i = 0; i < WIDTH; i = i + 1) begin
        INV _inv(.in(in[i]), .out(out[i]));
    end
    endgenerate

endmodule
