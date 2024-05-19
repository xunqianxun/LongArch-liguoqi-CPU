`timescale 1ps/1ps
`include "../define.v"
`include "../../Lib/STACK_dout.v"
`include "../../Lib/STACK_reload.v"

module Ras  (
    input    wire                               Clk           ,
    input    wire                               Rest          ,
    //stop
    input    wire                               RasStop       ,
    input    wire                               RasFLash      ,
    //from BTB
    input    wire                               BtbAble       ,
    input    wire        [2:0]                  BtbPredictType,
    input    wire        [`InstAddrBus]         BtbPcDate     ,
    input    wire        [4:0]                  BtbPcOffset   ,
    //speculate update with predecode
    input    wire                               UpAble        ,
    input    wire        [1:0]                  UpPtrType     ,
    input    wire        [`InstAddrBus]         UpAddrDate    ,
    //speculate ex to predecode
    output   wire                               ToPreAble     ,
    output   wire        [`InstAddrBus]         ToPreAddr     ,
    //Date update with retire
    input    wire                               UpdateInAble  ,
    input    wire                               UpdateReload  ,
    input    wire        [`InstAddrBus]         UpdateInDate  ,
    input    wire                               UpdateCall    ,
    input    wire                               UpdateReturn   
);

    wire ReadAble  = (BtbPredictType == `TypeRTURN) ;
    wire WriteAble = (BtbPredictType == `TypeCALL)  ;

    wire UpInAble  = (UpPtrType == 2'b10) & UpAble ;
    wire UpOutAble = (UpPtrType == 2'b01) & UpAble ;

    wire [`InstAddrBus] UpInDate  = UpAddrDate & {32{UpAble}} ;

    wire [`InstAddrBus] CallAddr  = (BtbPcDate + BtbPcOffset + 4) & {32{BtbAble}} ;
    wire [`InstAddrBus] ReturnAddr ;

    reg                 RegToPreAble ;
    reg  [`InstAddrBus] RegToPreAddr ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegToPreAble <= `EnableValue ;
            RegToPreAddr <= `ZeorDate    ;
        end
        else if(RasStop) begin
            RegToPreAble <= RegToPreAble ;
            RegToPreAddr <= RegToPreAddr ;
        end
        else if(RasFLash) begin
            RegToPreAble <= `EnableValue ;
            RegToPreAddr <= `ZeorDate    ;
        end
        else begin
            RegToPreAble <= BtbAble ;
            RegToPreAddr <= ReturnAddr ;
        end
    end

    assign ToPreAble = RegToPreAble ;
    assign ToPreAddr = RegToPreAddr ; 


    wire  [3:0]      ReloadPtr   ;
    wire  [32+7-1:0] ReloadDate1 ;
    wire  [32+7-1:0] ReloadDate2 ;
    wire  [32+7-1:0] ReloadDate3 ;
    wire  [32+7-1:0] ReloadDate4 ;
    wire  [32+7-1:0] ReloadDate5 ;
    wire  [32+7-1:0] ReloadDate6 ;
    wire  [32+7-1:0] ReloadDate7 ;
    wire  [32+7-1:0] ReloadDate8 ;
    wire  [32+7-1:0] ReloadDate9 ;
    wire  [32+7-1:0] ReloadDate10;
    wire  [32+7-1:0] ReloadDate11; 
    wire  [32+7-1:0] ReloadDate12;
    wire  [32+7-1:0] ReloadDate13;
    wire  [32+7-1:0] ReloadDate14;
    wire  [32+7-1:0] ReloadDate15;

    STACK_dout#(
        .STACKDEEP      ( 16 ),
        .STACKPTRW      ( 4 ),
        .STACKWIDE      ( 32 ),
        .RECURCOUNT     ( 7 )
    )u_STACK_dout(
        .Clk            ( Clk            ),
        .Rest           ( Rest           ),
        .RABLE          ( UpdateReturn   ),
        .WABLE          ( UpdateCall     ),
        .DIN            ( UpdateInDate   ),
        .REDIRCT        ( UpdateReload   ),
        .OUTDATEPTR     ( ReloadPtr      ),
        .OUTDATELINE1   ( ReloadDate1    ),
        .OUTDATELINE2   ( ReloadDate2    ),
        .OUTDATELINE3   ( ReloadDate3    ),
        .OUTDATELINE4   ( ReloadDate4    ),
        .OUTDATELINE5   ( ReloadDate5    ),
        .OUTDATELINE6   ( ReloadDate6    ),
        .OUTDATELINE7   ( ReloadDate7    ),
        .OUTDATELINE8   ( ReloadDate8    ),
        .OUTDATELINE9   ( ReloadDate9    ),
        .OUTDATELINE10  ( ReloadDate10   ),
        .OUTDATELINE11  ( ReloadDate11   ),
        .OUTDATELINE12  ( ReloadDate12   ),
        .OUTDATELINE13  ( ReloadDate13   ),
        .OUTDATELINE14  ( ReloadDate14   ),
        .OUTDATELINE15  ( ReloadDate15   )
    );

    STACK_reload#(
        .STACKDEEP     ( 16 ),
        .STACKPTRW     ( 4 ),
        .STACKWIDE     ( 32 ),
        .RECURCOUNT    ( 7 )
    )u_STACK_reload(
        .Clk           ( Clk           ),
        .Rest          ( Rest          ),
        .RABLE         ( ReadAble  |UpOutAble),
        .DOUT          ( ReturnAddr    ),
        .WABLE         ( WriteAble | UpInAble),
        .DIN           ( CallAddr  | UpInDate),
        .RELOAD        ( UpdateReload  ),
        .RELOADPTR     ( ReloadPtr     ),
        .RELOADLINE1   ( ReloadDate1   ),
        .RELOADLINE2   ( ReloadDate2   ),
        .RELOADLINE3   ( ReloadDate3   ),
        .RELOADLINE4   ( ReloadDate4   ),
        .RELOADLINE5   ( ReloadDate5   ),
        .RELOADLINE6   ( ReloadDate6   ),
        .RELOADLINE7   ( ReloadDate7   ),
        .RELOADLINE8   ( ReloadDate8   ),
        .RELOADLINE9   ( ReloadDate9   ),
        .RELOADLINE10  ( ReloadDate10  ),
        .RELOADLINE11  ( ReloadDate11  ),
        .RELOADLINE12  ( ReloadDate12  ),
        .RELOADLINE13  ( ReloadDate13  ),
        .RELOADLINE14  ( ReloadDate14  ),
        .RELOADLINE15  ( ReloadDate15  )
    );



    
endmodule
