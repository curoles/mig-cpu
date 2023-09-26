/* Inverter.
 * Author: Igor Lesik 2020-2023
 *
 */
module Inv #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] in,
    output wire [WIDTH-1:0] out // out = ~in
);
    not /*(strength)*/ /*#(2 delays)*/ _not(out, in);

endmodule
