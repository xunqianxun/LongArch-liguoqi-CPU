`timescale 1ps/1ps
`include "../define.v" 

module AGUStore (
    input      wire                               Clk             ,
    input      wire                               Rest            ,

    input      wire                               AGUStoreStop    ,
    input      wire                               AGUStoreFlash   ,

    input      wire                               StoreInstAble   ,
    input      wire      [`MicOperateCode]        StoreMicOPercode,
    input      wire                               StoreRegAble0   ,
    input      wire      [`ReNameRegBUs]          StoreRegAddr0   ,
    input      wire      [`DataBus]               StoreRegDate0   ,
    input      wire                               StoreRegAble1   ,
    input      wire      [`ReNameRegBUs]          StoreRegAddr1   ,
    input      wire      [`DataBus]               StoreRegDate1   ,  
    input      wire      [11:0]                   StoreImmDate    ,
    input      wire                               StoreWbAble     ,
    input      wire      [`ReNameRegBUs]          StoreWbAddr     ,
    input      wire      [5:0]                    StoreInstRobPtr ,

    input      wire                               StoreBruAble    ,
    input      wire      [`ReNameRegBUs]          StoreBruAddr    ,
    input      wire      [`DataBus]               StoreBruDate    ,
    input      wire                               StoreAlu2Able   ,
    input      wire      [`ReNameRegBUs]          StoreAlu2Addr   ,
    input      wire      [`DataBus]               StoreAlu2Date   ,
    input      wire                               StoreAlu1Able   ,
    input      wire      [`ReNameRegBUs]          StoreAlu1Addr   ,
    input      wire      [`DataBus]               StoreAlu1Date   ,
    input      wire                               StoreMluAble    ,
    input      wire      [`ReNameRegBUs]          StoreMluAddr    ,
    input      wire      [`DataBus]               StoreMluDate    , 
    input      wire                               StoreCsrAble    ,
    input      wire      [`ReNameRegBUs]          StoreCsrAddr    ,
    input      wire      [`DataBus]               StoreCsrDate    ,
    //for mmu 
    output     wire                               ToSAccess       ,
    output     wire      [31:0]                   ToSVritualA     ,
    input      wire      [1:0]                    ToSOperType     ,
    input      wire                               ToSTlbTrap      ,
    input      wire      [6:0]                    ToSTlbTrapType  ,
    input      wire      [`InstAddrBus]           ToSPhysicalAddr ,                              
    //to load buffer
    output     wire                               ToSBAble       ,
    output     wire      [`MicOperateCode]        ToSBMicOp      ,
    output     wire      [`DataBus]               ToSBWDate      ,
    output     wire      [1:0]                    ToSBMAT        ,   
    output     wire      [`InstAddrBus]           ToSBPAddr      ,
    output     wire                               ToSBTrap       ,
    output     wire      [6:0]                    ToSBTrapCode   ,
    output     wire                               ToSBWbAble     ,
    output     wire      [`ReNameRegBUs]          ToSBWbAddr     ,
    output     wire      [5:0]                    ToSBRobPtr                            
);


    wire  [`DataBus] STSrc1Date   =  ((StoreRegAddr0 == StoreBruAddr ) & StoreBruAble  & StoreRegAble0) ? StoreBruDate :
                                     ((StoreRegAddr0 == StoreAlu1Addr) & StoreAlu1Able & StoreRegAble0) ? StoreAlu1Date:
                                     ((StoreRegAddr0 == StoreAlu2Addr) & StoreAlu2Able & StoreRegAble0) ? StoreAlu2Date:
                                     ((StoreRegAddr0 == StoreMluAddr ) & StoreMluAble  & StoreRegAble0) ? StoreMluDate :
                                     ((StoreRegAddr0 == StoreCsrAddr ) & StoreCsrAble  & StoreRegAble0) ? StoreCsrDate : StoreRegDate0 ;
     
    wire  [`DataBus] STSrc2Date   =  ((StoreRegAddr1 == StoreBruAddr ) & StoreBruAble  & StoreRegAble1) ? StoreBruDate :
                                     ((StoreRegAddr1 == StoreAlu1Addr) & StoreAlu1Able & StoreRegAble1) ? StoreAlu1Date:
                                     ((StoreRegAddr1 == StoreAlu2Addr) & StoreAlu2Able & StoreRegAble1) ? StoreAlu2Date:
                                     ((StoreRegAddr1 == StoreMluAddr ) & StoreMluAble  & StoreRegAble1) ? StoreMluDate :
                                     ((StoreRegAddr1 == StoreCsrAddr ) & StoreCsrAble  & StoreRegAble1) ? StoreCsrDate : StoreRegDate1 ;

    assign ToSAccess   = StoreInstAble ;
    assign ToSVritualA = STSrc1Date + {{20{StoreImmDate[11]}},StoreImmDate} ;

    reg                   ToSBAbleTemp    ;
    reg [`MicOperateCode] ToSBMicOpTemp   ;
    reg [`DataBus]        ToSBWDateTemp   ;
    reg                   ToSBWbAbleTemp  ;
    reg [`ReNameRegBUs]   ToSBWbAddrTemp  ;
    reg [5:0]             ToSBRobPtrTemp  ;
    always @(posedge Clk) begin
        if(!Rest) begin
            ToSBAbleTemp    <= 1'b0  ;
            ToSBMicOpTemp   <= 8'b0  ;
            ToSBWDateTemp   <= 32'b0 ;
            ToSBWbAbleTemp  <= 1'b0  ;
            ToSBWbAddrTemp  <= 7'b0  ;
            ToSBRobPtrTemp  <= 6'b0  ; 
        end
        else if(AGUStoreStop) begin
            ToSBAbleTemp    <= ToSBAbleTemp   ;
            ToSBMicOpTemp   <= ToSBMicOpTemp  ;
            ToSBWDateTemp   <= ToSBWDateTemp  ;
            ToSBWbAbleTemp  <= ToSBWbAbleTemp ;
            ToSBWbAddrTemp  <= ToSBWbAddrTemp ;
            ToSBRobPtrTemp  <= ToSBRobPtrTemp ; 
        end
        else if(AGUStoreFlash)begin
            ToSBAbleTemp    <= 1'b0  ;
            ToSBMicOpTemp   <= 8'b0  ;
            ToSBWDateTemp   <= 32'b0 ;
            ToSBWbAbleTemp  <= 1'b0  ;
            ToSBWbAddrTemp  <= 7'b0  ;
            ToSBRobPtrTemp  <= 6'b0  ;
        end
        else begin
            ToSBAbleTemp    <= StoreInstAble     ;
            ToSBMicOpTemp   <= StoreMicOPercode  ;
            ToSBWDateTemp   <= STSrc2Date       ;
            ToSBWbAbleTemp  <= StoreWbAble       ;
            ToSBWbAddrTemp  <= StoreWbAddr       ;
            ToSBRobPtrTemp  <= StoreInstRobPtr   ;
        end
    end
    

    assign ToSBAble    = ToSBAbleTemp    ;
    assign ToSBMicOp   = ToSBMicOpTemp   ;
    assign ToSBWDate   = ToSBWDateTemp   ;
    assign ToSBMAT     = ToSOperType     ;
    assign ToSBPAddr   = ToSPhysicalAddr ;
    assign ToSBTrap    = ToSTlbTrap      ;
    assign ToSBTrapCode= ToSTlbTrapType  ;
    assign ToSBWbAble  = ToSBWbAbleTemp  ;
    assign ToSBWbAddr  = ToSBWbAddrTemp  ;
    assign ToSBRobPtr  = ToSBRobPtrTemp  ;

        
endmodule
