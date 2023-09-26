// https://classes.engineering.wustl.edu/permanant/cse260m/images/9/95/Tsmc18_component.pdf
module NAND2(
    input  wire A,
    input  wire B,
    output wire Y
);

   nand _nand2(Y, A, B);

endmodule
