`timescale 1ps/1ps
`include "define.v"
`include "../IP/data_bank_sram.xcix"
`include "../IP/tag_icache_sram.xcix"

module ICache #(
    parameter SRAMEWIDE     = 32 ,
    parameter ICACHEWIDE    = 256,
    parameter ICACHEDEEP    = 32 ,
    parameter TAGWIDE       = 19
)(
    input        wire                                     Clk           ,
    input        wire                                     Rest          ,

    //from FTQ
    input        wire                                     InstFetch     , //in from FTQ the time must be unbusy
    input        wire      [`InstAddrBus]                 VritualAddr   ,
    //from TLB
    input        wire                                     CocapAble     ,
    input        wire      [1:0]                          CocapMode     ,
    input        wire                                     TlbAddrTrans  ,
    input        wire      [`InstAddrBus]                 PhysicalAddr  ,
    //from CtrlBlock
    input        wire                                     CacheStateFluah,
    //to FTQ
    input        wire                                     ICacheBusy    ,
    //to PreCheck
    output       wire                                     InstReady     ,
    output       wire      [(SRAMEWIDE*4)-1:0]            InstDateIc    ,
    //for AXIBridge
    input        wire                                     MemoryAble    ,
    input        wire                                     MemoryBrustAble,
    input        wire      [`InstDateBus]                 MemoryDate    ,
    //input        wire      
    
);

    //State One Read 
    wire [5:0] ReadAddr = VritualAddr[11:6] ;
    wire [`InstDateBus] Way0Part1 ;
    wire [`InstDateBus] Way0Part2 ;
    wire [`InstDateBus] Way0Part3 ; 
    wire [`InstDateBus] Way0Part4 ;
    wire [`InstDateBus] Way0Part5 ;
    wire [`InstDateBus] Way0Part6 ;
    wire [`InstDateBus] Way0Part7 ;
    wire [`InstDateBus] Way0Part8 ;
    wire [`InstDateBus] Way1Part1 ;
    wire [`InstDateBus] Way1Part2 ;
    wire [`InstDateBus] Way1Part3 ; 
    wire [`InstDateBus] Way1Part4 ;
    wire [`InstDateBus] Way1Part5 ;
    wire [`InstDateBus] Way1Part6 ;
    wire [`InstDateBus] Way1Part7 ;
    wire [`InstDateBus] Way1Part8 ;
    wire [TAGWIDE-1:0]  Way0Tag   ;
    wire [TAGWIDE-1:0]  Way1Tag   ;
    
    data_bank_sram way0_31to0(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way0Part1       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way0_63to32(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way0Part2       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way0_95to64(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way0Part3       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way0_127to96(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way0Part4       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

        data_bank_sram way0_159to128(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way0Part5       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way0_191to160(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way0Part6       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way0_223to192(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way0Part7       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way0_255to224(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way0Part8       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way1_31to0(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way1Part1       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way1_63to32(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way1Part2       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way1_95to64(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way1Part3       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way1_127to96(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way1Part4       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way1_159to128(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way1Part5       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way1_191to160(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way1Part6       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way1_223to192(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way1Part7       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    data_bank_sram way1_255to224(
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way1Part8       )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    tag_icache_sram way0tag (
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way0Tag         )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    tag_icache_sram way1tag (
        .addra      (ReadAddr        )  ,
        .clka       (Clk             )  ,
        .dina       (way0_bank0_dina )  ,
        .douta      (Way1Tag         )  ,
        .ena        (way0_bank0_ena  )  ,
        .wea        (way0_bank0_wea  )  
    );

    Cache_counter#(
        .COUNTERWIDE ( 2 ),
        .COUNTERPW   ( 5 ),
        .COUNTERDEEP ( ICACHEDEEP )
    )Way0_Cache_counter(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .RABLE       ( `AbleValue  ),
        .WABLE       ( WABLE       ),
        .RADDR       ( ReadAddr    ),
        .WADDR       ( WADDR       ),
        .CLEAN       ( CLEAN       ),
        .RDATE       ( RDATE       )
    );

    Cache_counter#(
        .COUNTERWIDE ( 2 ),
        .COUNTERPW   ( 5 ),
        .COUNTERDEEP ( ICACHEDEEP )
    )Way1_Cache_counter(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .RABLE       ( RABLE       ),
        .WABLE       ( WABLE       ),
        .RADDR       ( RADDR       ),
        .WADDR       ( WADDR       ),
        .CLEAN       ( CLEAN       ),
        .RDATE       ( RDATE       )
    );


    //atate two sent date to precheck or access memory
    wire              HitWay0 ;
    wire              HitWay1 ;
    assign  HitWay0 = (Way0Tag== PhysicalAddr[SRAMEWIDE-1:12]) ;
    assign  HitWay1 = (Way1Tag== PhysicalAddr[SRAMEWIDE-1:12]) ;

    wire                         HitSentPreC     = HitWay0 | HitWay1 ;
    wire  [(SRAMEWIDE*4)-1:0]    HitSentPrecDate = HitWay0 ? {} ;



endmodule