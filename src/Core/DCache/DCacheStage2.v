`timescale 1ps/1ps
`include "../define.v"

module DCacheStage2 (
    input       wire                                 Clk          ,
    input       wire                                 Rest         ,
    //for write buffer
    input       wire                                 WriteBuffAble,
    input       wire     [`InstAddrBus]              WriteBuffAddr,
    input       wire     [255:0]                     WriteBackDate,
    input       wire     [7:0]                       WriteBackCnt ,
    input       wire     [2:0]                       WriteBuffPtr ,
    //for MSHR
    input       wire                                 MSHRAble     ,
    input       wire     [`InstAddrBus]              MSHRAddr     ,
    input       wire                                 MSHRLoad     ,
    input       wire                                 MSHRStore    ,
    input       wire     [`DataBus]                  MSHRStoreTemp,
    input       wire     [3:0]                       MSHRWay      ,
    input       wire     [2:0]                       MSHRPtr      ,  
    output      wire                                 MSHRUpAble   ,
    output      wire     [255:0]                     MSHRUpDate   ,
    output      wire     [`InstAddrBus]              MSHRUpAddr   ,
    output      wire     [3:0]                       MSHRUpWay    ,
    output      wire                                 In2HitAble   ,
    output      wire     [6:0]                       In2HitIndex  ,
    output      wire                                 In2HitWay1   ,
    output      wire                                 In2HitWay2   ,
    output      wire                                 In2HitWay3   ,
    output      wire                                 In2HitWay4   ,
    output      wire                                 Writ2DirtAble,
    output      wire     [6:0]                       Writ2HitIndex,
    output      wire                                 Writ2Way1Hit ,
    output      wire                                 Writ2Way2Hit ,
    output      wire                                 Writ2Way3Hit ,
    output      wire                                 Writ2Way4Hit ,
    //for AXI 
    output      wire                                 DcaWriteAble ,
    inout       wire                                 DWshankhand  , //与uncache 共用
    output      wire                                 DWriteUncache,
    output      wire     [3:0]                       UncacheStrb  , //uncache 时只可能是len为1的时候
    output      wire     [`InstAddrBus]              DcaWriteAddr ,
    output      wire     [255:0]                     DcaWDate     ,
    output      wire                                 DcaReadAble  ,
    input       wire                                 DRshankhand  ,
    output      wire                                 DUnacheRead  ,
    output      wire     [`InstAddrBus]              DcaReadAddr  ,
    //to lsu 
    output      wire                                 LoadBack     ,
    output      wire     [2:0]                       LoadBackPtr  ,
    output      wire     [`DataBus]                  LoadBackDate ,
    output      wire                                 StoreBack    ,
    output      wire     [2:0]                       StoreBackPtr
);

    reg [331:31] RegWriteBuffer [1:8] ;

    reg [2:0]   WritePtr ;
    reg [2:0]   ReadPtr  ;

    localparam WEITEWRITE = 3'b000 ;

    wire [3:0]  SamePtr = {4{(WriteBuffAddr == RegWriteBuffer[8][327:296]) && (RegWriteBuffer[8][332:328] == WEITEWRITE)}} & 4'd8 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[7][327:296]) && (RegWriteBuffer[7][332:328] == WEITEWRITE)}} & 4'd7 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[6][327:296]) && (RegWriteBuffer[6][332:328] == WEITEWRITE)}} & 4'd6 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[5][327:296]) && (RegWriteBuffer[5][332:328] == WEITEWRITE)}} & 4'd5 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[4][327:296]) && (RegWriteBuffer[4][332:328] == WEITEWRITE)}} & 4'd4 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[3][327:296]) && (RegWriteBuffer[3][332:328] == WEITEWRITE)}} & 4'd3 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[2][327:296]) && (RegWriteBuffer[2][332:328] == WEITEWRITE)}} & 4'd2 | 
                          {4{(WriteBuffAddr == RegWriteBuffer[1][327:296]) && (RegWriteBuffer[1][332:328] == WEITEWRITE)}} & 4'd1 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            WritePtr          <= 3'd0   ;
            RegWriteBuffer[1] <= 300'd0 ;
            RegWriteBuffer[2] <= 300'd0 ;
            RegWriteBuffer[3] <= 300'd0 ;
            RegWriteBuffer[4] <= 300'd0 ;
            RegWriteBuffer[5] <= 300'd0 ;
            RegWriteBuffer[6] <= 300'd0 ;
            RegWriteBuffer[7] <= 300'd0 ;
            RegWriteBuffer[8] <= 300'd0 ;
        end
        else if(WriteBuffAble) begin
            if(SamePtr != 4'b0000) begin
                WritePtr <= WritePtr ;
                RegWriteBuffer[SamePtr] <= {RegWriteBuffer[SamePtr][331:296], (((RegWriteBuffer[SamePtr][295:40] & (~WriteBackCnt)) | (WriteBackDate & WriteBackCnt))),(RegWriteBuffer[SamePtr][39:32] | WriteBackCnt)} ;
                
            end
            
        end
    end
    
endmodule
