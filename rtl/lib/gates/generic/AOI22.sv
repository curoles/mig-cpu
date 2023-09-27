/* Complex gate And-Or-Invertor.
 *
 *
 * <pre>
 *  in1 ----------+--\
 *                AND +----+
 *  in2 ----------+--/|    |
 *                    |NOR |o-----
 *  in3 ----------+--\|    |
 *                AND +----+
 *  in4 ----------+--/
 * </pre>
 *
 */
module AOI22 (
    input  wire in1, // to be AND-ed with in2
    input  wire in2, // to be AND-ed with in1
    input  wire in3, // to be AND-ed with in4
    input  wire in4, // to be AND-ed with in3
    output wire out  // NOR the results of two ANDs
);

    assign out = ~((in1 & in2) | (in3 & in4));

endmodule
