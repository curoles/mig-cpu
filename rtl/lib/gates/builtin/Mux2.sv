/* Multiplexer made with NAND
 *
 * Author: Igor Lesik 2020.
 *
 *
 * <pre> 
 *                  +------+
 *                  |      |
 *  in1 +-----------+ NAND |
 *                  |      |o+-+    +------+
 *  sel +-----+-----+      |   |    |      |
 *            |     |      |   |    |      |
 *            |     +------+   +----+ NAND |
 *            |                     |      |o+----+ out
 *            |     +------+   +----+      |
 *            |     |      |   |    |      |
 *            +---+o| NAND |   |    |      |
 *                  |      |o+-+    +------+
 *  in2 +-----------+      |
 *                  |      |
 *                  +------+
 *  </pre>
 */
module Mux2 #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0]  in1,
    input  wire [WIDTH-1:0]  in2,
    input  wire              sel,
    output wire [WIDTH-1:0]  out
);

    wire [WIDTH-1:0] o1, o2;
    Nand2#(WIDTH) _nand1(.out(o1), .in1(in1), .in2({WIDTH{~sel}}));
    Nand2#(WIDTH) _nand2(.out(o2), .in1(in2), .in2({WIDTH{sel}}));
    Nand2#(WIDTH) _nand3(.out(out), .in1(o1), .in2(o2));

endmodule
