/* 4:1 Multiplexer
 * Author: Igor Lesik 2014
 *
 */

module Mux4 #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0]  in1,
    input  wire [WIDTH-1:0]  in2,
    input  wire [WIDTH-1:0]  in3,
    input  wire [WIDTH-1:0]  in4,
    input  wire [1:0]        sel,
    output wire [WIDTH-1:0]  out
);
    always_comb begin
        assert(!$isunknown(sel)) else $error("%m: sel is X");
    end

    assign out = (sel == 3) ? in4 :
                 (sel == 2) ? in3 :
                 (sel == 1) ? in2 : in1;
/*
 assign Z =    (~S1 & ~S0 & I0)
              | (~S1 &  S0 & I1)
              | ( S1 & ~S0 & I2)
              | ( S1 &  S0 & I3);*/
endmodule
