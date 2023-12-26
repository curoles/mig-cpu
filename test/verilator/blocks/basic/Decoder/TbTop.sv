


module TbTop #(
    localparam SIZE = 4,
    localparam WIDTH = 1 << SIZE
)(
    input  wire clk,
    input  wire [SIZE-1:0]  in,
    input  wire             en,
    output wire [WIDTH-1:0] out
);

Decoder #(SIZE, WIDTH) _decoder(.in(in), .en(en), .out(out));

endmodule : TbTop
