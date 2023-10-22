/* MigU full CPU Verilog TB top module.
 *
 * Copyright Igor Lesik 2020-2023.
 *
 * External C-TB drives the inputs and checks the outputs.
 */

//localparam CFG_ADDR_WIDTH = 16;

module TbTop #(
    localparam ADDR_WIDTH = 16
)(
    input wire clk,
    input wire rst,
    input wire [ADDR_WIDTH-1:0] rst_addr
);
    localparam INSN_SIZE_BITS = RISCV_INSN_SIZE_BITS;

    //// JTAG signals:
    //wire tck, tms, tdi, tdo, trstn;

    //// JTAG signals driven by external OpenOCD process via Remote Bitbanging
    //SimDpiJtag#(.TCK_PERIOD(10), .ALWAYS_ENABLE(1), .TCP_PORT(9999))
    //    jtag_(
    //        .clk,
    //        .rst,
    //        .tck,
    //        .tms,
    //        .tdi,
    //        .trstn,
    //        .tdo
    //);

    MigUCore#(.ADDR_WIDTH(ADDR_WIDTH)) _cpu(
        .clk(clk),
        .rst(rst),
        .rst_addr(rst_addr[ADDR_WIDTH-1:2])
    );

endmodule: TbTop
