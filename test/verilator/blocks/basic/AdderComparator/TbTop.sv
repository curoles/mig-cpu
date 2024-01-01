module TbTop #(
    localparam WIDTH = 50
)(
    input  wire clk,
    input  wire [WIDTH-1:0]  a,
    input  wire [WIDTH-1:0]  b,
    input  wire [WIDTH-1:0]  c,
    output wire              eq
);

AdderComparator #(50) _addcmp(.*);

endmodule : TbTop
