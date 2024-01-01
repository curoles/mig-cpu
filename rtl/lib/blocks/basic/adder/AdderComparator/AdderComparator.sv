/**@file
 * @author Igor Lesik 2019-2023
 * @brief  (A+B) == C adder-comparator
 *
 * References:
 * The Power of Carry-Save Addition, D. R. Lutz 1994
 * https://www.researchgate.net/publication/2630244_The_Power_of_Carry-Save_Addition
 */

module AdderComparator #(
    parameter WIDTH
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire [WIDTH-1:0] c,
    output wire             eq // 1 if (a+b) == c
);
    localparam GROUPS = (WIDTH + 3)/4;
    localparam TAIL_SIZE = WIDTH - ((GROUPS-1)*4);

    wire [WIDTH-1:0] s;
    wire [WIDTH  :0] cy;
    wire [WIDTH-1:0] t;
    wire [GROUPS-1:0] group;
    wire [TAIL_SIZE-1:0] tail;

    assign cy[0] = 0;

    genvar i;
    generate
    for (i = 0; i < WIDTH; i++) begin
        FullAdder _fa(.in1(a[i]), .in2(b[i]), .ci(~c[i]), .sum(s[i]), .co(cy[i+1]));
        assign t[i] = cy[i] ^ s[i];
    end
    endgenerate

    generate
    for (i = 0; i < GROUPS-1; i++) begin
        assign group[i] = ~(t[i*4] & t[i*4+1] & t[i*4+2] & t[i*4+3]);
    end
    for (i = 0; i < TAIL_SIZE; i++) begin
        assign tail[i] = t[(GROUPS-1)*4 + i];
    end
    endgenerate

    assign group[GROUPS-1] = ~( &tail );

    assign eq = ~( |group );

endmodule
