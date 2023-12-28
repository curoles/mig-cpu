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
    parameter SIZE = $clog(WIDTH)
)(
    input  wire [WIDTH-1:0]  in,
    input  wire              en,
    output wire [SIZE-1:0]   out
);

    always_comb begin
        assert(!$isunknown(in)) else $error("%m: input is X");
        out = 'z;
        for (int i = 0; i < WIDTH; i = i + 1) begin
            if (in[i] == 1'b1)
                out = i;
        end
    end

endmodule: Encoder
