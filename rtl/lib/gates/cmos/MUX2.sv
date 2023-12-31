/* 2:1 Multiplexer.
 *
 *
 * 
 * <pre>
 *    ---------+-------------+------ vdd
 *             |             |
 *    in1 +--o| p1  in2 +--o| p3
 *             |             |      pmos is open when gate 0
 *             |             |
 *    sel +--o| p2 ~sel +--o| p4
 *             |             |
 *             +-------------+---------INV----->
 *             |             |
 *   ~sel +---| n1  sel +---| n3
 *             |             |      nmos is open when gate 1
 *             |             |
 *    in1 +---| n2  in2 +---| n4
 *             |             |
 *             |             |
 *           --+-------------+------ gnd
 * </pre>
 */
module MUX2 (
    input  wire in1,
    input  wire in2,
    input  wire sel,
    output wire out
);

    supply1 vdd;
    supply0 gnd;

    wire nsel;
    INV _inv_sel(.in(sel), .out(nsel));

    wire o;
    INV _inv_out(.in(o), .out(out));

    wire p1_p2, p3_p4, n1_n2, n3_n4;

    // pmos drain source gate
    pmos p1(p1_p2,  vdd,   in1);
    pmos p2(o,    p1_p2,   sel);

    pmos p3(p3_p4,  vdd,   in2);
    pmos p4(o,    p3_p4,   nsel);

    // nmos drain source gate
    nmos n1(o,    n1_n2,   nsel);
    nmos n2(n1_n2,  gnd,   in1);

    nmos n3(o,    n3_n4,   sel);
    nmos n4(n3_n4,  gnd,   in2);

endmodule
