/* 3-input Majority gate.
 *
 *
 */
 /* verilator lint_off DECLFILENAME */
module MAJ3 (
    input  wire in1,
    input  wire in2,
    input  wire in3,
    output wire out
);

    wire i12, i23, i13;

    and _and12(i12, in1, in2);
    and _and23(i23, in2, in3);
    and _and13(i13, in1, in3);

    or _or12_23_13(out, i12, i23, i13);

endmodule
/* verilator lint_on DECLFILENAME */
