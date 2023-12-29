


module TbTop #(
    localparam WIDTH = 32,
    localparam SIZE = $clog2(WIDTH)
)(
    input  wire clk,
    input  wire [WIDTH-1:0]  in,
    input  wire              en,
    output wire [SIZE-1:0]   out
);

   Encoder #(.WIDTH(WIDTH), .SIZE(SIZE))
       _encoder(.in, .en, .out);

endmodule : TbTop
