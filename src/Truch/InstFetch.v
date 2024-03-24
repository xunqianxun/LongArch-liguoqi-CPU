`include "define.v"
module InstFetch (
    input     wire                         Clk       ,
    input     wire                         Rest      ,
    //input     wire     [`TwoInstDateBus]   Inst      ,
    input     wire                         ctrl_if   ,
    output    wire     [`InstAddrBus]      inst_addr ,
    
);

reg   [`InstAddrBus]   pc;

always @(posedge Clk) begin
    if (Rest) begin
        pc <= `StartAddr ;
    end
    else begin
        pc <= pc + 8    ;
    end 
end

    
endmodule