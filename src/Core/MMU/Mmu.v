`timescale 1ps/1ps
`include "../define.v"

module Mmu (
    input       wire                                     Clk           ,
    input       wire                                     Rest          ,

    input       wire                                     MmuFlash      ,
    input       wire                                     MmuStop       ,
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
    //from load
    input       wire                                     LoadAccess      ,
    //input       wire                                     LoadOrStore    , //1store 0load
    input       wire      [31:0]                         LoadVritualA    ,
    output      wire      [1:0]                          LoadOperType    ,
    output      wire                                     LoadTlbTrap     ,
    output      wire      [6:0]                          LoadTlbTrapType ,
    output      wire      [`InstAddrBus]                 LoadPhysicalAddr,
    //for store
    input       wire                                     StoreAccess      ,
    //input       wire                                     LoadOrStore    , //1store 0load
    input       wire      [31:0]                         StoreVritualA    ,
    output      wire      [1:0]                          StoreOperType    ,
    output      wire                                     StoreTlbTrap     ,
    output      wire      [6:0]                          StoreTlbTrapType ,
    output      wire      [`InstAddrBus]                 StorePhysicalAddr
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
        else if(MmuStop) begin
            InstPhysicalAddrReg<= InstPhysicalAddrReg ;
            InstTlbTrapTypeReg <= InstTlbTrapTypeReg ;
            InstTlbTrapAbleReg <= InstTlbTrapAbleReg ;
            InstMatType        <= InstMatType ;
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

    //for load 
    wire                 LDriectDmw0Able   = (LoadVritualA[31:29] == CsrDmw0Date[31:29]);
    // wire  [1:0]          MDriectDmw0Plv    = {CsrDmw0Date[3],CsrDmw0Date[0]} ;
    // wire  [1:0]          MDriectDmw0Mat    = CsrDmw0Date[5:4] ;
    wire  [`InstAddrBus] LDmw0Physicaladdr = {CsrDmw1Date[27:25],LoadVritualA[28:0]} ;
    wire                 LDriectDmw1Able   = (LoadVritualA[31:29] == CsrDmw1Date[31:29]);
    // wire  [1:0]          MDriectDmw1Plv    = {CsrDmw1Date[3],CsrDmw1Date[0]} ;
    // wire  [1:0]          MDriectDmw1Mat    = CsrDmw1Date[5:4] ;
    wire  [`InstAddrBus] LDmw1Physicaladdr = {CsrDmw1Date[27:25],LoadVritualA[28:0]} ;


    wire  [18:0]   PortLoadVppn = LoadVritualA[31:13] ;
    wire           PortLoadOdd  = ~LoadVritualA[12]   ;
    wire  [19:0]   PortLoadPpn ;
    wire           PortLoadFound;
    wire           PortLoadV   ;
    wire           PortLoadD   ;
    wire  [1:0]    PortLoadMat ;
    wire  [1:0]    PortLoadPlv ;
    wire  [5:0]    PortLoadPs  ;
    wire  [`InstAddrBus] MmuPhysicalAddr2 = {PortLoadPpn, LoadVritualA[11:0]} ;

    reg                  LoadTlbTrapReg ;
    reg   [6:0]          LoadTlbTrapTypeReg ;
    reg   [`InstAddrBus] LoadPhysicalAddrReg;
    reg   [1:0]          LoadMatType    ;    
    always @(posedge Clk) begin
        if(!Rest) begin
            LoadTlbTrapReg <= 1'b0 ;
            LoadTlbTrapTypeReg <= 7'd0 ;
            LoadPhysicalAddrReg <= `ZeorDate ;
            LoadMatType <= 2'b0 ;
        end
        else if(MmuFlash) begin
            LoadTlbTrapReg <= 1'b0 ;
            LoadTlbTrapTypeReg <= 7'd0 ;
            LoadPhysicalAddrReg <= `ZeorDate ;
            LoadMatType <= 2'b0 ;
        end
        else if(MmuStop) begin
            LoadTlbTrapReg <= LoadTlbTrapReg ;
            LoadTlbTrapTypeReg <= LoadTlbTrapTypeReg ;
            LoadPhysicalAddrReg <= LoadPhysicalAddrReg ;
            LoadMatType <= LoadMatType ;
        end
        else if(LoadAccess) begin
            LoadPhysicalAddrReg <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? LoadVritualA : 
                                  ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw0Able) ? LDmw0Physicaladdr :
                                  ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw1Able) ? LDmw1Physicaladdr :
                                  (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? MmuPhysicalAddr2 : `ZeorDate ;
            {LoadTlbTrapReg,LoadTlbTrapTypeReg} <= ~PortLoadFound ? {`AbleValue, `TLBR} :
                                                 ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw0Able) ? {~((CsrDmw0Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw0Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                 ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw1Able) ? {~((CsrDmw1Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw1Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                 (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? (~PortLoadV ? {`AbleValue,`PIL}:((PortLoadPlv == CsrCrmdDate[1:0])?{PortLoadD,`PME}:{`AbleValue,`PPI})):{`EnableValue,7'd0};
            LoadMatType <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? CsrCrmdDate[8:7] : 
                          ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw0Able) ? CsrDmw0Date[5:4] :
                          ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && LDriectDmw1Able) ? CsrDmw1Date[5:4] :
                          (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? PortLoadMat : 2'b01 ;
        end
    end

    assign LoadOperType = LoadMatType ;
    assign LoadTlbTrap  = LoadTlbTrapReg ;
    assign LoadTlbTrapType = LoadTlbTrapTypeReg ;
    assign LoadPhysicalAddr = LoadPhysicalAddrReg ;


//for store 
    wire                 SDriectDmw0Able   = (StoreVritualA[31:29] == CsrDmw0Date[31:29]);
    // wire  [1:0]          MDriectDmw0Plv    = {CsrDmw0Date[3],CsrDmw0Date[0]} ;
    // wire  [1:0]          MDriectDmw0Mat    = CsrDmw0Date[5:4] ;
    wire  [`InstAddrBus] SDmw0Physicaladdr = {CsrDmw1Date[27:25],StoreVritualA[28:0]} ;
    wire                 SDriectDmw1Able   = (StoreVritualA[31:29] == CsrDmw1Date[31:29]);
    // wire  [1:0]          MDriectDmw1Plv    = {CsrDmw1Date[3],CsrDmw1Date[0]} ;
    // wire  [1:0]          MDriectDmw1Mat    = CsrDmw1Date[5:4] ;
    wire  [`InstAddrBus] SDmw1Physicaladdr = {CsrDmw1Date[27:25],StoreVritualA[28:0]} ;


    wire  [18:0]   PortStoreVppn = LoadVritualA[31:13] ;
    wire           PortStoreOdd  = ~LoadVritualA[12]   ;
    wire  [19:0]   PortStorePpn ;
    wire           PortStoreFound;
    wire           PortStoreV   ;
    wire           PortStoreD   ;
    wire  [1:0]    PortStoreMat ;
    wire  [1:0]    PortStorePlv ;
    wire  [5:0]    PortStorePs  ;
    wire  [`InstAddrBus] MmuPhysicalAddr3 = {PortStorePpn, StoreVritualA[11:0]} ;

    reg                  StoreTlbTrapReg ;
    reg   [6:0]          StoreTlbTrapTypeReg ;
    reg   [`InstAddrBus] StorePhysicalAddrReg;
    reg   [1:0]          StoreMatType    ;    
    always @(posedge Clk) begin
        if(!Rest) begin
            StoreTlbTrapReg <= 1'b0 ;
            StoreTlbTrapTypeReg <= 7'd0 ;
            StorePhysicalAddrReg <= `ZeorDate ;
            StoreMatType <= 2'b0 ;
        end
        else if(MmuFlash) begin
            StoreTlbTrapReg <= 1'b0 ;
            StoreTlbTrapTypeReg <= 7'd0 ;
            StorePhysicalAddrReg <= `ZeorDate ;
            StoreMatType <= 2'b0 ;
        end
        else if(MmuStop) begin
            StoreTlbTrapReg <= StoreTlbTrapReg ;
            StoreTlbTrapTypeReg <= StoreTlbTrapTypeReg ;
            StorePhysicalAddrReg <= StorePhysicalAddrReg ;
            StoreMatType <= StoreMatType ;
        end
        else if(StoreAccess) begin
            StorePhysicalAddrReg <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? StoreVritualA : 
                                  ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw0Able) ? SDmw0Physicaladdr :
                                  ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw1Able) ? SDmw1Physicaladdr :
                                  (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? MmuPhysicalAddr3 : `ZeorDate ;
            {StoreTlbTrapReg,StoreTlbTrapTypeReg} <= ~PortStoreFound ? {`AbleValue, `TLBR} :
                                                 ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw0Able) ? {~((CsrDmw0Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw0Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                 ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw1Able) ? {~((CsrDmw1Date[0] & (CsrCrmdDate[1:0] == 0)) || ~(CsrDmw1Date[3] & (CsrCrmdDate[1:0] == 3))), `PPI}:
                                                 (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? (~PortStoreV ? {`AbleValue,`PIL}:((PortStorePlv == CsrCrmdDate[1:0])?{PortStoreD,`PME}:{`AbleValue,`PPI})):{`EnableValue,7'd0};
            StoreMatType <= (CsrCrmdDate[3] && ~CsrCrmdDate[4]) ? CsrCrmdDate[8:7] : 
                          ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw0Able) ? CsrDmw0Date[5:4] :
                          ((~CsrCrmdDate[3] && CsrCrmdDate[4]) && SDriectDmw1Able) ? CsrDmw1Date[5:4] :
                          (~CsrCrmdDate[3] && CsrCrmdDate[4]) ? PortStoreMat : 2'b01 ;
        end
    end
    
    assign StoreOperType = StoreMatType ;
    assign StoreTlbTrap  = StoreTlbTrapReg ;
    assign StoreTlbTrapType = StoreTlbTrapTypeReg ;
    assign StorePhysicalAddr = StorePhysicalAddrReg ;


    wire               SerchAble ;
    wire  [5:0]        SerchIndex;

    reg               SerchAbleReg ;
    reg   [5:0]       SerchIndexReg;
    always @(posedge Clk) begin
        if(!Rest) begin
            SerchAbleReg <= `EnableValue ;
            SerchIndexReg <= 6'd0 ;
        end
        else if(MmuFlash) begin
            SerchAbleReg <= `EnableValue ;
            SerchIndexReg <= 6'd0 ;
        end
        else if(MmuStop) begin
            SerchAbleReg <= SerchAbleReg ;
            SerchIndexReg <= SerchIndexReg ;
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
        .S1Vppn     ( PortLoadVppn     ),
        .S1OddPage  ( PortLoadOdd      ),
        .S1Asid     ( Asid             ),
        .S1Fund     ( PortLoadFound    ),
        //.S1Index    ( S1Index    ),
        .S1Ps       ( PortLoadPs        ),
        .S1Ppn      ( PortLoadPpn       ),
        .S1V        ( PortLoadV         ),
        .S1D        ( PortLoadD         ),
        .S1Mat      ( PortLoadMat       ),
        .S1Plv      ( PortLoadPlv       ),
        .S2Vppn     ( PortStoreVppn     ),
        .S2OddPage  ( PortStoreOdd      ),
        .S2Asid     ( Asid              ),
        .S2Fund     ( PortStoreFound    ),
        //.S2Index    ( S1Index    ),
        .S2Ps       ( PortStorePs        ),
        .S2Ppn      ( PortStorePpn       ),
        .S2V        ( PortStoreV         ),
        .S2D        ( PortStoreD         ),
        .S2Mat      ( PortStoreMat       ),
        .S2Plv      ( PortStorePlv       ),
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
 