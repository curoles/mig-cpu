// http://bibl.ica.jku.at/dc/build/html/basiccircuits/basiccircuits.html

/* verilator lint_off DECLFILENAME */
module MAJ3  (
    input wire in1,
    input wire in2,
    input wire in3,
    output wire out
);

    supply1 vdd;
    supply0 gnd;

    wire w1_p;
    wire w2_p;
    wire w3_p;

    wire w1_n;
    wire w2_n;
    wire w3_n;

    wire o;
    INV _inv_out(.in(o), .out(out));


    pmos p1(w1_p, vdd, in2);
    pmos p2(o, w1_p, in1);

    pmos p3(w2_p, vdd, in3);
    pmos p4(o, w2_p, in1);

    pmos p5(w3_p, vdd, in3);
    pmos p6(o, w3_p, in2);


    pmos n1(w1_n, gnd, in2);
    pmos n2(o, w1_n, in1);

    pmos n3(w2_n, gnd, in3);
    pmos n4(o, w2_n, in1);

    pmos n5(w3_n, gnd, in3);
    pmos n6(o, w3_n, in2);

endmodule
/* verilator lint_on DECLFILENAME */
