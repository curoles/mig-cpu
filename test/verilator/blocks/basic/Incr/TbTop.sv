/* Fast Incrementor TB.
 * Author: Igor Lesik 2019
 *
 */



/* Verilog TB top module.
 *
 * External C-TB drives the inputs and checks the outputs.
 */
module TbTop(
    input   wire        clk,
    input   wire [31:0] in,
    output  wire [8:0]  out9,
    output  wire        cy9,
    output  wire [15:0] out16,
    output  wire        cy16
);

    Incr9  _incr9 (.in(in[8:0]), .out(out9),  .cy(cy9));
    Incr16 _incr16(.in(in[15:0]), .out(out16), .cy(cy16));

endmodule: TbTop
