/*virtual*/ class BitFunctions #(
    parameter WIDTH
);

static function [WIDTH-1:0] reverse(input [WIDTH-1:0] a);
    //TODO use streaming/packing <</>> operator to reverse bits
    return 0;
endfunction

endclass
