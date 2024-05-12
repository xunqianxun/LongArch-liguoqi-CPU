`timescale 1ps/1ps
`include "../define.v"

module RenameArchTable (
    input        wire                                      Clk              ,
    input        wire                                      Rest             ,
    //for Ctrl
    input        wire                                      RATStop          ,
    input        wire                                      RATFlash         ,
    //output       wire                                      RATReq           ,
    //from freelist
    input        wire                                      Way1RdAble       ,
    input        wire        [`ArchRegBUs]                 Way1ArchAddr     ,
    input        wire        [`ReNameRegBUs]               Way1RdAddr       ,
    input        wire                                      Way2RdAble       ,
    input        wire        [`ArchRegBUs]                 Way2ArchAddr     ,
    input        wire        [`ReNameRegBUs]               Way2RdAddr       ,
    input        wire                                      Way3RdAble       ,
    input        wire        [`ArchRegBUs]                 Way3ArchAddr     ,
    input        wire        [`ReNameRegBUs]               Way3RdAddr       ,
    input        wire                                      Way4RdAble       ,
    input        wire        [`ArchRegBUs]                 Way4ArchAddr     ,
    input        wire        [`ReNameRegBUs]               Way4RdAddr       ,
    //from decode
    input        wire                                      Way1Src1Able     ,
    input        wire        [`ArchRegBUs]                 Way1Src1Addr     ,
    input        wire                                      Way1Src2Able     ,
    input        wire        [`ArchRegBUs]                 Way1Src2Addr     ,
    input        wire                                      Way2Src1Able     ,
    input        wire        [`ArchRegBUs]                 Way2Src1Addr     ,
    input        wire                                      Way2Src2Able     ,
    input        wire        [`ArchRegBUs]                 Way2Src2Addr     ,
    input        wire                                      Way3Src1Able     ,
    input        wire        [`ArchRegBUs]                 Way3Src1Addr     ,
    input        wire                                      Way3Src2Able     ,
    input        wire        [`ArchRegBUs]                 Way3Src2Addr     ,
    input        wire                                      Way4Src1Able     ,
    input        wire        [`ArchRegBUs]                 Way4Src1Addr     ,
    input        wire                                      Way4Src2Able     ,
    input        wire        [`ArchRegBUs]                 Way4Src2Addr     ,
    //to busytable
    //******************************************************************************//
    // rename stage need 1 cycle ,instraction other information should delay 1 cycle//
    //******************************************************************************// 
    output       wire                                      Out1Src1Able     , 
    output       wire                                      Out1Src1NoDate   , //虽然对于指令一来说这个信号没有用，但是我有强迫症。要保持平均。读者可删
    output       wire        [`ReNameRegBUs]               Out1Src1Addr     ,
    output       wire                                      Out1Src2Able     ,
    output       wire                                      Out1Src2NoDate   ,// and
    output       wire        [`ReNameRegBUs]               Out1Src2Addr     ,
    output       wire                                      Out1RdAble       ,
    output       wire        [`ReNameRegBUs]               Out1RdAddr       ,
    output       wire                                      Out2Src1Able     ,
    output       wire                                      Out2Src1NoDate   ,
    output       wire        [`ReNameRegBUs]               Out2Src1Addr     ,
    output       wire                                      Out2Src2Able     ,
    output       wire                                      Out2Src2NoDate   ,
    output       wire        [`ReNameRegBUs]               Out2Src2Addr     ,
    output       wire                                      Out2RdAble       ,
    output       wire        [`ReNameRegBUs]               Out2RdAddr       ,
    output       wire                                      Out3Src1Able     ,
    output       wire                                      Out3Src1NoDate   ,
    output       wire        [`ReNameRegBUs]               Out3Src1Addr     ,
    output       wire                                      Out3Src2Able     ,
    output       wire                                      Out3Src2NoDate   ,
    output       wire        [`ReNameRegBUs]               Out3Src2Addr     ,
    output       wire                                      Out3RdAble       ,
    output       wire        [`ReNameRegBUs]               Out3RdAddr       ,
    output       wire                                      Out4Src1Able     ,
    output       wire                                      Out4Src1NoDate   ,
    output       wire        [`ReNameRegBUs]               Out4Src1Addr     ,
    output       wire                                      Out4Src2Able     ,
    output       wire                                      Out4Src2NoDate   ,
    output       wire        [`ReNameRegBUs]               Out4Src2Addr     ,
    output       wire                                      Out4RdAble       ,
    output       wire        [`ReNameRegBUs]               Out4RdAddr       ,
    //to Reftable
    output       wire                                      Lock1Able        ,
    output       wire        [`ReNameRegBUs]               Lock1Addr        ,
    output       wire                                      Lock2Able        ,
    output       wire        [`ReNameRegBUs]               Lock2Addr        ,
    output       wire                                      Lock3Able        ,
    output       wire        [`ReNameRegBUs]               Lock3Addr        ,
    output       wire                                      Lock4Able        ,
    output       wire        [`ReNameRegBUs]               Lock4Addr        ,
    output       wire                                      Use1Able         ,
    output       wire        [`ReNameRegBUs]               Use1Addr         ,
    output       wire                                      Use2Able         ,
    output       wire        [`ReNameRegBUs]               Use2Addr         ,      
    output       wire                                      Use3Able         ,
    output       wire        [`ReNameRegBUs]               Use3Addr         ,
    output       wire                                      Use4Able         ,
    output       wire        [`ReNameRegBUs]               Use4Addr         ,  
    output       wire                                      Use5Able         ,
    output       wire        [`ReNameRegBUs]               Use5Addr         ,
    output       wire                                      Use6Able         ,
    output       wire        [`ReNameRegBUs]               Use6Addr         ,      
    output       wire                                      Use7Able         ,
    output       wire        [`ReNameRegBUs]               Use7Addr         ,
    output       wire                                      Use8Able         ,
    output       wire        [`ReNameRegBUs]               Use8Addr         ,  
    output       wire                                      Use9Able         ,
    output       wire        [`ReNameRegBUs]               Use9Addr         ,
    output       wire                                      Use10Able        ,
    output       wire        [`ReNameRegBUs]               Use10Addr        ,  
    output       wire                                      Use11Able        ,
    output       wire        [`ReNameRegBUs]               Use11Addr        ,
    output       wire                                      Use12Able        ,
    output       wire        [`ReNameRegBUs]               Use12Addr          

);

    reg   [6:0] RENAMETABLE [0:31] ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RENAMETABLE[0] <= 7'd0 ;
            RENAMETABLE[1] <= 7'd1 ;
            RENAMETABLE[2] <= 7'd2 ;
            RENAMETABLE[3] <= 7'd3 ;
            RENAMETABLE[4] <= 7'd4 ;
            RENAMETABLE[5] <= 7'd5 ;
            RENAMETABLE[6] <= 7'd6 ;
            RENAMETABLE[7] <= 7'd7 ;
            RENAMETABLE[8] <= 7'd8 ;
            RENAMETABLE[9] <= 7'd9 ;
            RENAMETABLE[10] <= 7'd10 ;
            RENAMETABLE[11] <= 7'd11 ;
            RENAMETABLE[12] <= 7'd12 ;
            RENAMETABLE[13] <= 7'd13 ;
            RENAMETABLE[14] <= 7'd14 ;
            RENAMETABLE[15] <= 7'd15 ;
            RENAMETABLE[16] <= 7'd16 ;
            RENAMETABLE[17] <= 7'd17 ;
            RENAMETABLE[18] <= 7'd18 ;
            RENAMETABLE[19] <= 7'd19 ;
            RENAMETABLE[20] <= 7'd20 ;
            RENAMETABLE[21] <= 7'd21 ;
            RENAMETABLE[22] <= 7'd22 ;
            RENAMETABLE[23] <= 7'd23 ;
            RENAMETABLE[24] <= 7'd24 ;
            RENAMETABLE[25] <= 7'd25 ;
            RENAMETABLE[26] <= 7'd26 ;
            RENAMETABLE[27] <= 7'd27 ;
            RENAMETABLE[28] <= 7'd28 ;
            RENAMETABLE[29] <= 7'd29 ;
            RENAMETABLE[30] <= 7'd30 ;
            RENAMETABLE[31] <= 7'd31 ;
        end 
        else if(RATFlash) begin
            RENAMETABLE[0] <= 7'd0 ;
            RENAMETABLE[1] <= 7'd1 ;
            RENAMETABLE[2] <= 7'd2 ;
            RENAMETABLE[3] <= 7'd3 ;
            RENAMETABLE[4] <= 7'd4 ;
            RENAMETABLE[5] <= 7'd5 ;
            RENAMETABLE[6] <= 7'd6 ;
            RENAMETABLE[7] <= 7'd7 ;
            RENAMETABLE[8] <= 7'd8 ;
            RENAMETABLE[9] <= 7'd9 ;
            RENAMETABLE[10] <= 7'd10 ;
            RENAMETABLE[11] <= 7'd11 ;
            RENAMETABLE[12] <= 7'd12 ;
            RENAMETABLE[13] <= 7'd13 ;
            RENAMETABLE[14] <= 7'd14 ;
            RENAMETABLE[15] <= 7'd15 ;
            RENAMETABLE[16] <= 7'd16 ;
            RENAMETABLE[17] <= 7'd17 ;
            RENAMETABLE[18] <= 7'd18 ;
            RENAMETABLE[19] <= 7'd19 ;
            RENAMETABLE[20] <= 7'd20 ;
            RENAMETABLE[21] <= 7'd21 ;
            RENAMETABLE[22] <= 7'd22 ;
            RENAMETABLE[23] <= 7'd23 ;
            RENAMETABLE[24] <= 7'd24 ;
            RENAMETABLE[25] <= 7'd25 ;
            RENAMETABLE[26] <= 7'd26 ;
            RENAMETABLE[27] <= 7'd27 ;
            RENAMETABLE[28] <= 7'd28 ;
            RENAMETABLE[29] <= 7'd29 ;
            RENAMETABLE[30] <= 7'd30 ;
            RENAMETABLE[31] <= 7'd31 ;
        end
        else begin
           RENAMETABLE[Way1ArchAddr] <= Way1Src1Able ? Way1RdAddr : RENAMETABLE[Way1ArchAddr] ;
           RENAMETABLE[Way1ArchAddr] <= Way2Src1Able ? Way2RdAddr : RENAMETABLE[Way1ArchAddr] ;
           RENAMETABLE[Way1ArchAddr] <= Way3Src1Able ? Way3RdAddr : RENAMETABLE[Way1ArchAddr] ;
           RENAMETABLE[Way1ArchAddr] <= Way4Src1Able ? Way4RdAddr : RENAMETABLE[Way1ArchAddr] ;
        end
    end

    reg                   RegLock1Able ;
    reg  [`ReNameRegBUs]  RegLock1Addr ;
    reg                   RegLock2Able ;
    reg  [`ReNameRegBUs]  RegLock2Addr ;
    reg                   RegLock3Able ;
    reg  [`ReNameRegBUs]  RegLock3Addr ;
    reg                   RegLock4Able ;
    reg  [`ReNameRegBUs]  RegLock4Addr ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegLock1Able <= `EnableValue ;
            RegLock1Addr <= 7'd0         ;
            RegLock2Able <= `EnableValue ;
            RegLock2Addr <= 7'd0         ;
            RegLock3Able <= `EnableValue ;
            RegLock3Addr <= 7'd0         ;
            RegLock4Able <= `EnableValue ;
            RegLock4Addr <= 7'd0         ;
        end
        else if(RATFlash) begin
            RegLock1Able <= `EnableValue ;
            RegLock1Addr <= 7'd0         ;
            RegLock2Able <= `EnableValue ;
            RegLock2Addr <= 7'd0         ;
            RegLock3Able <= `EnableValue ;
            RegLock3Addr <= 7'd0         ;
            RegLock4Able <= `EnableValue ;
            RegLock4Addr <= 7'd0         ;
        end
        else if(RATStop) begin
            RegLock1Able <= RegLock1Able ;
            RegLock1Addr <= RegLock1Addr ;
            RegLock2Able <= RegLock2Able ;
            RegLock2Addr <= RegLock2Addr ;
            RegLock3Able <= RegLock3Able ;
            RegLock3Addr <= RegLock3Addr ;
            RegLock4Able <= RegLock4Able ;
            RegLock4Addr <= RegLock4Addr ;
        end
        else begin
            RegLock1Able <= ~RATStop ? Way1RdAble : `EnableValue         ;
            RegLock1Addr <= ~RATStop ? RENAMETABLE[Way1ArchAddr] : 7'd0  ;
            RegLock2Able <= ~RATStop ? Way2RdAble : `EnableValue         ;
            RegLock2Addr <= ~RATStop ? RENAMETABLE[Way2ArchAddr] : 7'd0  ;
            RegLock3Able <= ~RATStop ? Way3RdAble : `EnableValue         ;
            RegLock3Addr <= ~RATStop ? RENAMETABLE[Way3ArchAddr] : 7'd0  ;
            RegLock4Able <= ~RATStop ? Way4RdAble : `EnableValue         ;
            RegLock4Addr <= ~RATStop ? RENAMETABLE[Way4ArchAddr] : 7'd0  ;
        end
    end

    assign Lock1Able = RegLock1Able ; 
    assign Lock1Addr = RegLock1Addr ;
    assign Lock2Able = RegLock2Able ; 
    assign Lock2Addr = RegLock2Addr ;
    assign Lock3Able = RegLock3Able ; 
    assign Lock3Addr = RegLock3Addr ;
    assign Lock4Able = RegLock4Able ; 
    assign Lock4Addr = RegLock4Addr ;

    reg                   RegOut1Src1Able   ;
    reg                   RegOut1Src1NoDate ;
    reg  [`ReNameRegBUs]  RegOut1Src1Addr   ;  
    reg                   RegOut1Src2Able   ;
    reg                   RegOut1Src2NoDate ;
    reg  [`ReNameRegBUs]  RegOut1Src2Addr   ; 
    reg                   RegOut1RdAble     ;
    reg  [`ReNameRegBUs]  RegOut1RdAddr     ;
    reg                   RegOut2Src1Able   ;
    reg                   RegOut2Src1NoDate ;
    reg  [`ReNameRegBUs]  RegOut2Src1Addr   ;  
    reg                   RegOut2Src2Able   ;
    reg                   RegOut2Src2NoDate ;
    reg  [`ReNameRegBUs]  RegOut2Src2Addr   ; 
    reg                   RegOut2RdAble     ;
    reg  [`ReNameRegBUs]  RegOut2RdAddr     ;
    reg                   RegOut3Src1Able   ;
    reg                   RegOut3Src1NoDate ;
    reg  [`ReNameRegBUs]  RegOut3Src1Addr   ;  
    reg                   RegOut3Src2Able   ;
    reg                   RegOut3Src2NoDate ;
    reg  [`ReNameRegBUs]  RegOut3Src2Addr   ; 
    reg                   RegOut3RdAble     ;
    reg  [`ReNameRegBUs]  RegOut3RdAddr     ;
    reg                   RegOut4Src1Able   ;
    reg                   RegOut4Src1NoDate ;
    reg  [`ReNameRegBUs]  RegOut4Src1Addr   ;  
    reg                   RegOut4Src2Able   ; 
    reg                   RegOut4Src2NoDate ;
    reg  [`ReNameRegBUs]  RegOut4Src2Addr   ; 
    reg                   RegOut4RdAble     ;
    reg  [`ReNameRegBUs]  RegOut4RdAddr     ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegOut1Src1Able   <= `EnableValue ;
            RegOut1Src1NoDate <= `EnableValue ;
            RegOut1Src1Addr   <= 7'd0         ;
            RegOut1Src2Able   <= `EnableValue ;
            RegOut1Src2NoDate <= `EnableValue ;
            RegOut1Src2Addr   <= 7'd0         ;
            RegOut1RdAble     <= `EnableValue ;
            RegOut1RdAddr     <= 7'd0         ;
            RegOut2Src1Able   <= `EnableValue ;
            RegOut2Src1NoDate <= `EnableValue ;
            RegOut2Src1Addr   <= 7'd0         ;
            RegOut2Src2Able   <= `EnableValue ;
            RegOut2Src2NoDate <= `EnableValue ;
            RegOut2Src2Addr   <= 7'd0         ;
            RegOut2RdAble     <= `EnableValue ;
            RegOut2RdAddr     <= 7'd0         ;
            RegOut3Src1Able   <= `EnableValue ;
            RegOut3Src1NoDate <= `EnableValue ;
            RegOut3Src1Addr   <= 7'd0         ;
            RegOut3Src2Able   <= `EnableValue ;
            RegOut3Src2NoDate <= `EnableValue ;
            RegOut3Src2Addr   <= 7'd0         ;
            RegOut3RdAble     <= `EnableValue ;
            RegOut3RdAddr     <= 7'd0         ;
            RegOut4Src1Able   <= `EnableValue ;
            RegOut4Src1NoDate <= `EnableValue ;
            RegOut4Src1Addr   <= 7'd0         ;
            RegOut4Src2Able   <= `EnableValue ;
            RegOut4Src2NoDate <= `EnableValue ;
            RegOut4Src2Addr   <= 7'd0         ;
            RegOut4RdAble     <= `EnableValue ;
            RegOut4RdAddr     <= 7'd0         ;
        end  
        else if(RATFlash) begin
            RegOut1Src1Able   <= `EnableValue ;
            RegOut1Src1NoDate <= `EnableValue ;
            RegOut1Src1Addr   <= 7'd0         ;
            RegOut1Src2Able   <= `EnableValue ;
            RegOut1Src2NoDate <= `EnableValue ;
            RegOut1Src2Addr   <= 7'd0         ;
            RegOut1RdAble     <= `EnableValue ;
            RegOut1RdAddr     <= 7'd0         ;
            RegOut2Src1Able   <= `EnableValue ;
            RegOut2Src1NoDate <= `EnableValue ;
            RegOut2Src1Addr   <= 7'd0         ;
            RegOut2Src2Able   <= `EnableValue ;
            RegOut2Src2NoDate <= `EnableValue ;
            RegOut2Src2Addr   <= 7'd0         ;
            RegOut2RdAble     <= `EnableValue ;
            RegOut2RdAddr     <= 7'd0         ;
            RegOut3Src1Able   <= `EnableValue ;
            RegOut3Src1NoDate <= `EnableValue ;
            RegOut3Src1Addr   <= 7'd0         ;
            RegOut3Src2Able   <= `EnableValue ;
            RegOut3Src2NoDate <= `EnableValue ;
            RegOut3Src2Addr   <= 7'd0         ;
            RegOut3RdAble     <= `EnableValue ;
            RegOut3RdAddr     <= 7'd0         ;
            RegOut4Src1Able   <= `EnableValue ;
            RegOut4Src1NoDate <= `EnableValue ;
            RegOut4Src1Addr   <= 7'd0         ;
            RegOut4Src2Able   <= `EnableValue ;
            RegOut4Src2NoDate <= `EnableValue ;
            RegOut4Src2Addr   <= 7'd0         ;
            RegOut4RdAble     <= `EnableValue ;
            RegOut4RdAddr     <= 7'd0         ;
        end
        else if(RATStop) begin
            RegOut1Src1Able   <= RegOut1Src1Able   ;
            RegOut1Src1NoDate <= RegOut1Src1NoDate ;
            RegOut1Src1Addr   <= RegOut1Src1Addr   ;
            RegOut1Src2Able   <= RegOut1Src2Able   ;
            RegOut1Src2NoDate <= RegOut1Src2NoDate ;
            RegOut1Src2Addr   <= RegOut1Src2Addr   ;
            RegOut1RdAble     <= RegOut1RdAble     ;
            RegOut1RdAddr     <= RegOut1RdAddr     ;
            RegOut2Src1Able   <= RegOut2Src1Able   ;
            RegOut2Src1NoDate <= RegOut2Src1NoDate ;
            RegOut2Src1Addr   <= RegOut2Src1Addr   ;
            RegOut2Src2Able   <= RegOut2Src2Able   ;
            RegOut2Src2NoDate <= RegOut2Src2NoDate ;
            RegOut2Src2Addr   <= RegOut2Src2Addr   ;
            RegOut2RdAble     <= RegOut2RdAble     ;
            RegOut2RdAddr     <= RegOut2RdAddr     ;
            RegOut3Src1Able   <= RegOut3Src1Able   ;
            RegOut3Src1NoDate <= RegOut3Src1NoDate ;
            RegOut3Src1Addr   <= RegOut3Src1Addr   ;
            RegOut3Src2Able   <= RegOut3Src2Able   ;
            RegOut3Src2NoDate <= RegOut3Src2NoDate ;
            RegOut3Src2Addr   <= RegOut3Src2Addr   ;
            RegOut3RdAble     <= RegOut3RdAble     ;
            RegOut3RdAddr     <= RegOut3RdAddr     ;
            RegOut4Src1Able   <= RegOut4Src1Able   ;
            RegOut4Src1NoDate <= RegOut4Src1NoDate ;
            RegOut4Src1Addr   <= RegOut4Src1Addr   ;
            RegOut4Src2Able   <= RegOut4Src2Able   ;
            RegOut4Src2NoDate <= RegOut4Src2NoDate ;
            RegOut4Src2Addr   <= RegOut4Src2Addr   ;
            RegOut4RdAble     <= RegOut4RdAble     ;
            RegOut4RdAddr     <= RegOut4RdAddr     ;
        end
        else begin
            RegOut1Src1Able                     <= (Way1Src1Able ) ;
            {RegOut1Src1NoDate,RegOut1Src1Addr} <= (Way1Src1Able ) ? {`EnableValue,RENAMETABLE[Way1Src1Addr]} : {`EnableValue,7'd0} ;
            RegOut1Src2Able                     <= (Way1Src2Able ) ;
            {RegOut1Src2NoDate,RegOut1Src2Addr} <= (Way1Src2Able ) ? {`EnableValue,RENAMETABLE[Way1Src2Addr]} : {`EnableValue,7'd0} ;
            RegOut1RdAble                       <= (Way1RdAble   ) ; 
            RegOut1RdAddr                       <= (Way1RdAble   ) ? Way1RdAddr : 7'd0                ;
            RegOut2Src1Able                     <= (Way2Src1Able ) ;
            {RegOut2Src1NoDate,RegOut2Src1Addr} <= (Way2Src1Able ) ? (((Way2Src1Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way2Src1Addr]}) : {`EnableValue,7'd0} ;
            RegOut2Src2Able                     <= (Way2Src2Able ) ;
            {RegOut2Src2NoDate,RegOut2Src2Addr} <= (Way2Src2Able ) ? (((Way2Src2Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way2Src2Addr]}) : {`EnableValue,7'd0} ;
            RegOut2RdAble                       <= (Way2RdAble   ) ; 
            RegOut2RdAddr                       <= (Way2RdAble   ) ? Way2RdAddr : 7'd0                ;
            RegOut3Src1Able                     <= (Way3Src1Able ) ;
            {RegOut3Src1NoDate,RegOut3Src1Addr} <= (Way3Src1Able ) ? (((Way3Src1Addr == Way2ArchAddr) & Way2RdAble) ? {`AbleValue,Way2RdAddr} :
                                                                      ((Way3Src1Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way3Src1Addr]}) : {`EnableValue,7'd0} ;
            RegOut3Src2Able                     <= (Way3Src2Able ) ;
            {RegOut3Src2NoDate,RegOut3Src2Addr} <= (Way3Src2Able ) ? (((Way3Src2Addr == Way2ArchAddr) & Way2RdAble) ? {`AbleValue,Way2RdAddr} :
                                                                      ((Way3Src2Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way3Src2Addr]}) : {`EnableValue,7'd0} ;
            RegOut3RdAble                       <= (Way3RdAble   ) ; 
            RegOut3RdAddr                       <= (Way3RdAble   ) ? Way3RdAddr : 7'd0                ;
            RegOut4Src1Able                     <= (Way4Src1Able ) ;
            {RegOut4Src1NoDate,RegOut4Src1Addr} <= (Way4Src1Able ) ? (((Way3Src1Addr == Way3ArchAddr) & Way3RdAble) ? {`AbleValue,Way3RdAddr} :
                                                                      ((Way3Src1Addr == Way2ArchAddr) & Way2RdAble) ? {`AbleValue,Way2RdAddr} :
                                                                      ((Way3Src1Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way4Src1Addr]}) : {`EnableValue,7'd0} ;
            RegOut4Src2Able                     <= (Way4Src2Able ) ;
            {RegOut4Src2NoDate,RegOut4Src2Addr} <= (Way4Src2Able ) ? (((Way3Src2Addr == Way3ArchAddr) & Way3RdAble) ? {`AbleValue,Way3RdAddr} :
                                                                      ((Way3Src2Addr == Way2ArchAddr) & Way2RdAble) ? {`AbleValue,Way2RdAddr} :
                                                                      ((Way3Src2Addr == Way1ArchAddr) & Way1RdAble) ? {`AbleValue,Way1RdAddr} : {`EnableValue,RENAMETABLE[Way4Src2Addr]}) : {`EnableValue,7'd0} ;
            RegOut4RdAble                       <= (Way4RdAble   ) ; 
            RegOut4RdAddr                       <= (Way4RdAble   ) ? Way4RdAddr : 7'd0                ;
        end
    end


    assign  Out1Src1Able   = RegOut1Src1Able ;
    assign  Out1Src1NoDate = RegOut1Src1NoDate ;
    assign  Out1Src1Addr   = RegOut1Src1Addr ;
    assign  Out1Src2Able   = RegOut1Src2Able ;
    assign  Out1Src2NoDate = RegOut1Src2NoDate ;
    assign  Out1Src2Addr   = RegOut1Src2Addr ; 
    assign  Out1RdAble     = RegOut1RdAble   ;
    assign  Out1RdAddr     = RegOut1RdAddr   ;
    assign  Out2Src1Able   = RegOut2Src1Able ;
    assign  Out2Src1NoDate = RegOut2Src1NoDate ;
    assign  Out2Src1Addr   = RegOut2Src1Addr ;  
    assign  Out2Src2Able   = RegOut2Src2Able ;
    assign  Out2Src2NoDate = RegOut2Src2NoDate ;
    assign  Out2Src2Addr   = RegOut2Src2Addr ; 
    assign  Out2RdAble     = RegOut2RdAble   ;
    assign  Out2RdAddr     = RegOut2RdAddr   ;
    assign  Out3Src1Able   = RegOut3Src1Able ;
    assign  Out3Src1NoDate = RegOut3Src1NoDate ;
    assign  Out3Src1Addr   = RegOut3Src1Addr ;  
    assign  Out3Src2Able   = RegOut3Src2Able ;
    assign  Out3Src2NoDate = RegOut3Src2NoDate ;
    assign  Out3Src2Addr   = RegOut3Src2Addr ; 
    assign  Out3RdAble     = RegOut3RdAble   ;
    assign  Out3RdAddr     = RegOut3RdAddr   ;
    assign  Out4Src1Able   = RegOut4Src1Able ;
    assign  Out4Src1NoDate = RegOut4Src1NoDate ;
    assign  Out4Src1Addr   = RegOut4Src1Addr ;  
    assign  Out4Src2Able   = RegOut4Src2Able ;
    assign  Out4Src2NoDate = RegOut4Src2NoDate ;
    assign  Out4Src2Addr   = RegOut4Src2Addr ; 
    assign  Out4RdAble     = RegOut4RdAble   ;
    assign  Out4RdAddr     = RegOut4RdAddr   ;


    assign Use1Able  = RegOut1Src1Able ;
    assign Use1Addr  = RegOut1Src1Addr ;
    assign Use2Able  = RegOut1Src2Able ;
    assign Use2Addr  = RegOut1Src2Addr ;
    assign Use3Able  = RegOut1RdAble   ;
    assign Use3Addr  = RegOut1RdAddr   ;
    assign Use4Able  = RegOut2Src1Able ;
    assign Use4Addr  = RegOut2Src1Addr ;
    assign Use5Able  = RegOut2Src2Able ;
    assign Use5Addr  = RegOut2Src2Addr ;
    assign Use6Able  = RegOut2RdAble   ;
    assign Use6Addr  = RegOut2RdAddr   ;
    assign Use7Able  = RegOut3Src1Able ;
    assign Use7Addr  = RegOut3Src1Addr ;
    assign Use8Able  = RegOut3Src2Able ;
    assign Use8Addr  = RegOut3Src2Addr ;
    assign Use9Able  = RegOut3RdAble   ;
    assign Use9Addr  = RegOut3RdAddr   ;
    assign Use10Able  = RegOut4Src1Able ;
    assign Use10Addr  = RegOut4Src1Addr ;
    assign Use11Able  = RegOut4Src2Able ;
    assign Use11Addr  = RegOut4Src2Addr ;
    assign Use12Able  = RegOut4RdAble   ;
    assign Use12Addr  = RegOut4RdAddr   ;
    
endmodule
