/* Verilog TB top module to test simple gates.
 *
 * Copyright Igor Lesik 2020-2023.
 *
 * External Verilator C-TB drives the inputs and checks the outputs.
 */
module TbTop #(localparam WIDTH=64)(
    input  wire             clk,
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    input  wire [WIDTH-1:0] in3,
    //output wire [WIDTH-1:0] out_inv,
    output wire [WIDTH-1:0] out_and2
    //output wire [WIDTH-1:0] out_nand2,
    //output wire [WIDTH-1:0] out_mux2
);

    //INV #(WIDTH) _inv (.in (in1), .out(out_inv));
    And2#(WIDTH) _and2(.in1(in1), .in2(in2), .out(out_and2));
    //NAND2#(WIDTH) nand2_(.in1(in1), .in2(in2), .out(out_nand2));
    //MUX2#(WIDTH) mux2_(.in1(in1), .in2(in2), .sel(in3[0]), .out(out_mux2));

endmodule: TbTop
