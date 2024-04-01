`timescale 1ps/1ps
`include "../define.v"

module Decode (
    input     wire                             Clk           ,
    input     wire                             Rest          ,
    //for ctrl
    input     wire                             DecodeStop    ,
    input     wire                             DecodeFlash   ,
    output    wire                             DecodeReq     ,
    //from InsrQueue
    input     wire                             InInstPort1  ,
    input     wire                             InInstPort2  ,
    input     wire                             InInstPort3  ,
    input     wire                             InInstPort4  ,
    input     wire      [`InstAddrBus]         InInstAddr1   ,
    input     wire      [`InstDateBus]         InInstDate1   ,
    input     wire                             InInstPart1   ,
    input     wire      [`InstAddrBus]         InInstNAdr1   ,
    input     wire      [`InstAddrBus]         InInstAddr2   ,
    input     wire      [`InstDateBus]         InInstDate2   ,
    input     wire                             InInstPart2   ,
    input     wire      [`InstAddrBus]         InInstNAdr2   ,
    input     wire      [`InstAddrBus]         InInstAddr3   ,
    input     wire      [`InstDateBus]         InInstDate3   ,
    input     wire                             InInstPart3   ,
    input     wire      [`InstAddrBus]         InInstNAdr3   ,
    input     wire      [`InstAddrBus]         InInstAddr4   ,
    input     wire      [`InstDateBus]         InInstDate4   ,
    input     wire                             InInstPart4   ,
    input     wire      [`InstAddrBus]         InInstNAdr4   ,
    input     wire                             QueueEmpty    ,
    //to  distpatch 
    output    wire      [`MicOperateCode]      Inst1Opcode   ,
    output    wire                             Inst1SinumA   ,
    output    wire      [25:0]                 Inst1SiDate   ,
    output    wire                             Inst1Sr1Abl   ,
    output    wire      [`ArchRegBUs]          Inst1Sr1Num   ,
    output    wire                             Inst1Sr2Abl   ,   
    output    wire      [`ArchRegBUs]          Inst1Sr2Num   ,
    output    wire                             Insr1WriteA   ,
    output    wire                             Inst1Part     , 
    output    wire      [`InstAddrBus]         Inst1Nadr     ,
    output    wire      [`ArchRegBUs]          Inst1WriteN   ,
    output    wire      [`MicOperateCode]      Inst2Opcode   ,
    output    wire                             Inst2SinumA   ,
    output    wire      [25:0]                 Inst2SiDate   ,
    output    wire                             Inst2Sr1Abl   ,
    output    wire      [`ArchRegBUs]          Inst2Sr1Num   ,
    output    wire                             Inst2Sr2Abl   ,   
    output    wire      [`ArchRegBUs]          Inst2Sr2Num   ,
    output    wire                             Insr2WriteA   ,
    output    wire      [`ArchRegBUs]          Inst2WriteN   ,
    output    wire                             Inst2Part     , 
    output    wire      [`InstAddrBus]         Inst2Nadr     ,
    output    wire      [`MicOperateCode]      Inst3Opcode   ,
    output    wire                             Inst3SinumA   ,
    output    wire      [25:0]                 Inst3SiDate   ,
    output    wire                             Inst3Sr1Abl   ,
    output    wire      [`ArchRegBUs]          Inst3Sr1Num   ,
    output    wire                             Inst3Sr2Abl   ,   
    output    wire      [`ArchRegBUs]          Inst3Sr2Num   ,
    output    wire                             Insr3WriteA   ,
    output    wire      [`ArchRegBUs]          Inst3WriteN   ,
    output    wire                             Inst3Part     , 
    output    wire      [`InstAddrBus]         Inst3Nadr     ,
    output    wire      [`MicOperateCode]      Inst4Opcode   ,
    output    wire                             Inst4SinumA   ,
    output    wire      [25:0]                 Inst4SiDate   ,
    output    wire                             Inst4Sr1Abl   ,
    output    wire      [`ArchRegBUs]          Inst4Sr1Num   ,
    output    wire                             Inst4Sr2Abl   ,   
    output    wire      [`ArchRegBUs]          Inst4Sr2Num   ,
    output    wire                             Insr4WriteA   ,
    output    wire      [`ArchRegBUs]          Inst4WriteN   ,
    output    wire                             Inst4Part     , 
    output    wire      [`InstAddrBus]         Inst4Nadr     
);

    //for inst1 
    wire  [5:0]  Inst1Op31to26 = InInstDate1[31:26] ;
    wire  [3:0]  Inst1Op25to22 = InInstDate1[25:22] ;
    wire  [1:0]  Inst1Op21to20 = InInstDate1[21:20] ;
    wire  [4:0]  Inst1Op19to15 = InInstDate1[19:15] ; 

    wire Inst1Rd = InInstDate1[4:0]   ;
    wire Inst1rj = InInstDate1[9:5]   ;
    wire Inst1rk = InInstDate1[14:10] ;

    wire Inst1Imm5   =  InInstDate1[14:10] ;
    wire Inst1Imm12  =  InInstDate1[21:10] ;
    wire Inst1Imm14  =  InInstDate1[23:10] ;
    wire Inst1Imm16  =  InInstDate1[25:10] ;
    wire Inst1Imm20  =  InInstDate1[24:5]  ;
    wire Inst1Imm26  =  {InInstDate1[9:0], InInstDate1[25:10]} ;
    wire Inst1CsrNum =  InInstDate1[23:10] ;

    wire Inst1Rdcntidw = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd0) & (InInstDate1[14:10] == 5'd24) & (InInstDate1[4:0] == 5'd0) ; //alu  1
    wire Inst1Rdcntvlw = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd0) & (InInstDate1[14:10] == 5'd24) & (InInstDate1[9:5] == 5'd0) ; //alu  2
    wire Inst1Rdcntvhw = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd0) & (InInstDate1[14:10] == 5'd25) & (InInstDate1[9:5] == 5'd0) ; //alu  3
    wire Inst1Addw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd0) ; //alu 4 
    wire Inst1Subw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd2) ; //alu 5
    wire Inst1Slt      = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd4) ; //alu 6
    wire Inst1Sltu     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd5) ; //alu 7
    wire Inst1Nor      = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd8) ; //alu 8
    wire Inst1And      = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd9) ; //alu 9
    wire Inst1Or       = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd10) ; //alu 10
    wire Inst1Xor      = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd11) ; //alu 11
    wire Inst1Sllw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd14) ; //alu 12
    wire Inst1Srlw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd15) ; //alu 13
    wire Inst1Sraw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd16) ; //alu 14
    wire Inst1Mulw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd24) ; //mul 1
    wire Inst1Mulhw    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd25) ; //mul 2
    wire Inst1Mulhwu   = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd1) & (Inst1Op19to15 == 5'd26) ; //mul 3
    wire Inst1Divw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd0) ; //div 1
    wire Inst1Modw     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd1) ; //div 2
    wire Inst1Divwu    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd2) ; //div 3
    wire Inst1Modwu    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd3) ; //div 4
    wire Inst1Break    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd20) ; //csr 1
    wire Inst1Syscall  = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd2) & (Inst1Op19to15 == 5'd22) ; //csr 2
    wire Inst1Slliw    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd1) ; //alu 15
    wire Inst1Srliw    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd9) ; //alu 16
    wire Inst1Sraiw    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd17) ; //alu 17
    wire Inst1Slti     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd8) ; //alu 18
    wire Inst1Sltui    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd9) ; //alu 19
    wire Inst1Addiw    = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd10) ; //alu 20 
    wire Inst1Andi     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd13) ; //alu 21
    wire Inst1Ori      = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd14) ; //alu 22
    wire Inst1Xori     = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd15) ; //alu 23
    wire Inst1Csrrd    = (Inst1Op31to26 == 6'd1) & (InInstDate1[25:24] == 2'd0) & (InInstDate1[9:5] == 5'd0) ; //csr 3
    wire Inst1Csrwr    = (Inst1Op31to26 == 6'd1) & (InInstDate1[25:24] == 2'd0) & (InInstDate1[9:5] == 5'd1) ; //csr 4
    wire Inst1Csrxchg  = (Inst1Op31to26 == 6'd1) & (InInstDate1[25:24] == 2'd0) & ((InInstDate1[9:5] != 5'd0) & (InInstDate1[9:5] != 5'd1)); //csr 5
    wire Inst1Cacop    = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd8) ; // no one eu(6) 1
    wire Inst1Tlbsrch  = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate1[14:10] == 5'd10) & (InInstDate1[9:5] == 5'd0) & (InInstDate1[4:0] == 5'd0) ; //csr 6
    wire Inst1Tlbrd    = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate1[14:10] == 5'd11) & (InInstDate1[9:5] == 5'd0) & (InInstDate1[4:0] == 5'd0) ; //csr 7
    wire Inst1Tlbwr    = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate1[14:10] == 5'd12) & (InInstDate1[9:5] == 5'd0) & (InInstDate1[4:0] == 5'd0) ; //csr 8
    wire Inst1Tlbfill  = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate1[14:10] == 5'd13) & (InInstDate1[9:5] == 5'd0) & (InInstDate1[4:0] == 5'd0) ; //csr 9
    wire Inst1Ertn     = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate1[14:10] == 5'd14) & (InInstDate1[9:5] == 5'd0) & (InInstDate1[4:0] == 5'd0) ; //csr 10
    wire Inst1Idle     = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd17) ; //csr 11
    wire Inst1Invtlb   = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd19) ; //csr 12
    wire Inst1Lu12iw   = (Inst1Op31to26 == 6'd5) & (InInstDate1[25] == 0) ;//alu 24
    wire Inst1Pcaddu12i= (Inst1Op31to26 == 6'd7) & (InInstDate1[25] == 0) ;//alu 25
    wire Inst1Llw      = (Inst1Op31to26 == 6'd8) & (InInstDate1[25:24] == 2'd0) ;//lsu load 1    (load为0,store为1)
    wire Inst1Scw      = (Inst1Op31to26 == 6'd8) & (InInstDate1[25:24] == 2'd1) ;//lsu store 1
    wire Inst1Ldb      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd0) ;//lsu load 2
    wire Inst1Ldh      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd1) ;//lsu load 3
    wire Inst1Ldw      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd2) ;//lsu load 4
    wire Inst1Stb      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd4) ;//lsu store 2
    wire Inst1Sth      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd5) ;//lsu store 3
    wire Inst1Stw      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd6) ;//lsu store 4
    wire Inst1Ldbu     = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd8) ;//lsu load 5
    wire Inst1Ldhu     = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd9) ;//lsu load 6
    wire Inst1Preld    = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd11) ;
    wire Inst1Dbar     = (Inst1Op31to26 == 6'd14) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd3) & (Inst1Op19to15 == 5'd4) ;
    wire Inst1Ibar     = (Inst1Op31to26 == 6'd14) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd3) & (Inst1Op19to15 == 5'd5) ;
    wire Inst1Jirl     = (Inst1Op31to26 == 6'd19) ;//bru 1
    wire Inst1B        = (Inst1Op31to26 == 6'd20) ;//bru 2
    wire Inst1Bl       = (Inst1Op31to26 == 6'd21) ;//bru 3
    wire Inst1Beq      = (Inst1Op31to26 == 6'd22) ;//bru 4
    wire Inst1Bne      = (Inst1Op31to26 == 6'd23) ;//bru 5
    wire Inst1Blt      = (Inst1Op31to26 == 6'd24) ;//bru 6
    wire Inst1Bge      = (Inst1Op31to26 == 6'd25) ;//bru 7
    wire Inst1Bltu     = (Inst1Op31to26 == 6'd26) ;//bru 8
    wire Inst1Bgeu     = (Inst1Op31to26 == 6'd27) ;//bru 9

    wire [`MicOperateCode] Inst1OperateCode ;
 
    assign Inst1OperateCode[7] = ~Inst1Rdcntidw | ~Inst1Rdcntvlw | ~Inst1Rdcntvhw | ~Inst1Addw | ~Inst1Subw | ~Inst1Slt | ~Inst1Slt | ~Inst1Nor | ~Inst1And | ~Inst1Or | ~Inst1Xor | ~Inst1Sllw | ~Inst1Srlw | ~Inst1Sraw | ~Inst1Mulw | ~Inst1Mulhw | ~Inst1Mulhwu | ~Inst1Divw | ~Inst1Modw | ~Inst1Divwu | ~Inst1Modwu |  Inst1Break |  Inst1Syscall | ~Inst1Slliw | ~Inst1Srliw | ~Inst1Sraiw | ~Inst1Slti | ~Inst1Sltui | ~Inst1Addiw | ~Inst1Andi | ~Inst1Ori | ~Inst1Xori |  Inst1Csrrd |  Inst1Csrwr |  Inst1Csrxchg |  Inst1Cacop |  Inst1Tlbsrch |  Inst1Tlbrd |  Inst1Tlbwr |  Inst1Tlbfill |  Inst1Ertn |  Inst1Idle |  Inst1Invtlb | ~Inst1Lu12iw | ~Inst1Pcaddu12i |  Inst1Llw |  Inst1Scw |  Inst1Ldb |  Inst1Ldh |  Inst1Ldw |  Inst1Stb |  Inst1Sth |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu |  Inst1Jirl |  Inst1B |  Inst1Bl |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge |  Inst1Bltu |  Inst1Bgeu  ;
    assign Inst1OperateCode[6] = ~Inst1Rdcntidw | ~Inst1Rdcntvlw | ~Inst1Rdcntvhw | ~Inst1Addw | ~Inst1Subw | ~Inst1Slt | ~Inst1Slt | ~Inst1Nor | ~Inst1And | ~Inst1Or | ~Inst1Xor | ~Inst1Sllw | ~Inst1Srlw | ~Inst1Sraw |  Inst1Mulw |  Inst1Mulhw |  Inst1Mulhwu |  Inst1Divw |  Inst1Modw |  Inst1Divwu |  Inst1Modwu | ~Inst1Break | ~Inst1Syscall | ~Inst1Slliw | ~Inst1Srliw | ~Inst1Sraiw | ~Inst1Slti | ~Inst1Sltui | ~Inst1Addiw | ~Inst1Andi | ~Inst1Ori | ~Inst1Xori | ~Inst1Csrrd | ~Inst1Csrwr | ~Inst1Csrxchg |  Inst1Cacop | ~Inst1Tlbsrch | ~Inst1Tlbrd | ~Inst1Tlbwr | ~Inst1Tlbfill | ~Inst1Ertn | ~Inst1Idle | ~Inst1Invtlb | ~Inst1Lu12iw | ~Inst1Pcaddu12i | ~Inst1Llw | ~Inst1Scw | ~Inst1Ldb | ~Inst1Ldh | ~Inst1Ldw | ~Inst1Stb | ~Inst1Sth | ~Inst1Stw | ~Inst1Ldbu | ~Inst1Ldhu |  Inst1Jirl |  Inst1B |  Inst1Bl |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge |  Inst1Bltu |  Inst1Bgeu  ;
    assign Inst1OperateCode[5] =  Inst1Rdcntidw |  Inst1Rdcntvlw |  Inst1Rdcntvhw |  Inst1Addw |  Inst1Subw |  Inst1Slt |  Inst1Slt |  Inst1Nor |  Inst1And |  Inst1Or |  Inst1Xor |  Inst1Sllw |  Inst1Srlw |  Inst1Sraw |  Inst1Mulw |  Inst1Mulhw |  Inst1Mulhwu | ~Inst1Divw | ~Inst1Modw | ~Inst1Divwu | ~Inst1Modwu | ~Inst1Break | ~Inst1Syscall |  Inst1Slliw |  Inst1Srliw |  Inst1Sraiw |  Inst1Slti |  Inst1Sltui |  Inst1Addiw |  Inst1Andi |  Inst1Ori |  Inst1Xori | ~Inst1Csrrd | ~Inst1Csrwr | ~Inst1Csrxchg | ~Inst1Cacop | ~Inst1Tlbsrch | ~Inst1Tlbrd | ~Inst1Tlbwr | ~Inst1Tlbfill | ~Inst1Ertn | ~Inst1Idle | ~Inst1Invtlb |  Inst1Lu12iw |  Inst1Pcaddu12i |  Inst1Llw |  Inst1Scw |  Inst1Ldb |  Inst1Ldh |  Inst1Ldw |  Inst1Stb |  Inst1Sth |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu |  Inst1Jirl |  Inst1B |  Inst1Bl |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge |  Inst1Bltu |  Inst1Bgeu  ;
    assign Inst1OperateCode[4] = ~Inst1Rdcntidw | ~Inst1Rdcntvlw | ~Inst1Rdcntvhw | ~Inst1Addw | ~Inst1Subw | ~Inst1Slt | ~Inst1Slt | ~Inst1Nor | ~Inst1And | ~Inst1Or | ~Inst1Xor | ~Inst1Sllw | ~Inst1Srlw | ~Inst1Sraw | ~Inst1Mulw | ~Inst1Mulhw | ~Inst1Mulhwu | ~Inst1Divw | ~Inst1Modw | ~Inst1Divwu | ~Inst1Modwu | ~Inst1Break | ~Inst1Syscall | ~Inst1Slliw |  Inst1Srliw |  Inst1Sraiw |  Inst1Slti |  Inst1Sltui |  Inst1Addiw |  Inst1Andi |  Inst1Ori |  Inst1Xori | ~Inst1Csrrd | ~Inst1Csrwr | ~Inst1Csrxchg | ~Inst1Cacop | ~Inst1Tlbsrch | ~Inst1Tlbrd | ~Inst1Tlbwr | ~Inst1Tlbfill | ~Inst1Ertn | ~Inst1Idle | ~Inst1Invtlb |  Inst1Lu12iw |  Inst1Pcaddu12i | ~Inst1Llw |  Inst1Scw | ~Inst1Ldb | ~Inst1Ldh | ~Inst1Ldw |  Inst1Stb |  Inst1Sth |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu | ~Inst1Jirl | ~Inst1B | ~Inst1Bl | ~Inst1Beq | ~Inst1Bne | ~Inst1Blt | ~Inst1Bge | ~Inst1Bltu | ~Inst1Bgeu  ;
    assign Inst1OperateCode[3] = ~Inst1Rdcntidw | ~Inst1Rdcntvlw | ~Inst1Rdcntvhw | ~Inst1Addw | ~Inst1Subw | ~Inst1Slt | ~Inst1Slt |  Inst1Nor |  Inst1And |  Inst1Or |  Inst1Xor |  Inst1Sllw |  Inst1Srlw |  Inst1Sraw | ~Inst1Mulw | ~Inst1Mulhw | ~Inst1Mulhwu | ~Inst1Divw | ~Inst1Modw | ~Inst1Divwu | ~Inst1Modwu | ~Inst1Break | ~Inst1Syscall |  Inst1Slliw | ~Inst1Srliw | ~Inst1Sraiw | ~Inst1Slti | ~Inst1Sltui | ~Inst1Addiw | ~Inst1Andi | ~Inst1Ori | ~Inst1Xori | ~Inst1Csrrd | ~Inst1Csrwr | ~Inst1Csrxchg | ~Inst1Cacop | ~Inst1Tlbsrch | ~Inst1Tlbrd |  Inst1Tlbwr |  Inst1Tlbfill |  Inst1Ertn |  Inst1Idle |  Inst1Invtlb |  Inst1Lu12iw |  Inst1Pcaddu12i | ~Inst1Llw | ~Inst1Scw | ~Inst1Ldb | ~Inst1Ldh | ~Inst1Ldw | ~Inst1Stb | ~Inst1Sth | ~Inst1Stw | ~Inst1Ldbu | ~Inst1Ldhu | ~Inst1Jirl | ~Inst1B | ~Inst1Bl | ~Inst1Beq | ~Inst1Bne | ~Inst1Blt | ~Inst1Bge |  Inst1Bltu |  Inst1Bgeu  ;
    assign Inst1OperateCode[2] = ~Inst1Rdcntidw | ~Inst1Rdcntvlw | ~Inst1Rdcntvhw |  Inst1Addw |  Inst1Subw |  Inst1Slt |  Inst1Slt | ~Inst1Nor | ~Inst1And | ~Inst1Or | ~Inst1Xor |  Inst1Sllw |  Inst1Srlw |  Inst1Sraw | ~Inst1Mulw | ~Inst1Mulhw | ~Inst1Mulhwu | ~Inst1Divw | ~Inst1Modw | ~Inst1Divwu |  Inst1Modwu | ~Inst1Break | ~Inst1Syscall |  Inst1Slliw | ~Inst1Srliw | ~Inst1Sraiw | ~Inst1Slti | ~Inst1Sltui |  Inst1Addiw |  Inst1Andi |  Inst1Ori |  Inst1Xori | ~Inst1Csrrd |  Inst1Csrwr |  Inst1Csrxchg | ~Inst1Cacop |  Inst1Tlbsrch |  Inst1Tlbrd | ~Inst1Tlbwr | ~Inst1Tlbfill | ~Inst1Ertn | ~Inst1Idle |  Inst1Invtlb | ~Inst1Lu12iw | ~Inst1Pcaddu12i | ~Inst1Llw | ~Inst1Scw | ~Inst1Ldb | ~Inst1Ldh |  Inst1Ldw | ~Inst1Stb | ~Inst1Sth |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu | ~Inst1Jirl | ~Inst1B | ~Inst1Bl |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge | ~Inst1Bltu | ~Inst1Bgeu  ;
    assign Inst1OperateCode[1] = ~Inst1Rdcntidw |  Inst1Rdcntvlw |  Inst1Rdcntvhw | ~Inst1Addw | ~Inst1Subw |  Inst1Slt |  Inst1Slt | ~Inst1Nor | ~Inst1And |  Inst1Or |  Inst1Xor | ~Inst1Sllw | ~Inst1Srlw |  Inst1Sraw | ~Inst1Mulw |  Inst1Mulhw |  Inst1Mulhwu | ~Inst1Divw |  Inst1Modw |  Inst1Divwu | ~Inst1Modwu | ~Inst1Break |  Inst1Syscall |  Inst1Slliw | ~Inst1Srliw | ~Inst1Sraiw |  Inst1Slti |  Inst1Sltui | ~Inst1Addiw | ~Inst1Andi |  Inst1Ori |  Inst1Xori |  Inst1Csrrd | ~Inst1Csrwr | ~Inst1Csrxchg | ~Inst1Cacop |  Inst1Tlbsrch |  Inst1Tlbrd | ~Inst1Tlbwr | ~Inst1Tlbfill |  Inst1Ertn |  Inst1Idle | ~Inst1Invtlb | ~Inst1Lu12iw | ~Inst1Pcaddu12i | ~Inst1Llw | ~Inst1Scw |  Inst1Ldb |  Inst1Ldh | ~Inst1Ldw |  Inst1Stb |  Inst1Sth | ~Inst1Stw | ~Inst1Ldbu |  Inst1Ldhu | ~Inst1Jirl |  Inst1B |  Inst1Bl | ~Inst1Beq | ~Inst1Bne |  Inst1Blt |  Inst1Bge | ~Inst1Bltu | ~Inst1Bgeu  ;
    assign Inst1OperateCode[0] =  Inst1Rdcntidw | ~Inst1Rdcntvlw |  Inst1Rdcntvhw | ~Inst1Addw |  Inst1Subw | ~Inst1Slt |  Inst1Slt | ~Inst1Nor |  Inst1And | ~Inst1Or |  Inst1Xor | ~Inst1Sllw |  Inst1Srlw | ~Inst1Sraw |  Inst1Mulw | ~Inst1Mulhw |  Inst1Mulhwu |  Inst1Divw | ~Inst1Modw |  Inst1Divwu | ~Inst1Modwu |  Inst1Break | ~Inst1Syscall |  Inst1Slliw | ~Inst1Srliw |  Inst1Sraiw | ~Inst1Slti |  Inst1Sltui | ~Inst1Addiw |  Inst1Andi | ~Inst1Ori |  Inst1Xori |  Inst1Csrrd | ~Inst1Csrwr |  Inst1Csrxchg |  Inst1Cacop | ~Inst1Tlbsrch |  Inst1Tlbrd | ~Inst1Tlbwr |  Inst1Tlbfill | ~Inst1Ertn |  Inst1Idle | ~Inst1Invtlb | ~Inst1Lu12iw |  Inst1Pcaddu12i |  Inst1Llw |  Inst1Scw | ~Inst1Ldb |  Inst1Ldh | ~Inst1Ldw | ~Inst1Stb |  Inst1Sth | ~Inst1Stw |  Inst1Ldbu | ~Inst1Ldhu |  Inst1Jirl | ~Inst1B |  Inst1Bl | ~Inst1Beq |  Inst1Bne | ~Inst1Blt |  Inst1Bge | ~Inst1Bltu |  Inst1Bgeu  ;

endmodule
