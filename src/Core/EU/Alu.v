`timescale 1ps/1ps
`include "../define.v"

module Alu (
    input         wire                              Clk            ,
    input         wire                              Rest           ,
    //from ctrl 
    input         wire                              AluStop        ,
    input         wire                              AluFlash       ,
    //from issuequeueint 
    input         wire   [`InstAddrBus]             AluInstPc      ,
    input         wire   [`MicOperateCode]          AluMicOperate  ,
    input         wire                              AluSrc1Able    ,
    input         wire   [`ReNameRegBUs]            AluSrc1Addr    ,
    input         wire   [`DataBus]                 AluSrc1Date    ,
    input         wire                              AluSrc2Able    , //对于跳转指令的rd会被解码为src2
    input         wire   [`ReNameRegBUs]            AluSrc2Addr    ,
    input         wire   [`DataBus]                 AluSrc2Date    ,
    input         wire   [19:0]                     AluImmDate     ,
    input         wire                              AluRdAble      ,
    input         wire   [`ReNameRegBUs]            AluRdAddr      ,
    input         wire   [5:0]                      AluROBPtr      , 
    //from  bypass
    input         wire                              AluSelfAble    ,
    input         wire   [`ReNameRegBUs]            AluSelfAddr    ,
    input         wire   [`DataBus]                 AluSelfDate    ,
    input         wire                              AluBruAble     ,
    input         wire   [`ReNameRegBUs]            AluBruAddr     ,
    input         wire   [`DataBus]                 AluBruDate     ,
    input         wire                              AluAlu2Able    ,
    input         wire   [`ReNameRegBUs]            AluAlu2Addr    ,
    input         wire   [`DataBus]                 AluAlu2Date    ,
    input         wire                              AluMulAble     ,
    input         wire   [`ReNameRegBUs]            AluMulAddr     ,
    input         wire   [`DataBus]                 AluMulDate     , 
    input         wire                              AluCsrAble     ,
    input         wire   [`ReNameRegBUs]            AluCsrAddr     ,
    input         wire   [`DataBus]                 AluCsrDate     , 
    //to iqint 
    output        wire                              AluReq         ,
    //to physical 
    output        wire                              AluWBAble      ,
    output        wire   [`ReNameRegBUs]            AluWBAddr      ,
    output        wire   [`DataBus]                 AluWBDate      ,
    //to ROB
    output        wire                              AluCommitAble  ,
    output        wire   [5:0]                      AluCommitPtr   ,
    output        wire   [1:0]                      AluCommitType 

);

    reg             StopTemp     ;
    //reg             FLashTemp    ;

    always @(posedge Clk) begin
        if(!Rest) begin
            StopTemp  <= 1'b0 ;
            //FLashTemp <= 1'b0 ;
        end
        else begin
            StopTemp  <= AluStop  ;
            //FLashTemp <= AluFlash ;
        end
    end

    assign AluReq = ~StopTemp ;

    wire  [`DataBus] ASrc1Date   =  ((AluSrc1Addr == AluSelfAddr) & AluSelfAble & AluSrc1Able) ? AluSelfDate :
                                    ((AluSrc1Addr == AluBruAddr ) & AluBruAble  & AluSrc1Able) ? AluBruDate  :
                                    ((AluSrc1Addr == AluAlu2Addr) & AluAlu2Able & AluSrc1Able) ? AluAlu2Date :
                                    ((AluSrc1Addr == AluMulAddr ) & AluMulAble  & AluSrc1Able) ? AluMulDate  :
                                    ((AluSrc1Addr == AluCsrAddr ) & AluCsrAble  & AluSrc1Able) ? AluCsrDate  : AluSrc1Date ;
    
    wire  [`DataBus] ASrc2Date   =  ((AluSrc2Addr == AluSelfAddr) & AluSelfAble & AluSrc2Able) ? AluSelfDate :
                                    ((AluSrc2Addr == AluBruAddr ) & AluBruAble  & AluSrc2Able) ? AluBruDate  :
                                    ((AluSrc2Addr == AluAlu2Addr) & AluAlu2Able & AluSrc2Able) ? AluAlu2Date :
                                    ((AluSrc2Addr == AluMulAddr ) & AluMulAble  & AluSrc2Able) ? AluMulDate  :
                                    ((AluSrc2Addr == AluCsrAddr ) & AluCsrAble  & AluSrc2Able) ? AluCsrDate  : AluSrc2Date ;

    localparam REDIRNO     = 2'b00;

    reg                     RegAluWBAble      ;
    reg   [`ReNameRegBUs]   RegAluWBAddr      ;
    reg   [`DataBus]        RegAluWBDate      ;
    reg                     RegAluCommitAble  ;
    reg   [5:0]             RegAluCommitPtr   ;
    reg   [1:0]             RegAluCommitType  ;
    
    always @(posedge Clk) begin
        if(!Rest) begin
            RegAluWBAble <= `EnableValue ;
            RegAluWBAddr <= 7'b0         ;
            RegAluWBDate <= 32'd0        ;
            RegAluCommitAble <= `EnableValue ;
            RegAluCommitPtr <= 6'd0      ;
            RegAluCommitType <= REDIRNO  ;
        end
        else if(AluFlash) begin
            RegAluWBAble <= `EnableValue ;
            RegAluWBAddr <= 7'b0         ;
            RegAluWBDate <= 32'd0        ;
            RegAluCommitAble <= `EnableValue ;
            RegAluCommitPtr <= 6'd0      ;
            RegAluCommitType <= REDIRNO  ;
        end
        else if(StopTemp) begin
            RegAluWBAble <= RegAluWBAble        ;
            RegAluWBAddr <= RegAluWBAddr        ;
            RegAluWBDate <= RegAluWBDate        ;
            RegAluCommitAble <= RegAluCommitAble;
            RegAluCommitPtr <= RegAluCommitPtr  ;
            RegAluCommitType <= RegAluCommitType;
        end
        else begin
            RegAluWBAble <= AluRdAble ;
            RegAluWBAddr <= AluRdAddr ;
            RegAluCommitPtr <= AluROBPtr ;
            RegAluCommitType <= REDIRNO ;
            case (AluMicOperate)                     
                `InstAddw    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date + ASrc2Date ;                                                  end 
                `InstSubw    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date - ASrc2Date ;                                                  end 
                `InstAddiw   :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date + {{20{AluImmDate[11]}}, AluImmDate[11:0]};                   end 
                `InstLu12iw  :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= {AluImmDate[19:0],12'd0};                                              end 
                `InstSlt     :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ($signed(ASrc1Date) < $signed(ASrc2Date)) ? {31'd0,1'b1} : `ZeorDate ;  end
                `InstSltu    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= (ASrc1Date < ASrc2Date) ? {31'd0,1'b1} : `ZeorDate ;                    end    
                `InstSlti    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ($signed(ASrc1Date) < {{20{AluImmDate[11]}},AluImmDate[11:0]}) ? {31'd0,1'b1} : `ZeorDate ;end 
                `InstSltui   :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= (ASrc1Date < {{20{1'b0}},AluImmDate[11:0]}) ? {31'd0,1'b1} : `ZeorDate;end 
                `InstAddu12i :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= AluInstPc + {AluImmDate[19:0],12'b0};                                  end 
                `InstAnd     :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date & ASrc2Date ;                                                  end 
                `InstOr      :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date | ASrc2Date ;                                                  end
                `InstNor     :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ~(ASrc1Date | ASrc2Date) ;                                               end  
                `InstXor     :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date ^ ASrc2Date ;                                                  end  
                `InstAndi    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date & {{20{1'b0}}, AluImmDate[11:0]};                             end
                `InstOri     :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date | {{20{1'b0}}, AluImmDate[11:0]};                             end   
                `InstXori    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date ^ {{20{1'b0}}, AluImmDate[11:0]};                             end 
                `InstSllw    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date << ASrc2Date[4:0]      ;                                       end  
                `InstSrlw    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date >> ASrc2Date[4:0]      ;                                       end       
                `InstSraw    :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date >>> ASrc2Date[4:0]     ;                                       end  
                `InstSlliw   :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date << AluImmDate[4:0]    ;                                       end   
                `InstSrliw   :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date >> AluImmDate[4:0]    ;                                       end 
                `InstSraiw   :  begin   RegAluCommitAble <= `AbleValue ;  RegAluWBDate <= ASrc1Date >>> AluImmDate[4:0]   ;                                       end     
                //`InstRdcntvlw:  begin   
                default: begin   RegAluCommitAble <= `EnableValue ;  RegAluWBDate <= `ZeorDate   ;   end 
            endcase
        end
    end
    
    assign AluWBAble  = RegAluWBAble  ;
    assign AluWBAddr  = RegAluWBAddr  ;
    assign AluWBDate  = RegAluWBDate  ;
    assign AluCommitAble = RegAluCommitAble ;
    assign AluCommitPtr  = RegAluCommitPtr  ;
    assign AluCommitType = RegAluCommitType ;

endmodule
