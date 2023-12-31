/**@file
 * @brief Bit operations.
 * @author Igor Lesik 2023
 *
 * References:
 * - class with parameters,
 *   https://sutherland-hdl.com/papers/2013-SNUG-SV_Synthesizable-SystemVerilog_paper.pdf
 * - https://www.amiq.com/consulting/2017/05/29/how-to-pack-data-using-systemverilog-streaming-operators/
 * - https://www.amiq.com/consulting/2017/06/23/how-to-unpack-data-using-the-systemverilog-streaming-operators/
 *
 */


/** Collection of bit operation functions.
 *
 * Class parameters become static function parameters.
 */
virtual class BitFunctions #(
    parameter type T
);

/* Reverse bits.
 * Example: 101001 -> 100101
 */
static function T reverse(input T a);
    return {<<{a}};
endfunction

endclass

///* verilator lint_off DECLFILENAME */
//virtual class ArrayFunctions #(
//    parameter type T
//);
//
//static function int pack_array(input T a);
//    return {>>{a}};
//endfunction
//
//endclass
///* verilator lint_on DECLFILENAME */
