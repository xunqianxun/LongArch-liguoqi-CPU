// All 
`define _Entry         32'h80000000
`define InstAddrBus        31:0
`define TwoInstAddrBus     31:0*2
`define InstDateBus        31:0
`define TwoInstDateBus     31:0*2 
`define AbleValue          1'b1 
`define EnableValue        1'b0
`define ZeroBoothDate   68'h0
`define ZeorDate        32'h0
`define FzeroDate       64'h0

//if stage
`define StartAddr       32'h0000*2

//Multiplier
`define DataBus         31:0
`define MulDateTempt    34:0
`define MicOperateCode  7:0
`define MulStateBus     2:0
`define MulIdle         3'b000
`define L1MulWallec     3'b010
`define L2MulWallec     3'b011
`define L3MulWallec     3'b100 
`define MulOutDate      3'b101 
`define MulBoothBus     32:0
// `define BoothCodeBus    2:0
// `define BoothCodeP0     3'b000
// `define BoothCodep1     3'b001 
// `define BoothCodeP2     3'b010 
// `define BoothCoden1     3'b011    
// `define BoothCoden2     3'b100

//Decode Mic Operate
`define ReNameRegBUs   6:0
`define ArchRegBUs     4:0

`define InstRdcntid    8'b00100001 
`define InstRdcntvlw   8'b00100010 
`define InstRdcntvhw   8'b00100011 
`define InstAddw       8'b00100100 
`define InstSubw       8'b00100101 
`define InstSlt        8'b00100110 
`define InstSltu       8'b00100111
`define InstNor        8'b00101000 
`define InstAnd        8'b00101001 
`define InstOr         8'b00101010 
`define InstXor        8'b00101011 
`define InstSllw       8'b00101100 
`define InstSrlw       8'b00101101
`define InstSraw       8'b00101110 
`define InstMulw       8'b01100001
`define InstMulHw      8'b01100010
`define InstMulHuw     8'b01100011 
`define InstDivw       8'b01000001
`define InstModw       8'b01000010
`define InstDivwu      8'b01000011 
`define InstModwu      8'b01000100
`define InstBreak      8'b10000001
`define InstSyscall    8'b10000010 
`define InstSlliw      8'b00101111  
`define InstSrliw      8'b00110000 
`define InstSraiw      8'b00110001 
`define InstSlti       8'b00110010 
`define InstSltui      8'b00110011 
`define InstAddiw      8'b00110100  
`define InstAndi       8'b00110101 
`define InstOri        8'b00110110 
`define InstXori       8'b00110111 
`define InstCsrrd      8'b10000011 
`define InstCsrwr      8'b10000100 
`define InstCsrxchg    8'b10000101 
`define InstCacop      8'b11000001 
`define InstTlbsrch    8'b10000110 
`define InstTlbrd      8'b10000111  
`define InstTlbwr      8'b10001000 
`define InstTlbfill    8'b10001001 
`define InstEntry      8'b10001010 
`define InstIdle       8'b10001011 
`define InstInvtlb     8'b10001100 
`define InstLu12iw     8'b00111000 
`define InstAddu12i    8'b00111001
`define InstLlw        8'b10100001
`define InstScw        8'b10110001 
`define InstLdb        8'b10100010 
`define InstLdh        8'b10100011 
`define InstLdw        8'b10100100 
`define InstStb        8'b10110010
`define InstSth        8'b10110011  
`define InstStw        8'b10110100
`define InstLdbu       8'b10100101
`define InstLdhu       8'b10100110 
`define InstJirl       8'b11100001
`define InstB          8'b11100010  
`define InstBl         8'b11100011 
`define InstBeq        8'b11100100 
`define InstBne        8'b11100101
`define InstBlt        8'b11100110 
`define InstBge        8'b11100111
`define InstBltu       8'b11101000 
`define InstBgeu       8'b11101001 
`define InstPreld      8'b00000001
`define InstDbar       8'b00000010 
`define InstIbar       8'b00000011 

//Flot alu module
`define FlotRNE        2'd0
`define FLotRZ         2'd1
`define FlotRP         2'd2 
`define FlotRM         2'd3 

//for div
`define PosiQuit2      3'b000
`define PosiQuit1      3'b001 
`define ZeroQuit0      3'b010 
`define NegiQuit1      3'b011 
`define NegiQuit2      3'b100

`define DivIdle        3'b001 
`define DivItir        3'b010
`define DivOut         3'b100 

//for BTB
`define BTBTageBus     18:0

//for Tage
`define TageGHRBus     63:0

//for pre decode state
`define TypeCALL       3'b100
`define TypeRTURN      3'b001 
`define TypeDIRECTB    3'b010 
`define TypeBRANCH     3'b011 
`define TypeFORMAL     3'b000
`define JumpAble       1'b1 
`define JumpEnbale     1'b0  

//for Csr
`define CsrWMaskAll    32'hffffffff

//for ROB 
`define ROBLineNumBus  6:0

//for csr
`define PLV  1:0
`define IE   2:2
`define DA   3:3
`define PG   4:4 
`define DATF 6:5
`define DATM 8:7
`define SAVE 31:9
`define PPLV 1:0
`define PIE  2:2

`define INT  7'h0 
`define PIL  7'h1
`define PIS  7'h2
`define PIF  7'h3 
`define PME  7'h4 
`define PPI  7'h7 
`define ADEF {1'b0, 6'h8} 
`define ADEM {1'b1, 6'h8}
`define ALE  7'h9 
`define SYS  7'hb 
`define BRK  7'hc 
`define INE  7'hd 
`define IPE  7'he 
`define FPD  7'hf 
`define FPE  7'h12 
`define TLBR 7'h3f

`define IS1_0   1:0
`define IS9_2   9:2 
`define IS11    11:11
`define IS12    12:12
`define ECODE   21:16
`define ESUBCODE 30:22

`define ROLLB 0
`define WCLLB 1
`define KLO   2

`define INDEX 5:0
`define PS    29:24
`define NE    31

`define EN    0
`define PERIODIC 1
`define INITVAL 31:2

`define CLR 0

`define ALUCODE 3'b001 
`define MULCODE 3'b011
`define DIVCODE 3'b010 
`define BRCODE  3'b111 
`define CSRCODE 3'b100
`define LSUCODE 3'b101 
`define SPECIAL 3'b000

