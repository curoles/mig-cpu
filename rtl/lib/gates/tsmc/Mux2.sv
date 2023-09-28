module Mux2 #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    input  wire             sel,
    output wire [WIDTH-1:0] out
);

    genvar i;
    generate
    for (i = 0; i < WIDTH; i = i + 1) begin
        MUX2 _mux2(.A(in1[i]), .B(in2[i]), .S(sel), .Y(out[i]));
    end
    endgenerate

endmodule
