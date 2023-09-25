/* 2-input AND gate.
 */
module And2 #(parameter WIDTH = 1)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    output wire [WIDTH-1:0] out
);

    and /*(strength)*/ /*#(3 delays)*/ _and(out, in1, in2);

endmodule
