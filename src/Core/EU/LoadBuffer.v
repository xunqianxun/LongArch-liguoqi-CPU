`timescale 1ps/1ps
`include "../define.v"

module LoadBuffer (
    input         wire                                 Clk              ,
    input         wire                                 Rest             ,

    input         wire                                 LbStop           ,
    input         wire                                 LbFlash          ,

    input         wire                                 InLBAble         ,
    input         wire      [`MicOperateCode]          InLBMicOp        ,
    input         wire      [1:0]                      InLBMAT          ,   
    input         wire      [`InstAddrBus]             InLBPAddr        ,
    input         wire                                 InLBTrap         ,
    input         wire      [6:0]                      InLBTrapCode     ,
    input         wire                                 InLBWbAble       ,
    input         wire      [`ReNameRegBUs]            InLBWbAddr       ,
    input         wire      [5:0]                      InLBRobPtr       ,
    //to phy 
    output        wire                                 LoadWPhyAble     ,
    output        wire      [`ReNameRegBUs]            LoadWPhyAddr     ,
    output        wire      [`DataBus]                 LoadWPhyDate     ,
    //to Rob
    output        wire                                 CommitLAble      ,
    output        wire      [5:0]                      CommitLRobPtr    ,
    output        wire                                 CommitLTrap      ,
    output        wire      [6:0]                      CommitLTrapCode  ,
    output        wire      [2:0]                      CommitLBPtr      ,
    //from Rob
    input         wire                                 RetirLAble       ,
    input         wire      [2:0]                      ReTirLPtr        ,
    //to Dcache
    output        wire                                 LbToDcdAble      ,
    output        wire     [1:0]                       LbToDcdAMat      ,
    output        wire     [2:0]                       LbToDcdAPtr      ,
    input         wire                                 DcdToLbSuccess   ,
    output        wire     [`InstAddrBus]              LbToDcdAPhyAddr  ,
    input         wire                                 DcdTOLbBackAble  ,
    input         wire     [2:0]
); 
    localparam WRITE   = 3'd1 ;
    localparam LOADING = 3'd2 ;
    localparam WEITCOM = 3'd3 ;

    reg    [70:0]  LOADBUFFER [1:7] ;

    wire [2:0]  IndexLB = LOADBUFFER[1][70] ? 3'b1 :
                          LOADBUFFER[2][70] ? 3'b2 : 
                          LOADBUFFER[3][70] ? 3'b3 : 
                          LOADBUFFER[4][70] ? 3'b4 : 
                          LOADBUFFER[5][70] ? 3'b5 : 
                          LOADBUFFER[6][70] ? 3'b6 : 
                          LOADBUFFER[7][70] ? 3'b7 : 3'b0 ;

    always @(posedge Clk) begin
        if(!Rest) begin
            LOADBUFFER[1] <= 71'd0 ;
            LOADBUFFER[2] <= 71'd0 ;
            LOADBUFFER[3] <= 71'd0 ;
            LOADBUFFER[4] <= 71'd0 ;
            LOADBUFFER[5] <= 71'd0 ;
            LOADBUFFER[6] <= 71'd0 ;
            LOADBUFFER[7] <= 71'd0 ;
        end
        else if(LbStop) begin
            LOADBUFFER[1] <= LOADBUFFER[1] ;
            LOADBUFFER[2] <= LOADBUFFER[2] ;
            LOADBUFFER[3] <= LOADBUFFER[3] ;
            LOADBUFFER[4] <= LOADBUFFER[4] ;
            LOADBUFFER[5] <= LOADBUFFER[5] ;
            LOADBUFFER[6] <= LOADBUFFER[6] ;
            LOADBUFFER[7] <= LOADBUFFER[7] ;
        end
        else if(LbFlash) begin
            LOADBUFFER[1] <= 71'd0 ;
            LOADBUFFER[2] <= 71'd0 ;
            LOADBUFFER[3] <= 71'd0 ;
            LOADBUFFER[4] <= 71'd0 ;
            LOADBUFFER[5] <= 71'd0 ;
            LOADBUFFER[6] <= 71'd0 ;
            LOADBUFFER[7] <= 71'd0 ;
        end
        else begin
            if(InLBAble)
                LOADBUFFER[IndexLB] <= {`AbleValue,WRITE,InLBMicOp,InLBMAT,InLBPAddr,InLBTrap,InLBTrapCode,InLBWbAble,InLBWbAddr,InLBRobPtr} ;
            
        end
    end
    
endmodule