`timescale 1ps/1ps
`include "define.v"
`include "Socdefine.vh"

`include "../Lib/CRIQ.v"

module ReOrderBuffer #(
    parameter ROBPTRWIDE = 6 , //相当与ROB的deep的表述宽度
    parameter ROBDEEP    = 64 ,
    parameter UPDATEWIDE = 49 ,
    parameter INSTFORM   = 21 ,


    parameter STBPTR     = 2 ,
    parameter EXCENTRY   = 32,
    parameter FTQPTR     = 6 ,
    parameter REDIRECT   = 1 ,//重定向
    parameter EXSTATE    = 1 ,
    parameter EXCCODE    = 6 ,
    parameter EXCABLE    = 1 , //当中断信号时redirect重定向信号依然会置一
    parameter RENAMEW    = 12,
    parameter MOPCW      = 8 ,
    parameter VALIDW     = 1
) (
    input        wire                                Clk          ,
    input        wire                                Rest         ,

    //from EU
    input        wire                                ALU1Able     ,
    input        wire          [ROBPTRWIDE-1:0]      ALU1Ptr      ,
    input        wire          [UPDATEWIDE-1:0]      ALU1Update   , //其中7个数据中是包含例外和中断信息的数据
    input        wire                                ALU2Able     ,
    input        wire          [ROBPTRWIDE-1:0]      ALU2Ptr      ,
    input        wire          [UPDATEWIDE-1:0]      ALU2Update   ,
    input        wire                                MLUAble      ,
    input        wire          [ROBPTRWIDE-1:0]      MLUPtr       ,
    input        wire          [UPDATEWIDE-1:0]      MLUUpdate    ,
    input        wire                                DIVAble      ,
    input        wire          [ROBPTRWIDE-1:0]      DIVPtr       ,
    input        wire          [UPDATEWIDE-1:0]      DIVUpdate    ,
    input        wire                                BRUAble      ,                     
    input        wire          [ROBPTRWIDE-1:0]      BRUPtr       ,
    input        wire          [UPDATEWIDE-1:0]      BRUUpdate    ,
    input        wire                                CSRUAble     ,
    input        wire          [ROBPTRWIDE-1:0]      CSRUPtr      ,
    input        wire          [UPDATEWIDE-1:0]      CSRUUpdate   , 
    input        wire                                LSUAble      ,
    input        wire          [ROBPTRWIDE-1:0]      LSUPtr       ,
    input        wire          [UPDATEWIDE-1:0]      LSUUpdate    , 

    //from issue 
    input        wire                                Inst1Able    ,
    input        wire          [INSTFORM-1:0]        Inst1Inform  ,
    input        wire                                Inst2Able    ,
    input        wire          [INSTFORM-1:0]        Inst2Inform  ,
    input        wire                                Inst3Able    ,
    input        wire          [INSTFORM-1:0]        Inst3Inform  ,
    input        wire                                Inst4Able    ,
    input        wire          [INSTFORM-1:0]        Inst4Inform  ,
    //to Issue 
    output       wire                                Inst1Full    ,
    output       wire                                Inst2Full    ,
    output       wire                                Inst3Full    ,
    output       wire                                Inst4Full    ,
    //to LSU
    output       wire                                ExStore1Able  , //这里的STORE buffer预计设置为4行，那么当store指令进入buffer才会给指令EX ok的信号
    output       wire         [STBPTR-1:0]           EcStore1Ptr   ,
    output       wire                                ExStore1Able  ,
    output       wire         [STBPTR-1:0]           EcStore1Ptr   ,
    output       wire                                ExStore1Able  , 
    output       wire         [STBPTR-1:0]           EcStore1Ptr   ,
    output       wire                                ExStore1Able  , 
    output       wire         [STBPTR-1:0]           EcStore1Ptr   ,
    //to CSRU
    output       wire                                ExCsruAble    , //CSRU只支持一个写，因为毕竟他不写cheche不会miss，也就是说当这条指令进入readybuffer在会给ROBready
    //to FTQ
    output       wire                                FTQUpAble    ,
    output       wire                                FTQReDirect  ,
    output       wire                                FTQRePc      ,
    output       wire         [FTQPTR-1:0]           FTQInstPtr   ,
    output       wire         [`InstAddrBus]         FTQRePcDate  ,
    //to CtrlBlock
    output       wire                                ROBReLoad    ,  
    //from Ctrlblock
    input        wire                                ReMappaRAT   ,                      
    //to RAT
    output       wire         [PHYRPTRW-1:0]         ReMappingToA1 , 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA2 , 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA3 ,               
    output       wire         [PHYRPTRW-1:0]         ReMappingToA4 , 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA5 , 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA6 , 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA7 , 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA8 , 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA9 , 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA10, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA11, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA12, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA13, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA14, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA15, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA16, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA17, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA18, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA19, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA20, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA21, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA22, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA23, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA24, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA25, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA26, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA27, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA28, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA29, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA30, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA31, 
    output       wire         [PHYRPTRW-1:0]         ReMappingToA32 
);

    reg   [UPDATEWIDE+INSTFORM-1:0] InstInfo [0:ROBDEEP-1] ;

    reg   [2 :0]  WriteOffset ; //四个写端口和四个读端口是不会改变的因为所以不做参数化因为发射数已经确定
    reg   [2 :0]  ReadOffset  ;

    wire [2:0] InstNumber ;
    assign InstNumber = (Inst1Able & Inst2Able & Inst3Able & Inst4Able) ? 3'd4  :
                        (Inst1Able & Inst2Able & Inst3Able & ~Inst4Able) ? 3'd3  :
                        (Inst1Able & Inst2Able & ~Inst3Able & ~Inst4Able) ? 3'd2  :
                        (Inst1Able & ~Inst2Able & ~Inst3Able & ~Inst4Able) ? 3'd1  :
                        (~Inst1Able & ~Inst2Able & ~Inst3Able & ~Inst4Able) ? 3'd0  : 3'd0;   

    always @(posedge Clk) begin
        if(!Rest) begin
            WriteOffset <= 3'b0 ;
        end
        else begin
            WriteOffset <= WriteOffset[1:0] + InstNumber ;
        end
    end 

    wire   [INSTFORM-1:0]  W1_Data       ;
    assign W1_Data    =   (WriteOffset[1:0] == 0) ?  Inst1Inform : 
                          (WriteOffset[1:0] == 1) ?  Inst4Inform : 
                          (WriteOffset[1:0] == 2) ?  Inst3Inform : 
                          (WriteOffset[1:0] == 3) ?  Inst2Inform : {INSTFORM{1'b0}} ;
    wire                   Wu1_CRIQable ;
    assign Wu1_CRIQable = (WriteOffset[1:0] == 0) ?  Inst1Able : 
                          (WriteOffset[1:0] == 1) ?  Inst4Able : 
                          (WriteOffset[1:0] == 2) ?  Inst3Able : 
                          (WriteOffset[1:0] == 3) ?  Inst2Able : `EnableValue ;
    wire   [INSTFORM-1:0]  W2_Data       ;
    assign W2_Data    =   (WriteOffset[1:0] == 0) ?  Inst2Inform : 
                          (WriteOffset[1:0] == 1) ?  Inst1Inform : 
                          (WriteOffset[1:0] == 2) ?  Inst4Inform : 
                          (WriteOffset[1:0] == 3) ?  Inst3Inform : {INSTFORM{1'b0}} ;
    wire                   Wu2_CRIQable ;
    assign Wu2_CRIQable = (WriteOffset[1:0] == 0) ?  Inst2Able : 
                          (WriteOffset[1:0] == 1) ?  Inst1Able : 
                          (WriteOffset[1:0] == 2) ?  Inst4Able : 
                          (WriteOffset[1:0] == 3) ?  Inst3Able : `EnableValue ;
    wire   [INSTFORM-1:0]  W3_Data       ;
    assign W3_Data    =   (WriteOffset[1:0] == 0) ?  Inst3Inform : 
                          (WriteOffset[1:0] == 1) ?  Inst2Inform : 
                          (WriteOffset[1:0] == 2) ?  Inst1Inform : 
                          (WriteOffset[1:0] == 3) ?  Inst4Inform : {INSTFORM{1'b0}} ;
    wire                   Wu3_CRIQable ;
    assign Wu3_CRIQable = (WriteOffset[1:0] == 0) ?  Inst3Able : 
                          (WriteOffset[1:0] == 1) ?  Inst2Able : 
                          (WriteOffset[1:0] == 2) ?  Inst1Able : 
                          (WriteOffset[1:0] == 3) ?  Inst4Able : `EnableValue ;
    wire   [INSTFORM-1:0]  W4_Data       ;
    assign W4_Data    =   (WriteOffset[1:0] == 0) ?  Inst4Inform : 
                          (WriteOffset[1:0] == 1) ?  Inst3Inform : 
                          (WriteOffset[1:0] == 2) ?  Inst2Inform : 
                          (WriteOffset[1:0] == 3) ?  Inst1Inform : {INSTFORM{1'b0}} ;
    wire                   Wu4_CRIQable ;
    assign Wu4_CRIQable = (WriteOffset[1:0] == 0) ?  Inst4Able : 
                          (WriteOffset[1:0] == 1) ?  Inst3Able : 
                          (WriteOffset[1:0] == 2) ?  Inst2Able : 
                          (WriteOffset[1:0] == 3) ?  Inst1Able : `EnableValue ;

    integer  j;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (j =0 ;j < ROBDEEP ;j = j + 1 ) begin
               InstInfo[j] <= {(UPDATEWIDE+INSTFORM){1'b0}}; 
            end
        end
        else begin
            //up inst from decode
            InstInfo[Din1] <= Wu1_CRIQable ? {Inst1Inform,{UPDATEWIDE{1'b0}}} : InstInfo[Din1];
            InstInfo[Din2] <= Wu2_CRIQable ? {Inst2Inform,{UPDATEWIDE{1'b0}}} : InstInfo[Din2];
            InstInfo[Din3] <= Wu3_CRIQable ? {Inst3Inform,{UPDATEWIDE{1'b0}}} : InstInfo[Din3];
            InstInfo[Din4] <= Wu4_CRIQable ? {Inst4Inform,{UPDATEWIDE{1'b0}}} : InstInfo[Din4];
            //up inst state from EU
            InstInfo[ALU1Ptr][UPDATEWIDE-1:0] <= ALU1Able  ?  ALU1Update :InstInfo[ALU1Ptr][UPDATEWIDE-1:0];
            InstInfo[ALU2Ptr][UPDATEWIDE-1:0] <= ALU2Able  ?  ALU2Update :InstInfo[ALU2Ptr][UPDATEWIDE-1:0];
            InstInfo[MLUPtr ][UPDATEWIDE-1:0] <= MLUAble   ?  MLUUpdate  :InstInfo[MLUPtr ][UPDATEWIDE-1:0];
            InstInfo[DIVPtr ][UPDATEWIDE-1:0] <= DIVAble   ?  DIVUpdate  :InstInfo[DIVPtr ][UPDATEWIDE-1:0];
            InstInfo[BRUPtr ][UPDATEWIDE-1:0] <= BRUAble   ?  BRUUpdate  :InstInfo[BRUPtr ][UPDATEWIDE-1:0];
            InstInfo[CSRUPtr][UPDATEWIDE-1:0] <= CSRUAble  ?  CSRUUpdate :InstInfo[CSRUPtr][UPDATEWIDE-1:0];
            InstInfo[LSUPtr ][UPDATEWIDE-1:0] <= LSUAble   ?  LSUUpdate  :InstInfo[LSUPtr ][UPDATEWIDE-1:0];
        end
    end


    wire  [ROBPTRWIDE-1:0] Frontd1;
    wire  [ROBPTRWIDE-1:0] Frontd2;
    wire  [ROBPTRWIDE-1:0] Frontd3;
    wire  [ROBPTRWIDE-1:0] Frontd4;
    wire  [ROBPTRWIDE-1:0] Din1   ;
    wire  [ROBPTRWIDE-1:0] Din2   ;
    wire  [ROBPTRWIDE-1:0] Din3   ;
    wire  [ROBPTRWIDE-1:0] Din4   ;
    wire  [ROBPTRWIDE-1:0] Dout1  ;
    wire  [ROBPTRWIDE-1:0] Dout2  ;
    wire  [ROBPTRWIDE-1:0] Dout3  ;
    wire  [ROBPTRWIDE-1:0] Dout4  ;
    wire  [ROBPTRWIDE-1:0] CriqPreOut1 ;
    wire  [ROBPTRWIDE-1:0] CriqPreOut2 ;
    wire  [ROBPTRWIDE-1:0] CriqPreOut3 ; 
    wire  [ROBPTRWIDE-1:0] CriqPreOut4 ;
    wire                   Rable1 ;
    wire                   Rable2 ;
    wire                   Rable3 ;
    wire                   Rable4 ;
    wire                   CriqFull1;
    wire                   CriqFull2;
    wire                   CriqFull3;
    wire                   CriqFull4;

    assign Din1 = (Frontd1 == 0) ? 0 : Frontd1 + 4 ;//
    assign Din2 = (Frontd2 == 0) ? 1 : Frontd2 + 4 ;
    assign Din3 = (Frontd3 == 0) ? 2 : Frontd3 + 4 ; 
    assign Din4 = (Frontd4 == 0) ? 3 : Frontd4 + 4 ;

    CRIQ#(
        .CRIQWIDE    ( ROBPTRWIDE  ),
        .CRIQDEEP    ( ROBDEEP / 4 ),
        .PTRWIDE     ( ROBPTRWIDE-2)
    )u1_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable1      ),
        .Dout        ( Dout1       ),
        .CriqPreOut  ( CriqPreOut1 ),
        .Frontd      ( Frontd1     ),
        .Wable       ( Wu1_CRIQable),
        .Din         ( Din1        ),
        .CriqClean   ( CriqClean   ),
        .CriqFull    ( CriqFull1   ),
        .CriqEmpty   ( CriqEmpty   )
    );

    CRIQ#(
        .CRIQWIDE    ( ROBPTRWIDE  ),
        .CRIQDEEP    ( ROBDEEP / 4 ),
        .PTRWIDE     ( ROBPTRWIDE-2)
    )u2_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable2      ),
        .Dout        ( Dout2       ),
        .CriqPreOut  ( CriqPreOut2 ),
        .Frontd      ( Frontd2     ),
        .Wable       ( Wu2_CRIQable),
        .Din         ( Din2        ),
        .CriqClean   ( CriqClean   ),
        .CriqFull    ( CriqFull2   ),
        .CriqEmpty   ( CriqEmpty   )
    );

    CRIQ#(
        .CRIQWIDE    ( ROBPTRWIDE   ),
        .CRIQDEEP    ( ROBDEEP / 4  ),
        .PTRWIDE     ( ROBPTRWIDE-2 )
    )u3_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable3      ),
        .Dout        ( Dout3       ),
        .CriqPreOut  ( CriqPreOut3 ),
        .Frontd      ( Frontd3     ),
        .Wable       ( Wu3_CRIQable),
        .Din         ( Din3        ),
        .CriqClean   ( CriqClean   ),
        .CriqFull    ( CriqFull3   ),
        .CriqEmpty   ( CriqEmpty   )
    );

    CRIQ#(
        .CRIQWIDE    ( ROBPTRWIDE  ),
        .CRIQDEEP    ( ROBDEEP / 4 ),
        .PTRWIDE     ( ROBPTRWIDE-2)
    )u4_CRIQ(
        .Clk         ( Clk         ),
        .Rest        ( Rest        ),
        .Rable       ( Rable4      ),
        .Dout        ( Dout4       ),
        .CriqPreOut  ( CriqPreOut4 ),
        .Frontd      ( Frontd4     ),
        .Wable       ( Wu4_CRIQable),
        .Din         ( Din4        ),
        .CriqClean   ( CriqClean   ),
        .CriqFull    ( CriqFull4   ),
        .CriqEmpty   ( CriqEmpty   )
    );

    assign Inst1Full = CriqFull1 ;
    assign Inst2Full = CriqFull2 ;
    assign Inst3Full = CriqFull3 ; 
    assign Inst4Full = CriqFull4 ;

    wire   [2:0]    SubTrilCOunt ;
    always @(posedge Clk) begin
        if(!Rest)begin
            ReadOffset <= 3'd0 ;
        end
        else begin
            ReadOffset <= ReadOffset[1:0] + SubTrilCOunt ;
        end
    end

    wire     CanPopInst1ForDri     ;
    wire     CanPopInst2ForDri     ;
    wire     CanPopInst3ForDri     ;
    wire     CanPopInst4ForDri     ;
    assign   {CanPopInst1ForDri, CanPopInst2ForDri, CanPopInst3ForDri, CanPopInst4ForDri} 
     =  (ReadOffset == 0) ? {`AbleValue,
                            ~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1], 
                            (~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1] && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]), 
                            ((~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1] && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]) && ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1])} :
        (ReadOffset == 1) ? {((~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1] && ~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]) && ~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]),
                            `AbleValue,
                            ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1],  
                            (~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1] && ~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]), } :
        (ReadOffset == 2) ? {(~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1] && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]) ,
                            ((~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1] && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]) && ~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]), 
                            `AbleValue,
                            ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]} :
        (ReadOffset == 3) ? {~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1],
                            (~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1] && ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]), 
                            ((~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1] && ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]) && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT-1]), 
                            `AbleValue} : {4'b0000} ;


    wire     CanPopInst1ForEx      ;
    wire     CanPopInst2ForEx      ;
    wire     CanPopInst3ForEx      ;
    wire     CanPopInst4ForEx      ;
    assign {CanPopInst1ForEx, CanPopInst2ForEx, CanPopInst3ForEx, CanPopInst4ForEx} 
     =  (ReadOffset == 0) ? {~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1], 
                            (~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]), 
                            ((~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]), 
                            (((~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1])} :
        (ReadOffset == 1) ? {(((~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]),
                            ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1],  
                            (~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]), 
                            ((~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1])} :
        (ReadOffset == 2) ? {((~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]), 
                            (((~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]),
                            ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1],  
                            (~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) } :
        (ReadOffset == 3) ? {(~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]), 
                            ((~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]), 
                            (((~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] && ~InstInfo[CriqPreOut3][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut2][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) && ~InstInfo[CriqPreOut1][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1]) ,
                            ~InstInfo[CriqPreOut4][STBPTR+EXCENTRY+FTQPTR+REDIRECT+EXSTATE-1] } : {4'b0000} ;

    
    assign Rable1 = CanPopInst1ForDri && CanPopInst1ForEx ;
    assign Rable2 = CanPopInst2ForDri && CanPopInst2ForEx ;
    assign Rable3 = CanPopInst3ForDri && CanPopInst3ForEx ;
    assign Rable4 = CanPopInst4ForDri && CanPopInst4ForEx ;

    assign SubTrilCOunt = Rable1 + Rable2 + Rable3 + Rable4 ;


    wire  [UPDATEWIDE+INSTFORM-1:0]  


    




ArchState#(
    .PHYRPTRW       ( RENAMEW-5      )
)u_ArchState(
    .Clk            ( Clk            ),
    .Rest           ( Rest           ),
    .RetireReg1Able ( RetireReg1Able ),
    .RetireAR1Addr  ( RetireAR1Addr  ),
    .RetirePR1Addr  ( RetirePR1Addr  ),
    .RetireReg2Able ( RetireReg2Able ),
    .RetireAR2Addr  ( RetireAR2Addr  ),
    .RetirePR2Addr  ( RetirePR2Addr  ),
    .RetireReg3Able ( RetireReg3Able ),
    .RetireAR3Addr  ( RetireAR3Addr  ),
    .RetirePR3Addr  ( RetirePR3Addr  ),
    .RetireReg4Able ( RetireReg4Able ),
    .RetireAR4Addr  ( RetireAR4Addr  ),
    .RetirePR4Addr  ( RetirePR4Addr  ),
    .ReMapping      ( ReMappaRAT     ),
    .ReMappingAS1   ( ReMappingToA1  ),
    .ReMappingAS2   ( ReMappingToA2  ),
    .ReMappingAS3   ( ReMappingToA3  ),
    .ReMappingAS4   ( ReMappingToA4  ),
    .ReMappingAS5   ( ReMappingToA5  ),
    .ReMappingAS6   ( ReMappingToA6  ),
    .ReMappingAS7   ( ReMappingToA7  ),
    .ReMappingAS8   ( ReMappingToA8  ),
    .ReMappingAS9   ( ReMappingToA9  ),
    .ReMappingAS10  ( ReMappingToA10  ),
    .ReMappingAS11  ( ReMappingToA11 ),
    .ReMappingAS12  ( ReMappingToA12 ),
    .ReMappingAS13  ( ReMappingToA13 ),
    .ReMappingAS14  ( ReMappingToA14 ),
    .ReMappingAS15  ( ReMappingToA15 ),
    .ReMappingAS16  ( ReMappingToA16 ),
    .ReMappingAS17  ( ReMappingToA17 ),
    .ReMappingAS18  ( ReMappingToA18 ),
    .ReMappingAS19  ( ReMappingToA19 ),
    .ReMappingAS20  ( ReMappingToA20 ),
    .ReMappingAS21  ( ReMappingToA21 ),
    .ReMappingAS22  ( ReMappingToA22 ),
    .ReMappingAS23  ( ReMappingToA23 ),
    .ReMappingAS24  ( ReMappingToA24 ),
    .ReMappingAS25  ( ReMappingToA25 ),
    .ReMappingAS26  ( ReMappingToA26 ),
    .ReMappingAS27  ( ReMappingToA27 ),
    .ReMappingAS28  ( ReMappingToA28 ),
    .ReMappingAS29  ( ReMappingToA29 ),
    .ReMappingAS30  ( ReMappingToA30 ),
    .ReMappingAS31  ( ReMappingToA31 ),
    .ReMappingAS32  ( ReMappingToA32 )
);



`ifdef DEBUG_REPORT


`endif 



endmodule

