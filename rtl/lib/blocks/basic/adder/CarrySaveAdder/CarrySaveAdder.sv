module CarrySaveAdder #(
    parameter WIDTH
)(
    input  logic [WIDTH-1:0]    in1,
    input  logic [WIDTH-1:0]    in2,
    input  logic [WIDTH-1:0]    in3,
    output logic [WIDTH-1:0]    psum, //partial sum
    output logic [WIDTH-1:0]    sco  //shift-carry
);


    generate
    genvar i;
        for (i = 0; i < DW; i++) begin : fa_gen
            FullAdderAOI _fa(
                .in1(in1[i]),
                .in2(in2[i]),
                .ci(in3[i]),
                .sum(psum[i]),
                .co(sco[i])
            );
        end
    endgenerate

endmodule

