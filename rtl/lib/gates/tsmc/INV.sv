// https://classes.engineering.wustl.edu/permanant/cse260m/images/9/95/Tsmc18_component.pdf
module INV(
    input  wire A,
    output wire Y
);

    not _inv(Y, A);

endmodule
