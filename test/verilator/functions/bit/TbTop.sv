module TbTop #(
    localparam WIDTH = 64
)(
    input  wire clk,
    input  wire [WIDTH-1:0]  in
    //output wire [WIDTH-1:0]  out
);

initial begin: test_bit_reverse
    bit [15:0] a = 16'b1010010001000010;
    bit [15:0] b = BitFunctions#(/*type(a)*/bit[15:0])::reverse(a);
    //TODO: find more about "Typedef not linked" when we use `type(a)`
    assert(b == 16'b0100001000100101)
    else $error("line %-d: 0x%h vs expected 0x%h", `__LINE__, b, 16'b0100001000100101);
end

//initial begin: test_pack_array
//    bit [7:0] a[4] = '{8'ha, 8'hb, 8'hc, 8'hd};
//    typedef bit [7:0] ta [3:0];
//    int b = ArrayFunctions#(/*type(a)*/ta)::pack_array(a);
//end

endmodule : TbTop
