module TbTop (
    input  wire clk,
    input  wire enable,
    output wire gclk_lo,
    output wire gclk_hi
);

    GatedClk #(1) _gclk_lo(.clk, .enable, .scan_enable(1'b0), .gclk(gclk_lo));
    GatedClk #(0) _gclk_hi(.clk, .enable, .scan_enable(1'b0), .gclk(gclk_hi));

endmodule : TbTop
