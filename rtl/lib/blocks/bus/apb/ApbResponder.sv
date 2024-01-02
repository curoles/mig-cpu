/* APB slave/responder.
 *
 * Authors: Igor Lesik 2020
 *
 *
 */
module ApbResponder #(
    parameter ADDR_WIDTH  = 5,
    parameter WDATA_WIDTH = 32,
    parameter RDATA_WIDTH = 32
)(
    input wire                 clk, // rising edge of `clk` times all transfers on the APB
    input wire                 rst_n,

    // Signals from APB Master and APB bus
    input wire [ADDR_WIDTH-1:0]  addr,
    input wire                   sel,     // slave is selected and data transfer is required
    input wire                   enable,  // indicates the second+ cycles of an APB transfer
    input wire                   wr_rd,   // direction=HIGH? wr:rd
    input wire [WDATA_WIDTH-1:0] wdata,   // driven by Bridge when wr_rd=HIGH
    input wire [3:0]             wstrobe, // which byte lanes to update during a write transfer wdata[(8n + 7):(8n)]

    // Signals driven by current Slave
    output reg                    ready, // slave uses this signal to extend an APB transfer, when ready is LOW the transfer extended
    output reg  [RDATA_WIDTH-1:0] rdata,
    // not implemented slave_err

    output reg                    observer_req,
    output reg                    observer_wr_rd, // to observer: write/read request
    output reg  [ADDR_WIDTH-1:0]  observer_addr,  // to observer: address
    output reg  [WDATA_WIDTH-1:0] observer_wdata, // to observer: write data
    input  wire [RDATA_WIDTH-1:0] observer_rdata,
    input  wire                   observer_rd_ready
);

    reg [1:0] state;
    localparam [1:0] IDLE=0, WRITE=1, READ=2, READ_READY=3;

    always_ff @(posedge clk)
    begin
        if (!rst_n) begin
            state <= IDLE;
            observer_req <= 0;
            ready <= 1;
        end else begin
            case (state)
                IDLE: begin
                    //if (sel) $display("%t ApbResponder selected", $time);
                    state <= sel? (wr_rd? WRITE:READ) : IDLE;
                    observer_req   <= sel;
                    observer_wr_rd <= wr_rd;
                    observer_addr  <= addr;
                    observer_wdata <= wdata;
                    rdata <= 32'h0000_0000; //FIXME
                    ready <= ~sel | (sel & wr_rd) ;
                end
                WRITE: begin
                    if (sel && wr_rd) begin // sel and other inputs MUST be stable at least 2 cycles
                        observer_req   <= 0;
                        observer_wr_rd <= 1;
                        observer_addr  <= addr;
                        observer_wdata <= wdata;
                        ready <= 1;
                        //$display("%t ApbResponder write[%h]=%h", $time, addr, wdata);
                    end
                    state <= IDLE;
                end
                READ: begin
                    //if (sel && !wr_rd) begin // sel and other inputs MUST be stable at least 2 cycles
                    observer_req   <= 0;
                    observer_wr_rd <= 0;
                    observer_addr  <= addr;
                    rdata <= observer_rdata;
                    ready <= observer_rd_ready;
                    if (observer_rd_ready) begin
                        state <= READ_READY;
                        $display("%t ApbResponder: read[%h]=%h", $time, addr, observer_rdata);
                    end else begin
                        state <= READ;
                    end
                    //end
                end
                READ_READY: begin
                    state <= IDLE;
                    ready <= 1;
                    observer_req <= 0;
                end
                default: begin
                    state <= IDLE;
                    observer_req <= 0;
                    ready <= 1;
                end
            endcase
        end
    end

endmodule: ApbResponder
