
`timescale 1ps/1ps
`include "define.v"
`include "Socdefine.vh"

//`include "/home/mulin/GradPrj/src/Lib/FIFO.v"

module ReOrderBuffer (
    input        wire                                Clk          ,
    input        wire                                Rest         ,

    //from CtrlBlock
    input        wire                                CtrlFlush    ,

    //from EU
    input        wire                                ALU1Able     ,
    input        wire          [5:0]                 ALU1Ptr      ,
    input        wire          [6:0]                 ALU1Update   , //其中7个数据中是包含例外和中断信息的数据
    input        wire                                ALU2Able     ,
    input        wire          [5:0]                 ALU2Ptr      ,
    input        wire          [6:0]                 ALU2Update   ,
    input        wire                                MLUAble      ,
    input        wire          [5:0]                 MLUPtr       ,
    input        wire          [6:0]                 MLUUpdate    ,
    input        wire                                DIVAble      ,
    input        wire          [5:0]                 DIVPtr       ,
    input        wire          [6:0]                 DIVUpdate    ,
    input        wire                                BRUAble      ,
    input        wire                                BRUBack      , //分支指令回溯                       
    input        wire          [5:0]                 BRUPtr       ,
    input        wire          [6:0]                 BRUUpdate    ,
    input        wire                                CSRUAble     ,
    input        wire          [5:0]                 CSRUPtr      ,
    input        wire          [6:0]                 CSRUUpdate   ,
    input        wire                                LSUAble      ,
    input        wire                                LSUBack      , //访存违例触发指令回溯
    input        wire          [3:0]                 StorBufPtr   , //store buffer ptr 
    input        wire          [5:0]                 LSUPtr       ,
    input        wire          [6:0]                 LSUUpdate    ,

    //from issue 
    input        wire                                Inst1Able    ,
    
    input        wire                                InstStart    ,

    input        wire          [16:0]                Inst1Inform  ,
    input        wire                                Inst2Able    ,
    input        wire          [16:0]                Inst2Inform  ,
    input        wire                                Inst3Able    ,
    input        wire          [16:0]                Inst3Inform  ,
    input        wire                                Inst4Able    ,
    input        wire          [16:0]                Inst4Inform  ,
    //to Issue 
    output       wire                                Inst1Full    ,
    output       wire                                Inst2Full    ,
    output       wire                                Inst3Full    ,
    output       wire                                Inst4Full    ,

    //to CSR
    output       wire                                ExceptAble   ,
    output       wire          [`InstAddrBus]        ExceptPC     ,
    output       wire          [5:0]                 ExceptCode   ,

    //to Physical register file
    output       wire                                RetireReg1Able,
    output       wire         [5:0]                  RetireReg1Addr,
    output       wire                                RetireReg2Able,
    output       wire         [5:0]                  RetireReg2Addr,
    output       wire                                RetireReg3Able,
    output       wire         [5:0]                  RetireReg3Addr,
    output       wire                                RetireReg4Able,
    output       wire         [5:0]                  RetireReg4Addr

);
    localparam FIFoWIDENUM = 23 ;

    localparam INSTIN = 0;
    localparam INSTWR = 1; //instraction write retire
    localparam BREAK  = 2'b01 ;
    localparam START  = 2'b10 ;
    localparam NORMAL = 2'b00 ;
    reg   [13:0]  InstPayload [1:64] ; //[12:10] 表示SD指令在store buffer存储的位置 [9] valid ;[8:3] extercation code; [2] isnt ex ready; [1:0] 指令起末点标志

    //inst issue and write in FIFO
    wire [2:0] InstNumber ;
    assign InstNumber = (Inst1Able & Inst2Able & Inst3Able & Inst4Able) ? 3'd4  :
                        (Inst1Able & Inst2Able & Inst3Able & ~Inst4Able) ? 3'd3  :
                        (Inst1Able & Inst2Able & ~Inst3Able & ~Inst4Able) ? 3'd2  :
                        (Inst1Able & ~Inst2Able & ~Inst3Able & ~Inst4Able) ? 3'd1  :
                        (~Inst1Able & ~Inst2Able & ~Inst3Able & ~Inst4Able) ? 3'd0  : 3'd0;

    wire  [5:0] PayloadPtrC1 ;
    wire  [5:0] PayloadPtrC2 ;
    wire  [5:0] PayloadPtrC3 ; 
    wire  [5:0] PayloadPtrC4 ;

    assign PayloadPtrC1 = PayloadPtr[5:0]  ;
    assign PayloadPtrC2 = PayloadPtr[5:0] + 1 ;
    assign PayloadPtrC3 = PayloadPtr[5:0] + 2 ;
    assign PayloadPtrC4 = PayloadPtr[5:0] + 3 ;
    
    reg   [6:0]  PayloadPtr         ;
    always @(posedge Clk) begin
        if(!Rest) 
            PayloadPtr <= 7'd0 ;
        else 
            PayloadPtr <= PayloadPtr[5:0] + {4'd0,InstNumber} ;  //超过63要进行重定位
    end

    //after inst ex 
    integer j ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (j =0 ;j < 64 ;j = j + 1 ) begin
               InstPayload[j] <= 14'd0 ; 
            end 
        end
        else begin
            //update 
            InstPayload[ALU1Ptr][8:2] <= ALU1Able ? ALU1Update : InstPayload[ALU1Ptr][8:2] ;
            InstPayload[ALU2Ptr][8:2] <= ALU2Able ? ALU2Update : InstPayload[ALU2Ptr][8:2] ;
            InstPayload[MLUPtr][8:2]  <= MLUAble  ? MLUUpdate  : InstPayload[MLUPtr][8:2]  ;
            InstPayload[DIVPtr][8:2]  <= DIVAble  ? DIVUpdate  : InstPayload[DIVPtr][8:2]  ;
            InstPayload[BRUPtr][8:2]  <= BRUAble  ? BRUUpdate  : InstPayload[BRUPtr][8:2]  ;
            InstPayload[LSUPtr][8:2]  <= LSUAble  ? LSUUpdate  : InstPayload[LSUPtr][8:2]  ;
            InstPayload[CSRUPtr][8:2] <= CSRUAble ? CSRUUpdate : InstPayload[CSRUPtr][8:2] ;

            //store buffer address update
            InstPayload[LSUPtr][13:10]  <= LSUAble  ? StorBufPtr : InstPayload[LSUPtr][13:10]  ;

            // allocat 
            InstPayload[PayloadPtrC1][9]   <= `AbleValue ;
            //重定向开始
            InstPayload[PayloadPtrC1][1:0] <= InstStart ? START : NORMAL ;

            InstPayload[PayloadPtrC2][9]   <= `AbleValue ;
            InstPayload[PayloadPtrC3][9]   <= `AbleValue ;
            InstPayload[PayloadPtrC4][9]   <= `AbleValue ;
            //回溯 打断点的方式
            InstPayload[BRUPtr][1:0] <= BRUBack ? BREAK : NORMAL ;
            InstPayload[LSUBack][1:0] <= LSUBack ? BREAK : NORMAL ;
        end
    end


    reg  [2:0]   FifoOffset  ;
    always @(posedge Clk) begin
        if(!Rest)
            FifoOffset <= 3'd0 ;
        else 
            FifoOffset <= (FifoOffset[1:0] + InstNumber) ;
    end

    wire                   Wu1_FIFOable ;
    wire [FIFoWIDENUM-1:0] Wu1_FIFOdata ;

    assign Wu1_FIFOable = (FifoOffset[1:0] == 0) ?  Inst1Able : 
                          (FifoOffset[1:0] == 1) ?  Inst4Able : 
                          (FifoOffset[1:0] == 2) ?  Inst3Able : 
                          (FifoOffset[1:0] == 3) ?  Inst2Able : `EnableValue ;
    assign Wu1_FIFOdata = (FifoOffset[1:0] == 0) ?  {Inst1Inform,PayloadPtrC1} : 
                          (FifoOffset[1:0] == 1) ?  {Inst2Inform,PayloadPtrC2} : 
                          (FifoOffset[1:0] == 2) ?  {Inst3Inform,PayloadPtrC3} : 
                          (FifoOffset[1:0] == 3) ?  {Inst4Inform,PayloadPtrC4} : {FIFoWIDENUM{1'b0}} ;

    wire                   Wu2_FIFOable ;
    wire [FIFoWIDENUM-1:0] Wu2_FIFOdata ;

    assign Wu2_FIFOable = (FifoOffset[1:0] == 0) ?  Inst2Able : 
                          (FifoOffset[1:0] == 1) ?  Inst1Able : 
                          (FifoOffset[1:0] == 2) ?  Inst4Able : 
                          (FifoOffset[1:0] == 3) ?  Inst3Able : `EnableValue ;
    assign Wu2_FIFOdata = (FifoOffset[1:0] == 0) ?  {Inst2Inform,PayloadPtrC2}  : 
                          (FifoOffset[1:0] == 1) ?  {Inst1Inform,PayloadPtrC1} : 
                          (FifoOffset[1:0] == 2) ?  {Inst4Inform,PayloadPtrC4} : 
                          (FifoOffset[1:0] == 3) ?  {Inst3Inform,PayloadPtrC3} : {FIFoWIDENUM{1'b0}} ;

    wire                   Wu3_FIFOable ;
    wire [FIFoWIDENUM-1:0] Wu3_FIFOdata ;

    assign Wu3_FIFOable = (FifoOffset[1:0] == 0) ?  Inst3Able : 
                          (FifoOffset[1:0] == 1) ?  Inst2Able : 
                          (FifoOffset[1:0] == 2) ?  Inst1Able : 
                          (FifoOffset[1:0] == 3) ?  Inst4Able : `EnableValue ;
    assign Wu3_FIFOdata = (FifoOffset[1:0] == 0) ?  {Inst3Inform,PayloadPtrC3} : 
                          (FifoOffset[1:0] == 1) ?  {Inst2Inform,PayloadPtrC2} : 
                          (FifoOffset[1:0] == 2) ?  {Inst1Inform,PayloadPtrC1} : 
                          (FifoOffset[1:0] == 3) ?  {Inst4Inform,PayloadPtrC4} : {FIFoWIDENUM{1'b0}} ;

    wire                   Wu4_FIFOable ;
    wire [FIFoWIDENUM-1:0] Wu4_FIFOdata ;

    assign Wu4_FIFOable = (FifoOffset[1:0] == 0) ?  Inst4Able : 
                          (FifoOffset[1:0] == 1) ?  Inst3Able : 
                          (FifoOffset[1:0] == 2) ?  Inst2Able : 
                          (FifoOffset[1:0] == 3) ?  Inst1Able : `EnableValue ;
    assign Wu4_FIFOdata = (FifoOffset[1:0] == 0) ?  {Inst4Inform,PayloadPtrC4} : 
                          (FifoOffset[1:0] == 1) ?  {Inst3Inform,PayloadPtrC3} : 
                          (FifoOffset[1:0] == 2) ?  {Inst2Inform,PayloadPtrC2} : 
                          (FifoOffset[1:0] == 3) ?  {Inst1Inform,PayloadPtrC1} : {FIFoWIDENUM{1'b0}} ;
                          
    wire        FifoFull1 ;
    wire        FifoFull2 ;
    wire        FifoFull3 ; 
    wire        FifoFull4 ;

    wire [FIFoWIDENUM-1:0] FifoPreOut1 ;
    wire [FIFoWIDENUM-1:0] FifoPreOut2 ;
    wire [FIFoWIDENUM-1:0] FifoPreOut3 ;
    wire [FIFoWIDENUM-1:0] FifoPreOut4 ;
    //intlaveing FIFO 4w 4r
    FIFO#(
        .FIFOWIDE    ( FIFoWIDENUM )
    )u0_FIFO(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable       ),
        .Dout        ( Dout        ),
        .FifoPreOut  ( FifoPreOut1 ),
        .Wable       ( Wu1_FIFOable),
        .Din         ( Wu1_FIFOdata),
        .FifoClean   ( FifoClean   ),
        .FifoFull    ( FifoFull1   ),
        .FifoEmpty   ( FifoEmpty   )
    );

    FIFO#(
        .FIFOWIDE    ( FIFoWIDENUM )
    )u1_FIFO(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable       ),
        .Dout        ( Dout        ),
        .FifoPreOut  ( FifoPreOut2 ),
        .Wable       ( Wu2_FIFOable),
        .Din         ( Wu2_FIFOdata),
        .FifoClean   ( FifoClean   ),
        .FifoFull    ( FifoFull2   ),
        .FifoEmpty   ( FifoEmpty   )
    );

    FIFO#(
        .FIFOWIDE    ( FIFoWIDENUM )
    )u2_FIFO(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable       ),
        .Dout        ( Dout        ),
        .FifoPreOut  ( FifoPreOut3 ),
        .Wable       ( Wu3_FIFOable),
        .Din         ( Wu3_FIFOdata),
        .FifoClean   ( FifoClean   ),
        .FifoFull    ( FifoFull3   ),
        .FifoEmpty   ( FifoEmpty   )
    );

    FIFO#(
        .FIFOWIDE    ( FIFoWIDENUM )
    )u3_FIFO(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable       ),
        .Dout        ( Dout        ),
        .FifoPreOut  ( FifoPreOut4 ),
        .Wable       ( Wu4_FIFOable),
        .Din         ( Wu4_FIFOdata),
        .FifoClean   ( FifoClean   ),
        .FifoFull    ( FifoFull4   ),
        .FifoEmpty   ( FifoEmpty   )
    );
    //to issue 
    reg       RegFIFO1fullAble ;
    reg       RegFIFO2fullAble ;
    reg       RegFIFO3fullAble ;
    reg       RegFIFO4fullAble ;
    always @(posedge Clk) begin
        if(!Rest) begin
            RegFIFO1fullAble <= `EnableValue ;
            RegFIFO2fullAble <= `EnableValue ;
            RegFIFO3fullAble <= `EnableValue ;
            RegFIFO4fullAble <= `EnableValue ;
        end
        else begin
            RegFIFO1fullAble <= FifoFull1 ;
            RegFIFO2fullAble <= FifoFull2 ;
            RegFIFO3fullAble <= FifoFull3 ;
            RegFIFO4fullAble <= FifoFull4;
        end
    end

    assign Inst1Full = RegFIFO1fullAble ;
    assign Inst2Full = RegFIFO2fullAble ;
    assign Inst3Full = RegFIFO3fullAble ;
    assign Inst4Full = RegFIFO4fullAble ;

    //check oldest inst ready or no

    wire  Inst1CleanAble = (InstPayload[FifoPreOut1[5:0]][1:0] == BREAK);
    wire  Inst2CleanAble = (InstPayload[FifoPreOut2[5:0]][1:0] == BREAK);
    wire  Inst3CleanAble = (InstPayload[FifoPreOut3[5:0]][1:0] == BREAK);
    wire  Inst4CleanAble = (InstPayload[FifoPreOut4[5:0]][1:0] == BREAK);

    wire  Inst1StartAble = (InstPayload[FifoPreOut1[5:0]][1:0] == START);
    wire  Inst2StartAble = (InstPayload[FifoPreOut2[5:0]][1:0] == START);
    wire  Inst3StartAble = (InstPayload[FifoPreOut3[5:0]][1:0] == START);
    wire  Inst4StartAble = (InstPayload[FifoPreOut4[5:0]][1:0] == START);

    reg        CleanInst ;
    always @(posedge Clk) begin
        if(!Rest)
            CleanInst <= 1'b0 ;
        else  begin
            if(Inst1CleanAble | Inst2CleanAble | Inst3CleanAble | Inst4CleanAble)
                CleanInst <= 1'b1 ;
            if(Inst1StartAble | Inst2StartAble | Inst3StartAble | Inst4StartAble)
                CleanInst <= 1'b0 ;
        end 
    end

    wire  Port1UnUp = ((Inst1CleanAble) || (CleanInst ==1'b1)) ;
    wire  Port2UnUp = (Port1UnUp || Inst2CleanAble) ; 
    wire  Port3UnUp = (Port2UnUp || Inst3CleanAble) ; 
    wire  Port4UnUp = (Port3UnUp || Inst4CleanAble) ; 

    wire  Port1Start = Inst1StartAble ;
    wire  Port2Start = (Inst2StartAble || Port1Start);
    wire  Port3Start = (Inst3StartAble || Port2Start);  
    wire  Port4Start = (Inst4StartAble || Port3Start);

    wire  Inst1PopReady ;
    wire  Inst2PopReady ;
    wire  Inst3PopReady ;
    wire  Inst4PopReady ;
    assign Inst1PopReady = Port1UnUp ? (Port1Start ? `EnableValue : `AbleValue) :
                           (InstPayload[FifoPreOut1[5:0]][2] == INSTWR) ? `AbleValue :`EnableValue ;
    assign Inst2PopReady = Port2UnUp ? (Port2Start ? `EnableValue : `AbleValue) :
                           (InstPayload[FifoPreOut2[5:0]][2] == INSTWR) ? `AbleValue :`EnableValue ;
    assign Inst3PopReady = Port3UnUp ? (Port3Start ? `EnableValue : `AbleValue) :
                           (InstPayload[FifoPreOut3[5:0]][2] == INSTWR) ? `AbleValue :`EnableValue ;
    assign Inst4PopReady = Port4UnUp ? (Port4Start ? `EnableValue : `AbleValue) :
                           (InstPayload[FifoPreOut4[5:0]][2] == INSTWR) ? `AbleValue :`EnableValue ;


    
endmodule
