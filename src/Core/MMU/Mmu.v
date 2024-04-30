`timescale 1ps/1ps
`include "../define.v"

module Mmu (
    input       wire                                     Clk           ,
    input       wire                                     Rest          ,
    //from Csr
    input       wire      [9:0]                          Asid          ,
    input       wire      [`DataBus]                     CsrDmw0Date   ,
    input       wire      [`DataBus]                     CsrDmw1Date   ,
    input       wire      [`DataBus]                     CsrCrmdDate   ,
    //input       wire                                     CsrReadTlbAble,
    input       wire      [5:0]                          CsrReadTlbAddr ,
    output      wire      [89-1:0]                       CsrReadTlbDate , 
    input       wire                                     CsrSerchTlbAble, 
    input       wire      [28:0]                         CsrSerchInfrom ,
    output      wire                                     CsrSerchAble   ,
    output      wire      [5:0]                          CsrSerchIdxDate,
    input       wire                                     CsrWriteTlbAble,
    input       wire      [5:0]                          CsrWriteTlbAddr,
    input       wire      [88:0]                         CsrWriteTlbDate, 
    input       wire                                     CsrInvEn       ,
    input       wire      [ 4:0]                         CsrInvOp       ,
    input       wire      [ 9:0]                         CsrInvAsid     ,
    input       wire      [18:0]                         CsrInvVppn     , 
    //from Inst
    input       wire                                     InstFetch      ,
    input       wire      [31:0]                         InstVritualA   ,
    output      wire      [1:0]                          InstOperType   ,
    output      wire                                     InstTlbTrap    , // //to ROB save ICache excaption when before inst exection finash
    output      wire      [6:0]                          InstTlbTrapType, 
    output      wire      [`InstAddrBus]                 InstPhysicalAddr,
    //from access memory
    input       wire                                     MemAccess      ,
    input       wire                                     LoadOrStore    , //1store 0load
    input       wire      [31:0]                         MemVritualA    ,
    output      wire      [1:0]                          MemOperType    ,
    output      wire                                     MemTlbTrap     ,
    output      wire      [6:0]                          MemTlbTrapType ,
    output      wire      [`InstAddrBus]                 MemPhysicalAddr,
    //from CtrlBlock
    //input       wire                                     MmuStop        ,
    input       wire                                     MmuFlash      
);
    wire  [18:0]     MmuReadVppn ;
    wire  [9:0]      MmuReadAsid ;
    wire             MmuReadG    ;
    wire  [5:0]      MmuReadPs   ;
    wire             MmuReadE    ;
    wire             MmuReadV0   ;
    wire             MmuReadD0   ;
    wire  [1:0]      MmuReadMat0 ;
    wire  [1:0]      MmuReadPlv0 ;
    wire  [19:0]     MmuReadPpn0 ;
    wire             MmuReadV1   ;
    wire             MmuReadD1   ;
    wire  [1:0]      MmuReadMat1 ;
    wire  [1:0]      MmuReadPlv1 ;
    wire  [19:0]     MmuReadPpn1 ;

    assign CsrReadTlbDate = {MmuReadVppn,MmuReadAsid,MmuReadG,MmuReadPs,MmuReadE,
                             MmuReadV0,MmuReadD0,MmuReadMat0,MmuReadPlv0,MmuReadPpn0,
                             MmuReadV1,MmuReadD1,MmuReadMat1,MmuReadPlv1,MmuReadPpn1};


    wire                 DriectDmw0Able   = (InstVritualA[31:29] == CsrDmw0Date[31:29]);
    // wire  [1:0]          DriectDmw0Plv    = {CsrDmw0Date[3],CsrDmw0Date[0]} ;
    // wire  [1:0]          DriectDmw0Mat    = CsrDmw0Date[5:4] ;
    wire  [`InstAddrBus] Dmw0Physicaladdr = {CsrDmw0Date[27:25],InstVritualA[28:0]} ;
    wire                 DriectDmw1Able   = (InstVritualA[31:29] == CsrDmw1Date[31:29]);
    // wire  [1:0]          DriectDmw1Plv    = {CsrDmw1Date[3],CsrDmw1Date[0]} ;
    // wire  [1:0]          DriectDmw1Mat    = CsrDmw1Date[5:4] ;
    wire  [`InstAddrBus] Dmw1Physicaladdr = {CsrDmw1Date[27:25],InstVritualA[28:0]} ;


    wire  [18:0]   PortInstVppn = InstVritualA[31:13] ;
    wire           PortInstOdd  = ~InstVritualA[12]   ;
    wire  [19:0]   PortInstPpn ;
    wire           PortInstFund;
    wire           PortInstV   ;
    wire           PortInstD   ;
    wire  [1:0]    PortInstMat ;
    wire  [1:0]    PortInstPlv ;
    wire  [5:0]    PortInstPs  ;
    wire  [`InstAddrBus]    MmuPhysicalAddr = {PortInstPpn, InstVritualA[11:0]} ;

    reg [`InstAddrBus] InstPhysicalAddrReg ;
    reg [6:0]          InstTlbTrapTypeReg  ;
    reg                InstTlbTrapAbleReg  ;     
    reg [1:0]          InstMatType         ;
    always @(posedge Clk) begin
        if(!Rest) begin
            InstPhysicalAddrReg<= `ZeorDate ;
            InstTlbTrapTypeReg <= 7'd0 ;
            InstTlbTrapAbleReg <= `EnableValue ;
            InstMatType        <= 2'd0 ;
        end
        else if(MmuFlash) begin
            InstPhysicalAddrReg<= `ZeorDate ;
            InstTlbTrapTypeReg <= 7'd0 ;
            InstTlbTrapAbleReg <= `EnableValue ;
            InstMatType        <= 2'd0 ;
        end
        else if(InstFetch) begin
            InstPhysicalAddrReg <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? InstVritualA : 
                                   ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw0Able) ? Dmw0Physicaladdr : 
                                   ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw1Able) ? Dmw1Physicaladdr :
                                   (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? MmuPhysicalAddr : `ZeorDate ;
            {InstTlbTrapAbleReg, InstTlbTrapTypeReg} <= ~PortInstFund ? {`AbleValue, `TLBR} : 
                                                        ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw0Able) ? {~((CsrDmw0Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw0Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                        ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw1Able) ? {~((CsrDmw1Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw1Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                        (~CsrCrmdDate[3] && CsrCrmdDate[4])  ? (PortInstV ?  {~(PortInstPlv == CsrCrmdDate[1:0]), `PPI} : {`AbleValue, `PIF}) : {`EnableValue, 7'd0};
            InstMatType  <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? CsrCrmdDate[6:5] :
                            ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw0Able) ? CsrDmw0Date[5:4] :
                            ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && DriectDmw1Able) ? CsrDmw1Date[5:4] :
                            (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? PortInstMat : 2'b01 ;
        end         
    end 

    assign InstPhysicalAddr = InstPhysicalAddrReg ;
    assign InstTlbTrapType  = InstTlbTrapTypeReg  ;
    assign InstTlbTrap      = InstTlbTrapAbleReg  ;
    assign InstOperType     = InstMatType ;


    wire                 MDriectDmw0Able   = (MemVritualA[31:29] == CsrDmw0Date[31:29]);
    // wire  [1:0]          MDriectDmw0Plv    = {CsrDmw0Date[3],CsrDmw0Date[0]} ;
    // wire  [1:0]          MDriectDmw0Mat    = CsrDmw0Date[5:4] ;
    wire  [`InstAddrBus] MDmw0Physicaladdr = {CsrDmw1Date[27:25],MemVritualA[28:0]} ;
    wire                 MDriectDmw1Able   = (MemVritualA[31:29] == CsrDmw1Date[31:29]);
    // wire  [1:0]          MDriectDmw1Plv    = {CsrDmw1Date[3],CsrDmw1Date[0]} ;
    // wire  [1:0]          MDriectDmw1Mat    = CsrDmw1Date[5:4] ;
    wire  [`InstAddrBus] MDmw1Physicaladdr = {CsrDmw1Date[27:25],MemVritualA[28:0]} ;


    wire  [18:0]   PortMemVppn = MemVritualA[31:13] ;
    wire           PortMemOdd  = ~MemVritualA[12]   ;
    wire  [19:0]   PortMemPpn ;
    wire           PortMemFound;
    wire           PortMemV   ;
    wire           PortMemD   ;
    wire  [1:0]    PortMemMat ;
    wire  [1:0]    PortMemPlv ;
    wire  [5:0]    PortMemPs  ;
    wire  [`InstAddrBus] MmuPhysicalAddr2 = {PortMemPpn, MemVritualA[11:0]} ;

    reg                  MemTlbTrapReg ;
    reg   [6:0]          MemTlbTrapTypeReg ;
    reg   [`InstAddrBus] MemPhysicalAddrReg;
    reg   [1:0]          MemMatType    ;    
    always @(posedge Clk) begin
        if(!Rest) begin
            MemTlbTrapReg <= 1'b0 ;
            MemTlbTrapTypeReg <= 7'd0 ;
            MemPhysicalAddrReg <= `ZeorDate ;
            MemMatType <= 2'b0 ;
        end
        else if(MmuFlash) begin
            MemTlbTrapReg <= 1'b0 ;
            MemTlbTrapTypeReg <= 7'd0 ;
            MemPhysicalAddrReg <= `ZeorDate ;
            MemMatType <= 2'b0 ;
        end
        else if(MemAccess) begin
            MemPhysicalAddrReg <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? MemVritualA : 
                                  ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && MDriectDmw0Able) ? MDmw0Physicaladdr :
                                  ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && MDriectDmw1Able) ? MDmw1Physicaladdr :
                                  (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? MmuPhysicalAddr2 : `ZeorDate ;
            {MemTlbTrapReg,MemTlbTrapTypeReg} <= ~PortMemFound ? {`AbleValue, `TLBR} :
                                                 ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && MDriectDmw0Able) ? {~((CsrDmw0Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw0Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                 ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && MDriectDmw1Able) ? {~((CsrDmw1Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw1Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                 (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? (~PortMemV ? (LoadOrStore ? {`AbleValue,`PIS} : {`AbleValue,`PIL}):((PortMemPlv == CsrCrmdDate[1:0])?{PortMemD,`PME}:{`AbleValue,`PPI})):{`EnableValue,7'd0};
            MemMatType <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? CsrCrmdDate[8:7] : 
                          ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && MDriectDmw0Able) ? CsrDmw0Date[5:4] :
                          ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && MDriectDmw1Able) ? CsrDmw1Date[5:4] :
                          (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? PortMemMat : 2'b01 ;
        end
    end

    assign MemOperType = MemMatType ;
    assign MemTlbTrap  = MemTlbTrapReg ;
    assign MemTlbTrapType = MemTlbTrapTypeReg ;
    assign MemPhysicalAddr = MemPhysicalAddrReg ;

    wire               SerchAble ;
    wire  [5:0]        SerchIndex;

    reg               SerchAbleReg ;
    reg  [5:0]        SerchIndexReg;
    always @(posedge Clk) begin
        if(!Rest) begin
            SerchAbleReg <= `EnableValue ;
            SerchIndexReg <= 6'd0 ;
        end
        else if(MmuFlash) begin
            SerchAbleReg <= `EnableValue ;
            SerchIndexReg <= 6'd0 ;
        end
        else if(CsrSerchTlbAble) begin
            SerchAbleReg <=  SerchAble ;
            SerchIndexReg <= SerchIndex;
        end
    end 

    assign CsrSerchIdxDate = SerchIndexReg ;
    assign CsrSerchAble = SerchAbleReg ;

    wire [18:0] WriteVppn = CsrWriteTlbDate[88:70];
    wire        WriteE    = CsrWriteTlbDate[69] ;
    wire [9:0]  WriteAsid = CsrWriteTlbDate[68:59];
    wire        WriteG    = CsrWriteTlbDate[58] ;
    wire [5:0]  WritePs   = CsrWriteTlbDate[57:52];
    wire [19:0] WritePpn0 = CsrWriteTlbDate[51:32];
    wire [1:0]  WritePlv0 = CsrWriteTlbDate[31:30];
    wire [1:0]  WriteMat0 = CsrWriteTlbDate[29:28];
    wire        WriteV0   = CsrWriteTlbDate[27];
    wire        WriteD0   = CsrWriteTlbDate[26];
    wire [19:0] WritePpn1 = CsrWriteTlbDate[25:6];
    wire [1:0]  WritePlv1 = CsrWriteTlbDate[5:4];
    wire [1:0]  WriteMat1 = CsrWriteTlbDate[3:2];
    wire        WriteV1   = CsrWriteTlbDate[1];
    wire        WriteD1   = CsrWriteTlbDate[0];


    TlbEntry#(
        .TLBNUM     ( 64 )
    )u_TlbEntry(
        .Clk        ( Clk              ),
        .Rest       ( Rest             ),
        .S0Vppn     ( PortInstVppn     ),
        .S0OddPage  ( PortInstOdd      ),
        .S0Asid     ( Asid             ),
        .S0Fund     ( PortInstFund     ),
        //.S0Index    ( S0Index    ),
        .S0Ps       ( PortInstPs       ),
        .S0Ppn      ( PortInstPpn      ),
        .S0V        ( PortInstV        ),
        .S0D        ( PortInstD        ),
        .S0Mat      ( PortInstMat      ),
        .S0Plv      ( PortInstPlv      ),
        .S1Vppn     ( PortMemVppn      ),
        .S1OddPage  ( PortMemOdd       ),
        .S1Asid     ( Asid             ),
        .S1Fund     ( PortMemFound     ),
        //.S1Index    ( S1Index    ),
        .S1Ps       ( PortMemPs        ),
        .S1Ppn      ( PortMemPpn       ),
        .S1V        ( PortMemV         ),
        .S1D        ( PortMemD         ),
        .S1Mat      ( PortMemMat       ),
        .S1Plv      ( PortMemPlv       ),
        .CsrSerchInfrom (CsrSerchInfrom),
        .CsrSerchSucces (SerchAble     ),
        .csrSerchDate   (SerchIndex    ),
        .We         ( CsrWriteTlbAble  ),
        .WIndex     ( CsrWriteTlbAddr  ),
        .WVppn      ( WriteVppn        ),
        .WAsid      ( WriteAsid        ),
        .WG         ( WriteG           ),
        .WPs        ( WritePs          ),
        .WE         ( WriteE           ),
        .WV0        ( WriteV0          ),
        .WD0        ( WriteD0          ),
        .WMat0      ( WriteMat0        ),
        .WPlv0      ( WritePlv0        ),
        .WPpn0      ( WritePpn0        ),
        .WV1        ( WriteV1          ),
        .WD1        ( WriteD1          ),
        .WMat1      ( WriteMat1        ),
        .WPlv1      ( WritePlv1        ),
        .WPpn1      ( WritePpn1        ),
        .RIndex     ( CsrReadTlbAddr   ),
        .RVppn      ( MmuReadVppn      ),
        .RAsid      ( MmuReadAsid      ),
        .RG         ( MmuReadG         ),
        .RPs        ( MmuReadPs        ),
        .RE         ( MmuReadE         ),
        .RV0        ( MmuReadV0        ),
        .RD0        ( MmuReadD0        ),
        .RMat0      ( MmuReadMat0      ),
        .RPlv0      ( MmuReadPlv0      ),
        .RPpn0      ( MmuReadPpn0      ),
        .RV1        ( MmuReadV1        ),
        .RD1        ( MmuReadD1        ),
        .RMat1      ( MmuReadMat1      ),
        .RPlv1      ( MmuReadPlv1      ),
        .RPpn1      ( MmuReadPpn1      ),
        .InvEn      ( CsrInvEn|MmuFlash),
        .InvOp      ( CsrInvOp|5'b0    ),
        .InvAsid    ( CsrInvAsid       ),
        .InvVppn    ( CsrInvVppn       )
    );

    





    
endmodule 
 