// MX2 https://classes.engineering.wustl.edu/permanant/cse260m/images/9/95/Tsmc18_component.pdf
module MUX2(
    input  wire A,
    input  wire B,
    input  wire S,
    output wire Y
);

   or _or2(Y, A & S, B & ~S);

endmodule
