// https://classes.engineering.wustl.edu/permanant/cse260m/images/9/95/Tsmc18_component.pdf
/* verilator lint_off DECLFILENAME */
module NOR2(
    input  wire A,
    input  wire B,
    output wire Y
);

   nor _nor2(Y, A, B);

endmodule
/* verilator lint_on DECLFILENAME */
