// NAND2
// https://classes.engineering.wustl.edu/permanant/cse260m/images/9/95/Tsmc18_component.pdf
module Nand2 #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    output wire [WIDTH-1:0] out
);

    genvar i;
    generate
    for (i = 0; i < WIDTH; i = i + 1) begin
        NAND2 _nand2(.A(in1[i]), .B(in2[i]), .Y(out[i]));
    end
    endgenerate

endmodule
