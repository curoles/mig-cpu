/* APB master/initiator.
 *
 * Authors: Igor Lesik 2021
 *
 */
module ApbMaster #(
    parameter NR_SLAVES   = 1,
    parameter ADDR_WIDTH  = 5,
    parameter WDATA_WIDTH = 32,
    parameter RDATA_WIDTH = 32
)(
    input  wire                   clk,
    input  wire                   rst,
    output reg  [ADDR_WIDTH-1:0]  addr,
    output reg  [NR_SLAVES-1:0]   sel, // slave selected & data transfer required
    output reg                    wr_rd, // direction=HIGH? wr:rd
    output reg  [WDATA_WIDTH-1:0] wdata,
    input  wire [RDATA_WIDTH-1:0] rdata,
    input  wire                   ready,

    input  wire                   ctrl_req,
    input  wire [NR_SLAVES-1:0]   ctrl_sel,
    input  wire                   ctrl_wr_rd,
    input  wire [ADDR_WIDTH-1:0]  ctrl_addr,
    output wire [RDATA_WIDTH-1:0] ctrl_rdata,
    input  wire [WDATA_WIDTH-1:0] ctrl_wdata,
    output wire                   ctrl_ready
);

    reg req;
    reg req_d1; // signals MUST be stable for 2 clocks on APB

    //ClockSync _clock_sync(
    //    .src_clk(ctrl_clk),      // Source domain slow clock
    //    .src_rst(ctrl_rst),     // Source domain reset
    //    .src_req(ctrl_req),  // Source domain signal to be synchronized
    //    .dst_clk(clk), // Destination domain fast clock
    //    .dst_rst(rst), // Destination domain reset
    //    .dst_req(req)  // Destination domain signal that follows src_req
    //);
    assign req = ctrl_req;
    assign addr = ctrl_addr;
    assign sel = ctrl_sel;
    assign wr_rd = ctrl_wr_rd;
    assign wdata = ctrl_wdata;

    reg wait_rd_reply;

    // APB transaction starts when one-hot bit of `sel` is HIGH.
    //
    always_ff @(posedge clk)
    begin
        if (rst) begin
            sel <= 'h0;
            req_d1 <= 0;
        end else if (req) begin
            $display("%t APB REQ WR/RD=%b addr=%h data=%h",
                $time, ctrl_cmd_wr, ctrl_addr, ctrl_wdata);
            sel    <= ctrl_sel;
            addr   <= ctrl_addr;
            wdata  <= ctrl_wdata;
            wr_rd  <= ctrl_wr_rd;
            req_d1 <= 1;
        end else if (req_d1) begin
            req_d1 <= 0;
            sel    <= sel;
            addr   <= addr;
            wdata  <= wdata;
            wr_rd  <= wr_rd;
        end else begin
            sel    <= wait_rd_reply & ~ready;
            addr   <= 'h0;
            wdata  <= 'h0;
            wr_rd  <= 0;
            req_d1 <= 0;
        end
    end


    always_ff @(posedge clk)
    begin
        if (rst) begin
            wait_rd_reply <= 0;
        end else begin
            if (wait_rd_reply) begin
                wait_rd_reply <= ~ready;
                if (ready) begin
                    $display("%t CDP: APB read reply %h", $time, rdata);
                    ctrl_rdata <= rdata; // TODO fast-slow clock sync?
                    //cdpacc_ack <= 4'b0000;
                end else begin
                    $display("%t CDP: waiting for APB ready HIGH", $time);
                end
            end else begin
                wait_rd_reply <= sel & ~wr_rd;
                if (sel & ~wr_rd)
                    $display("%t CDP: Enter wait-rd-reply state", $time);
            end
        end
    end

endmodule: ApbMaster
