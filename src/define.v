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
`define ArchRegBUs     4:0
`define InstMulw       8'h00000001
`define InstMulhw      8'h00000010
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

//Flot alu module
`define FlotRNE        2'd0
`define FLotRZ         2'd1
`define FlotRP         2'd2 
`define FlotRM         2'd3 





