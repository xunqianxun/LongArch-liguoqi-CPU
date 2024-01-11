// All 
`define InstAddrBus        31:0
`define TwoInstAddrBus     31:0*2
`define InstDateBus        31:0
`define TwoInstDateBus     31:0*2 

//if stage
`define StartAddr       32'h0000*2

//Multiplier
`define DataBus         31:0
`define MulDateTempt    34:0
`define MicOperateCode  7:0
`define MulStateBus     2:0
`define MulIdle         3'b000
`define MulBooth        3'b001
`define L1MulWallec     3'b010
`define L2MulWallec     3'b011
`define L3MulWallec     3'b100 
`define L4MulWallec     3'b101 



