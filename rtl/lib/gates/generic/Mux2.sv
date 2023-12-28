/* 2:1 Multiplexer.
 * 
 * Author: Igor Lesik 2014.
 *
 * <pre>
 *           +-----+
 * in1 ------| 0   |
 *           | MUX |--- out   
 * in2 ------| 1   |
 *           +--+--+
 *         sel  |
 * </pre>
 */
module Mux2 #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0]  in1,
    input  wire [WIDTH-1:0]  in2,
    input  wire              sel,
    output wire [WIDTH-1:0]  out
);
    always_comb begin
        assert(!$isunknown(sel)) else $error("%m: sel is X");
    end

    assign out = (sel == 1) ? in2 : in1;

endmodule
