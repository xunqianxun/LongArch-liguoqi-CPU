// All 
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
`define InstMulw       8'h00000001
`define InstMulHw      8'h00000010
`define InstMulHuw     8'h00000011  
`define InstAddw       8'b00000100
`define InstSubw       8'b00000101
`define InstAddiw      8'b00000110
`define InstLu12iw     8'b00000111
`define InstSlt        8'b00001000
`define InstSltu       8'b00001001
`define InstSlti       8'b00001010
`define InstSltui      8'b00001011
`define InstAddu12i    8'b00001100
`define InstAnd        8'b00001101 
`define InstOr         8'b00001110 
`define InstNor        8'b00001111
`define InstXor        8'b00010000 
`define InstAndi       8'b00010001 
`define InstOri        8'b00010010 
`define InstXori       8'b00010011 
`define InstSllw       8'b00010100 
`define InstSrlw       8'b00010101 
`define InstSraw       8'b00010110 
`define InstSlliw      8'b00010111 
`define InstSrliw      8'b00011000 
`define InstSraiw      8'b00011001 
`define InstBeq        8'b00011010 
`define InstBne        8'b00011011 
`define InstBlt        8'b00011100 
`define InstBge        8'b00011101 
`define InstBltu       8'b00011110 
`define InstBgeu       8'b00011111 
`define InstB          8'b00100000 
`define InstBl         8'b00100001 
`define InstJirl       8'b00100010 
`define InstDivw       8'b00100011 
`define InstDivwu      8'b00100100 
`define InstModw       8'b00100101 
`define InstModwu      8'b00100110 
`define InstCsrrd      8'b00100111 
`define InstSyscall    8'b00101000
`define InstBreak      8'b00101001 
`define InstCsrwr     8'b00101000 
`define InstCsrxchg   8'b00101001 
`define InstCacop      8'b00101010 
//inst divid
`define InstTlbsrchr   8'b00101011 
`define InstTlbsrchw   8'b10000010
`define InstTlbrd     8'b00101100 
`define InstTlbwr      8'b00110001 
`define InstTlbfill    8'b00101101 
`define InstInvtlb     8'b00101110 
`define InstEntry      8'b00101111 
`define InstIdle       8'b00110000 



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
`define FetchInstBus   127:0
`define TypeCALL       3'b000 
`define TypeRTURN      3'b001 
`define TypeDIRECTB    3'b010 
`define TypeBRANCH     3'b011 
`define TypeFALT       3'b111
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


