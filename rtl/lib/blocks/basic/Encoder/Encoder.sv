/**@file
 * @author Igor Lesik 2023
 *
 */

/** 1-hot 2^N signal to width[N] signal Encoder.
 *
 *
 */
module Encoder #(
    parameter WIDTH,
    parameter SIZE = $clog2(WIDTH)
)(
    input  wire [WIDTH-1:0]  in,
    input  wire              en,
    output logic [SIZE-1:0]   out
);

    typedef logic [SIZE-1:0] width_size_signal;

    always_comb begin
        assert(!$isunknown(in)) else $error("%m: input is X");
        out = 'z;
        for (int i = 0; i < WIDTH; i = i + 1) begin
            if (en && in[i] == 1'b1)
                out = width_size_signal'(i);
        end
    end

endmodule: Encoder
