/* Verilog TB top module.
 *
 * Copyright Igor Lesik 2020.
 *
 * External C-TB drives the inputs and checks the outputs.
 */
module TbTop #(
    localparam WIDTH = 64
)(
    input  wire             clk,
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    input  wire             ci,
    output reg  [WIDTH-1:0] sum,
    output reg              co,
    output reg  [WIDTH-1:0] sum_aoi,
    output reg              co_aoi
);

    RippleCarryAdder#(.WIDTH(WIDTH))
        _adder(.in1(in1),
               .in2(in2),
               .ci(ci),
               .co(co),
               .sum(sum)
    );

    RippleCarryAdder#(.WIDTH(WIDTH), 1)
        _adder_aoi(.in1(in1),
               .in2(in2),
               .ci(ci),
               .co(co_aoi),
               .sum(sum_aoi)
    );
endmodule: TbTop
