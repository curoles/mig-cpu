/* Inverter.
 * Author: Igor Lesik 2020-2023
 *
 */
module Inv #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] in,  // to be inverted
    output wire [WIDTH-1:0] out  // out is inverted in
);

    assign out = ~in;

endmodule
