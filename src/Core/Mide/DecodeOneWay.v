`timescale 1ps/1ps
`include "../define.v"

module DecodeOneWay (
    input       wire                                   Clk          ,
    input       wire                                   Rest         ,

    input       wire                                   DecodeStop   ,
    input       wire                                   DecodeFlash  ,
    input       wire     [`InstDateBus]                InInstDate   ,
    input       wire     [`InstAddrBus]                InInstAddr   ,
    input       wire                                   InInstPart   ,
    input       wire     [`InstAddrBus]                InInstNAdr   ,
    input       wire                                   InInstPort   ,

    output      wire     [`InstAddrBus]                InstAddr     ,
    output      wire     [`MicOperateCode]             InstOpcode   ,
    output      wire                                   InstSinumA   ,
    output      wire     [25:0]                        InstSiDate   ,
    output      wire                                   InstSr1Abl   ,
    output      wire     [`ArchRegBUs]                 InstSr1Num   ,
    output      wire                                   InstSr2Abl   ,
    output      wire     [`ArchRegBUs]                 InstSr2Num   ,
    output      wire                                   InsrWriteA   ,
    output      wire     [`ArchRegBUs]                 InstWriteN   ,
    output      wire                                   InstPart     ,
    output      wire     [`InstAddrBus]                InstNadr  
);

    wire  [5:0]  Inst1Op31to26 = InInstDate[31:26] ;
    wire  [3:0]  Inst1Op25to22 = InInstDate[25:22] ;
    wire  [1:0]  Inst1Op21to20 = InInstDate[21:20] ;
    wire  [4:0]  Inst1Op19to15 = InInstDate[19:15] ; 

    wire [4:0] Inst1Rd = InInstDate[4:0]   ;
    wire [4:0] Inst1rj = InInstDate[9:5]   ;
    wire [4:0] Inst1rk = InInstDate[14:10] ;

    wire [11:0] Inst1Imm12D  =  InInstDate[21:10] ;
    wire [13:0] Inst1Imm14D  =  InInstDate[23:10] ;
    wire [15:0] Inst1Imm16D  =  InInstDate[25:10] ;
    wire [19:0] Inst1Imm20D  =  InInstDate[24:5]  ;
    wire [25:0] Inst1Imm26D  =  {InInstDate[9:0], InInstDate[25:10]} ;

    wire Inst1Rdcntidw = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd0) & (InInstDate[14:10] == 5'd24) & (InInstDate[4:0] == 5'd0) ; //alu  1
    wire Inst1Rdcntvlw = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd0) & (InInstDate[14:10] == 5'd24) & (InInstDate[9:5] == 5'd0) ; //alu  2
    wire Inst1Rdcntvhw = (Inst1Op31to26 == 6'd0) & (Inst1Op25to22 == 4'd0) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd0) & (InInstDate[14:10] == 5'd25) & (InInstDate[9:5] == 5'd0) ; //alu  3
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
    wire Inst1Csrrd    = (Inst1Op31to26 == 6'd1) & (InInstDate[25:24] == 2'd0) & (InInstDate[9:5] == 5'd0) ; //csr 3
    wire Inst1Csrwr    = (Inst1Op31to26 == 6'd1) & (InInstDate[25:24] == 2'd0) & (InInstDate[9:5] == 5'd1) ; //csr 4
    wire Inst1Csrxchg  = (Inst1Op31to26 == 6'd1) & (InInstDate[25:24] == 2'd0) & ((InInstDate[9:5] != 5'd0) & (InInstDate[9:5] != 5'd1)); //csr 5
  /*yaoxuigai*/   wire Inst1Cacop    = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd8) ; // no one eu(6) 1
    wire Inst1Tlbsrch  = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate[14:10] == 5'd10) & (InInstDate[9:5] == 5'd0) & (InInstDate[4:0] == 5'd0) ; //csr 6
    wire Inst1Tlbrd    = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate[14:10] == 5'd11) & (InInstDate[9:5] == 5'd0) & (InInstDate[4:0] == 5'd0) ; //csr 7
    wire Inst1Tlbwr    = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate[14:10] == 5'd12) & (InInstDate[9:5] == 5'd0) & (InInstDate[4:0] == 5'd0) ; //csr 8
    wire Inst1Tlbfill  = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate[14:10] == 5'd13) & (InInstDate[9:5] == 5'd0) & (InInstDate[4:0] == 5'd0) ; //csr 9
    wire Inst1Ertn     = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd16) & (InInstDate[14:10] == 5'd14) & (InInstDate[9:5] == 5'd0) & (InInstDate[4:0] == 5'd0) ; //csr 10
    wire Inst1Idle     = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd17) ; //csr 11
    wire Inst1Invtlb   = (Inst1Op31to26 == 6'd1) & (Inst1Op25to22 == 4'd9) & (Inst1Op21to20 == 2'd0) & (Inst1Op19to15 == 5'd19) ; //csr 12
    wire Inst1Lu12iw   = (Inst1Op31to26 == 6'd5) & (InInstDate[25] == 0) ;//alu 24
    wire Inst1Pcaddu12i= (Inst1Op31to26 == 6'd7) & (InInstDate[25] == 0) ;//alu 25
    wire Inst1Llw      = (Inst1Op31to26 == 6'd8) & (InInstDate[25:24] == 2'd0) ;//lsu load 1    (load为0,store为1)
    wire Inst1Scw      = (Inst1Op31to26 == 6'd8) & (InInstDate[25:24] == 2'd1) ;//lsu store 1
    wire Inst1Ldb      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd0) ;//lsu load 2
    wire Inst1Ldh      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd1) ;//lsu load 3
    wire Inst1Ldw      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd2) ;//lsu load 4
    wire Inst1Stb      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd4) ;//lsu store 2
    wire Inst1Sth      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd5) ;//lsu store 3
    wire Inst1Stw      = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd6) ;//lsu store 4
    wire Inst1Ldbu     = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd8) ;//lsu load 5
    wire Inst1Ldhu     = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd9) ;//lsu load 6
    wire Inst1Preld    = (Inst1Op31to26 == 6'd10) & (Inst1Op25to22 == 4'd11) ; //special 1
    wire Inst1Dbar     = (Inst1Op31to26 == 6'd14) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd3) & (Inst1Op19to15 == 5'd4) ;//special 2
    wire Inst1Ibar     = (Inst1Op31to26 == 6'd14) & (Inst1Op25to22 == 4'd1) & (Inst1Op21to20 == 2'd3) & (Inst1Op19to15 == 5'd5) ;//special 3
    wire Inst1Jirl     = (Inst1Op31to26 == 6'd19) ;//bru 1
    wire Inst1B        = (Inst1Op31to26 == 6'd20) ;//bru 2
    wire Inst1Bl       = (Inst1Op31to26 == 6'd21) ;//bru 3
    wire Inst1Beq      = (Inst1Op31to26 == 6'd22) ;//bru 4
    wire Inst1Bne      = (Inst1Op31to26 == 6'd23) ;//bru 5
    wire Inst1Blt      = (Inst1Op31to26 == 6'd24) ;//bru 6
    wire Inst1Bge      = (Inst1Op31to26 == 6'd25) ;//bru 7
    wire Inst1Bltu     = (Inst1Op31to26 == 6'd26) ;//bru 8
    wire Inst1Bgeu     = (Inst1Op31to26 == 6'd27) ;//bru 9
    // alu 1 div 2 mul 3 csr 4 lsu 5 qiyi 6 bru 7 special 0
    wire [`MicOperateCode] Inst1OperateCode ;
 
    assign Inst1OperateCode[7] = 0              |  0             | 0              | 0          | 0          | 0         | 0          | 0         | 0         | 0        | 0         | 0          | 0          | 0          | 0          | 0           | 0            | 0          | 0          | 0           | 0           |  Inst1Break |  Inst1Syscall | 0           | 0           | 0           | 0          | 0           | 0           | 0          | 0         | 0          |  Inst1Csrrd |  Inst1Csrwr |  Inst1Csrxchg |  Inst1Cacop |  Inst1Tlbsrch |  Inst1Tlbrd |  Inst1Tlbwr |  Inst1Tlbfill |  Inst1Ertn |  Inst1Idle |  Inst1Invtlb | 0            | 0               |  Inst1Llw |  Inst1Scw |  Inst1Ldb |  Inst1Ldh |  Inst1Ldw |  Inst1Stb |  Inst1Sth |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu |  Inst1Jirl |  Inst1B |  Inst1Bl |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge |  Inst1Bltu |  Inst1Bgeu | 0           | 0          | 0          ;
    assign Inst1OperateCode[6] = 0              |  0             | 0              | 0          | 0          | 0         | 0          | 0         | 0         | 0        | 0         | 0          | 0          | 0          |  Inst1Mulw |  Inst1Mulhw |  Inst1Mulhwu |  Inst1Divw |  Inst1Modw |  Inst1Divwu |  Inst1Modwu | 0           | 0             | 0           | 0           | 0           | 0          | 0           | 0           | 0          | 0         | 0          | 0           | 0           | 0             |  Inst1Cacop | 0             | 0           | 0           | 0             | 0          | 0          | 0            | 0            | 0               | 0         | 0         | 0         | 0         | 0         |  0        | 0         | 0         | 0          | 0          |  Inst1Jirl |  Inst1B |  Inst1Bl |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge |  Inst1Bltu |  Inst1Bgeu | 0           | 0          | 0          ;
    assign Inst1OperateCode[5] =  Inst1Rdcntidw |  Inst1Rdcntvlw |  Inst1Rdcntvhw |  Inst1Addw |  Inst1Subw |  Inst1Slt |  Inst1Sltu |  Inst1Nor |  Inst1And |  Inst1Or |  Inst1Xor |  Inst1Sllw |  Inst1Srlw |  Inst1Sraw |  Inst1Mulw |  Inst1Mulhw |  Inst1Mulhwu | 0          | 0          | 0           | 0           | 0           | 0             |  Inst1Slliw |  Inst1Srliw |  Inst1Sraiw |  Inst1Slti |  Inst1Sltui |  Inst1Addiw |  Inst1Andi |  Inst1Ori |  Inst1Xori | 0           | 0           | 0             | 0           | 0             | 0           | 0           | 0             | 0          | 0          | 0            |  Inst1Lu12iw |  Inst1Pcaddu12i |  Inst1Llw |  Inst1Scw |  Inst1Ldb |  Inst1Ldh |  Inst1Ldw |  Inst1Stb |  Inst1Sth |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu |  Inst1Jirl |  Inst1B |  Inst1Bl |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge |  Inst1Bltu |  Inst1Bgeu | 0           | 0          | 0          ;
    assign Inst1OperateCode[4] = 0              |  0             | 0              | 0          | 0          | 0         | 0          | 0         | 0         | 0        | 0         | 0          | 0          | 0          | 0          | 0           | 0            | 0          | 0          | 0           | 0           | 0           | 0             | 0           |  Inst1Srliw |  Inst1Sraiw |  Inst1Slti |  Inst1Sltui |  Inst1Addiw |  Inst1Andi |  Inst1Ori |  Inst1Xori | 0           | 0           | 0             | 0           | 0             | 0           | 0           | 0             | 0          | 0          | 0            |  Inst1Lu12iw |  Inst1Pcaddu12i | 0         |  Inst1Scw | 0         | 0         | 0         |  Inst1Stb |  Inst1Sth |  Inst1Stw |  0         |  0         | 0          | 0       | 0        | 0         | 0         | 0         | 0         | 0          | 0          | 0           | 0          | 0          ;
    assign Inst1OperateCode[3] = 0              |  0             | 0              | 0          | 0          | 0         | 0          |  Inst1Nor |  Inst1And |  Inst1Or |  Inst1Xor |  Inst1Sllw |  Inst1Srlw |  Inst1Sraw | 0          | 0           | 0            | 0          | 0          | 0           | 0           | 0           | 0             |  Inst1Slliw | 0           | 0           | 0          | 0           | 0           | 0          | 0         | 0          | 0           | 0           | 0             | 0           | 0             | 0           |  Inst1Tlbwr |  Inst1Tlbfill |  Inst1Ertn |  Inst1Idle |  Inst1Invtlb |  Inst1Lu12iw |  Inst1Pcaddu12i | 0         | 0         | 0         | 0         | 0         | 0         | 0         | 0         | 0          | 0          | 0          | 0       | 0        | 0         | 0         | 0         | 0         |  Inst1Bltu |  Inst1Bgeu | 0           | 0          | 0          ;
    assign Inst1OperateCode[2] = 0              |  0             | 0              |  Inst1Addw |  Inst1Subw |  Inst1Slt |  Inst1Sltu | 0         | 0         | 0        | 0         |  Inst1Sllw |  Inst1Srlw |  Inst1Sraw | 0          | 0           | 0            | 0          | 0          | 0           |  Inst1Modwu | 0           | 0             |  Inst1Slliw | 0           | 0           | 0          | 0           |  Inst1Addiw |  Inst1Andi |  Inst1Ori |  Inst1Xori | 0           |  Inst1Csrwr |  Inst1Csrxchg | 0           |  Inst1Tlbsrch |  Inst1Tlbrd | 0           | 0             | 0          | 0          |  Inst1Invtlb | 0            | 0               | 0         | 0         | 0         | 0         |  Inst1Ldw | 0         | 0         |  Inst1Stw |  Inst1Ldbu |  Inst1Ldhu | 0          | 0       | 0        |  Inst1Beq |  Inst1Bne |  Inst1Blt |  Inst1Bge | 0          | 0          | 0           | 0          | 0          ;
    assign Inst1OperateCode[1] = 0              |  Inst1Rdcntvlw |  Inst1Rdcntvhw | 0          | 0          |  Inst1Slt |  Inst1Sltu | 0         |           |  Inst1Or |  Inst1Xor | 0          | 0          |  Inst1Sraw | 0          |  Inst1Mulhw |  Inst1Mulhwu | 0          |  Inst1Modw |  Inst1Divwu | 0           | 0           |  Inst1Syscall |  Inst1Slliw | 0           | 0           |  Inst1Slti |  Inst1Sltui | 0           | 0          |  Inst1Ori |  Inst1Xori |  Inst1Csrrd | 0           | 0             | 0           |  Inst1Tlbsrch |  Inst1Tlbrd | 0           | 0             |  Inst1Ertn |  Inst1Idle | 0            | 0            | 0               | 0         | 0         |  Inst1Ldb |  Inst1Ldh | 0         |  Inst1Stb |  Inst1Sth | 0         | 0          |  Inst1Ldhu | 0          |  Inst1B |  Inst1Bl | 0         | 0         |  Inst1Blt |  Inst1Bge | 0          | 0          | 0           |  Inst1Dbar |  Inst1Ibar ;
    assign Inst1OperateCode[0] =  Inst1Rdcntidw |  0             |  Inst1Rdcntvhw | 0          |  Inst1Subw | 0         |  Inst1Sltu | 0         |  Inst1And | 0        |  Inst1Xor | 0          |  Inst1Srlw | 0          |  Inst1Mulw | 0           |  Inst1Mulhwu |  Inst1Divw | 0          |  Inst1Divwu | 0           |  Inst1Break | 0             |  Inst1Slliw | 0           |  Inst1Sraiw | 0          |  Inst1Sltui | 0           |  Inst1Andi | 0         |  Inst1Xori |  Inst1Csrrd | 0           |  Inst1Csrxchg |  Inst1Cacop | 0             |  Inst1Tlbrd | 0           |  Inst1Tlbfill | 0          |  Inst1Idle | 0            | 0            |  Inst1Pcaddu12i |  Inst1Llw |  Inst1Scw | 0         |  Inst1Ldh | 0         | 0         |  Inst1Sth | 0         |  Inst1Ldbu | 0          |  Inst1Jirl | 0       |  Inst1Bl | 0         |  Inst1Bne | 0         |  Inst1Bge | 0          |  Inst1Bgeu |  Inst1Preld | 0          |  Inst1Ibar ;

    wire Inst1rdAble =  Inst1Rdcntvlw |
                        Inst1Rdcntvhw |
                        Inst1Addw     |
                        Inst1Subw     |
                        Inst1Slt      |
                        Inst1Sltu     |
                        Inst1Nor      |
                        Inst1And      |
                        Inst1Or       | 
                        Inst1Xor      | 
                        Inst1Sllw     |
                        Inst1Srlw     |
                        Inst1Sraw     |
                        Inst1Mulw     |
                        Inst1Mulhw    |
                        Inst1Mulhwu   |
                        Inst1Divw     |
                        Inst1Modw     |
                        Inst1Divwu    |
                        Inst1Modwu    |
                        Inst1Slliw    |
                        Inst1Srliw    |
                        Inst1Sraiw    |
                        Inst1Slti     |
                        Inst1Sltui    |
                        Inst1Addiw    |
                        Inst1Andi     |
                        Inst1Ori      |
                        Inst1Xori     |
                        Inst1Csrrd    |
                        Inst1Csrwr    |
                        Inst1Csrxchg  |
                        Inst1Cacop    |
                        Inst1Lu12iw   |
                        Inst1Pcaddu12i|
                        Inst1Llw      |
                        Inst1Scw      |
                        Inst1Ldb      |
                        Inst1Ldh      |
                        Inst1Ldw      |
                        Inst1Stb      |
                        Inst1Sth      |
                        Inst1Stw      |
                        Inst1Ldbu     |
                        Inst1Ldhu     |
                        Inst1Preld    |
                        Inst1Jirl     |
                        Inst1Bl       ;
                        // Inst1Beq      |
                        // Inst1Bne      |
                        // Inst1Blt      |
                        // Inst1Bge      |
                        // Inst1Bltu     |
                        // Inst1Bgeu     ;
    wire Inst1rjAble =  Inst1Rdcntidw |
                        Inst1Addw     |
                        Inst1Subw     |
                        Inst1Slt      |
                        Inst1Sltu     |
                        Inst1Nor      |
                        Inst1And      |
                        Inst1Or       |
                        Inst1Xor      |
                        Inst1Sllw     |
                        Inst1Srlw     |  
                        Inst1Sraw     |
                        Inst1Mulw     |
                        Inst1Mulhw    | 
                        Inst1Mulhwu   |
                        Inst1Divw     |
                        Inst1Modw     |
                        Inst1Divwu    |
                        Inst1Modwu    |
                        Inst1Slliw    |
                        Inst1Srliw    |
                        Inst1Sraiw    |
                        Inst1Slti     |
                        Inst1Sltui    |
                        Inst1Addiw    |
                        Inst1Andi     |
                        Inst1Ori      |
                        Inst1Xori     |
                        Inst1Cacop    |
                        Inst1Csrxchg  |
                        Inst1Invtlb   |
                        Inst1Llw      |
                        Inst1Scw      |
                        Inst1Ldb      |
                        Inst1Ldh      |
                        Inst1Ldw      |
                        Inst1Stb      |
                        Inst1Sth      |
                        Inst1Stw      |
                        Inst1Ldbu     |
                        Inst1Ldhu     |
                        Inst1Preld    |
                        Inst1Jirl     |
                        Inst1Beq      |
                        Inst1Bne      |
                        Inst1Blt      |
                        Inst1Bge      |
                        Inst1Bltu     |
                        Inst1Bgeu     ;
    wire Inst1rkAble =  Inst1Addw     |
                        Inst1Subw     |
                        Inst1Slt      |
                        Inst1Sltu     |
                        Inst1Nor      |
                        Inst1And      |
                        Inst1Or       |
                        Inst1Xor      |
                        Inst1Sllw     |
                        Inst1Srlw     |
                        Inst1Sraw     |
                        Inst1Mulw     |
                        Inst1Mulhw    |
                        Inst1Mulhwu   |
                        Inst1Divw     |
                        Inst1Modw     |
                        Inst1Divwu    |
                        Inst1Modwu    |
                        Inst1Beq      |
                        Inst1Bne      |
                        Inst1Blt      |
                        Inst1Bge      |
                        Inst1Bltu     |
                        Inst1Bgeu     |
                        Inst1Csrwr    | //csrwr指令的rd旧值
                        Inst1Csrxchg  | 
                        Inst1Invtlb   ;

    wire Inst1Imm12  =  Inst1Slti     |
                        Inst1Sltui    |
                        Inst1Addiw    |
                        Inst1Andi     |
                        Inst1Ori      |
                        Inst1Xori     |
                        Inst1Cacop    |
                        Inst1Ldb      |
                        Inst1Ldh      |
                        Inst1Ldw      |
                        Inst1Stb      |
                        Inst1Sth      |
                        Inst1Stw      |
                        Inst1Ldbu     |
                        Inst1Ldhu     |
                        Inst1Preld    ;
    wire Inst1Imm14  =  Inst1Csrrd    |
                        Inst1Csrwr    |
                        Inst1Csrxchg  |
                        Inst1Llw      |
                        Inst1Scw      ;
    wire Inst1Imm16  =  Inst1Jirl     |
                        Inst1Beq      |
                        Inst1Bne      |
                        Inst1Blt      |
                        Inst1Bge      |
                        Inst1Bltu     |
                        Inst1Bgeu     ;
    wire Inst1Imm26  =  Inst1B        |
                        Inst1Bl       ;
    wire Inst1Imm20   = Inst1Lu12iw   |
                        Inst1Pcaddu12i;
    wire InstCode     = Inst1Syscall  |
                        Inst1Idle     |
                        Inst1Dbar     |
                        Inst1Ibar     | 
                        Inst1Break    ;
    wire Inst1Imm5    = Inst1Slliw    | 
                        Inst1Srliw    | 
                        Inst1Sraiw    ;

    wire Inst1ImmAble = Inst1Imm14 | Inst1Imm12 | Inst1Imm16 | Inst1Imm26 | Inst1Imm20 | InstCode | Inst1Imm5 ;
    wire [25:0] Inst1ImmDate = Inst1Imm5 ? {21'd0,Inst1rk} :
                               InstCode  ? {11'd0,Inst1rk, Inst1rj, Inst1Rd} :
                               Inst1Imm12 ? {14'd0,Inst1Imm12D} :
                               Inst1Imm14 ? {12'd0,Inst1Imm14D} :
                               Inst1Imm16 ? {10'd0,Inst1Imm16D} :
                               Inst1Imm20 ? {6'd0,Inst1Imm20D} :
                               Inst1Imm26 ? Inst1Imm26D :26'd0 ;
    wire [4:0] Inst1RdAddr   = Inst1Bl ? 5'd1 : Inst1Rd  ;
    wire [4:0] Inst1Src1Addr = Inst1rj ;
    wire [4:0] Inst1Src2addr = (Inst1Beq | Inst1Bne | Inst1Blt | Inst1Bge | Inst1Bltu | Inst1Bgeu | Inst1Csrwr | Inst1Csrxchg) ? Inst1Rd : Inst1rk ; 

    reg [`MicOperateCode] Inst1OpcodeReg ;
    reg                   Inst1SinumAReg ;
    reg [25:0]            Inst1SiDateReg ;
    reg                   Inst1Sr1AblReg ;
    reg [`ArchRegBUs]     Inst1Sr1NumReg ;
    reg                   Inst1Sr2AblReg ;
    reg [`ArchRegBUs]     Inst1Sr2NumReg ;
    reg                   Insr1WriteAReg ;
    reg [`ArchRegBUs]     Inst1WriteNReg ;
    reg                   Inst1PartReg   ;
    reg [`InstAddrBus]    Inst1NadrReg   ;
    reg [`InstAddrBus]    Inst1AddrReg   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            Inst1OpcodeReg <= 8'd0 ;
            Inst1SinumAReg <= `EnableValue ;
            Inst1SiDateReg <= 26'd0 ;
            Inst1Sr1AblReg <= `EnableValue ;
            Inst1Sr1NumReg <= 5'd0 ;
            Inst1Sr2AblReg <= `EnableValue ;
            Inst1Sr2NumReg <= 5'd0 ;
            Insr1WriteAReg <= `EnableValue ;
            Inst1WriteNReg <= 5'd0 ;
            Inst1PartReg   <= `EnableValue ;
            Inst1NadrReg   <= `ZeorDate ;
            Inst1AddrReg   <= `ZeorDate ;
        end
        else begin
            if(DecodeStop) begin
                Inst1OpcodeReg <= Inst1OpcodeReg ;
                Inst1SinumAReg <= Inst1SinumAReg ;
                Inst1SiDateReg <= Inst1SiDateReg ;
                Inst1Sr1AblReg <= Inst1Sr1AblReg ;
                Inst1Sr1NumReg <= Inst1Sr1NumReg ;
                Inst1Sr2AblReg <= Inst1Sr2AblReg ;
                Inst1Sr2NumReg <= Inst1Sr2NumReg ;
                Insr1WriteAReg <= Insr1WriteAReg ;
                Inst1WriteNReg <= Inst1WriteNReg ;
                Inst1PartReg   <= Inst1PartReg   ;
                Inst1NadrReg   <= Inst1NadrReg   ;
                Inst1AddrReg   <= Inst1AddrReg   ;
            end
            if(DecodeFlash) begin
                Inst1OpcodeReg <= 8'd0 ;
                Inst1SinumAReg <= `EnableValue ;
                Inst1SiDateReg <= 26'd0 ;
                Inst1Sr1AblReg <= `EnableValue ;
                Inst1Sr1NumReg <= 5'd0 ;
                Inst1Sr2AblReg <= `EnableValue ;
                Inst1Sr2NumReg <= 5'd0 ;
                Insr1WriteAReg <= `EnableValue ;
                Inst1WriteNReg <= 5'd0 ;
                Inst1PartReg   <= `EnableValue ;
                Inst1NadrReg   <= `ZeorDate ;
                Inst1AddrReg   <= `ZeorDate ;
            end
            if(InInstPort)begin
                Inst1OpcodeReg <= Inst1OperateCode ;
                Inst1SinumAReg <= Inst1ImmAble     ;
                Inst1SiDateReg <= Inst1ImmDate     ;
                Inst1Sr1AblReg <= Inst1rjAble      ;
                Inst1Sr1NumReg <= Inst1Src1Addr    ;
                Inst1Sr2AblReg <= Inst1rkAble      ;
                Inst1Sr2NumReg <= Inst1Src2addr    ;
                Insr1WriteAReg <= Inst1rdAble      ;
                Inst1WriteNReg <= Inst1RdAddr      ;
                Inst1PartReg   <= InInstPart       ;
                Inst1NadrReg   <= InInstNAdr       ;
                Inst1AddrReg   <= InInstAddr       ;
            end
        end
    end

    assign InstAddr   = Inst1AddrReg   ;
    assign InstOpcode = Inst1OpcodeReg ;
    assign InstSinumA = Inst1SinumAReg ;
    assign InstSiDate = Inst1SiDateReg ;
    assign InstSr1Abl = Inst1Sr1AblReg ;
    assign InstSr1Num = Inst1Sr1NumReg ; 
    assign InstSr2Abl = Inst1Sr2AblReg ;
    assign InstSr2Num = Inst1Sr2NumReg ;
    assign InsrWriteA = Insr1WriteAReg ;
    assign InstWriteN = Inst1WriteNReg ;
    assign InstPart   = Inst1PartReg   ;
    assign InstNadr   = Inst1NadrReg   ;
    
endmodule
