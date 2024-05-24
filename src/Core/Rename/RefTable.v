`timescale 1ps/1ps
`include "../define.v"

module RefTable (
    input       wire                                    Clk              ,
    input       wire                                    Rest             ,
    //from 
    input       wire                                    RefTableStop     ,
    input       wire                                    RefTableFLash    ,
    //from RAT 
    input       wire                                    Inst1Src1Able    ,
    input       wire      [`ReNameRegBUs]               Inst1Src1Addr    ,
    input       wire                                    Inst1Src2Able    ,
    input       wire      [`ReNameRegBUs]               Inst1Src2Addr    ,
    input       wire                                    Inst1RdAble      ,
    input       wire      [`ReNameRegBUs]               Inst1RdAddr      ,
    input       wire                                    Inst2Src1Able    ,
    input       wire      [`ReNameRegBUs]               Inst2Src1Addr    ,
    input       wire                                    Inst2Src2Able    ,
    input       wire      [`ReNameRegBUs]               Inst2Src2Addr    ,
    input       wire                                    Inst2RdAble      ,
    input       wire      [`ReNameRegBUs]               Inst2RdAddr      ,
    input       wire                                    Inst3Src1Able    ,
    input       wire      [`ReNameRegBUs]               Inst3Src1Addr    ,
    input       wire                                    Inst3Src2Able    ,
    input       wire      [`ReNameRegBUs]               Inst3Src2Addr    ,
    input       wire                                    Inst3RdAble      ,
    input       wire      [`ReNameRegBUs]               Inst3RdAddr      ,
    input       wire                                    Inst4Src1Able    ,
    input       wire      [`ReNameRegBUs]               Inst4Src1Addr    ,
    input       wire                                    Inst4Src2Able    ,
    input       wire      [`ReNameRegBUs]               Inst4Src2Addr    ,
    input       wire                                    Inst4RdAble      ,
    input       wire      [`ReNameRegBUs]               Inst4RdAddr      ,
    input       wire                                    Lock1Able        ,
    input       wire      [`ReNameRegBUs]               Lock1Addr        ,
    input       wire                                    Lock2Able        ,
    input       wire      [`ReNameRegBUs]               Lock2Addr        ,
    input       wire                                    Lock3Able        ,
    input       wire      [`ReNameRegBUs]               Lock3Addr        ,
    input       wire                                    Lock4Able        ,
    input       wire      [`ReNameRegBUs]               Lock4Addr        ,
    //from Physical Regfiles
    input       wire                                    Inst1Read1Able   ,
    input       wire      [`ReNameRegBUs]               Inst1Read1Addr   ,
    input       wire                                    Inst1Read2Able   ,
    input       wire      [`ReNameRegBUs]               Inst1Read2Addr   ,   
    input       wire                                    Inst2Read1Able   ,
    input       wire      [`ReNameRegBUs]               Inst2Read1Addr   ,
    input       wire                                    Inst2Read2Able   ,
    input       wire      [`ReNameRegBUs]               Inst2Read2Addr   ,
    input       wire                                    Inst3Read1Able   ,
    input       wire      [`ReNameRegBUs]               Inst3Read1Addr   ,
    input       wire                                    Inst3Read2Able   ,
    input       wire      [`ReNameRegBUs]               Inst3Read2Addr   ,
    input       wire                                    Inst4Read1Able   ,
    input       wire      [`ReNameRegBUs]               Inst4Read1Addr   ,
    input       wire                                    Inst4Read2Able   ,
    input       wire      [`ReNameRegBUs]               Inst4Read2Addr   ,     
    input       wire                                    WritBack1Able    ,
    input       wire      [`ReNameRegBUs]               WritBack1Addr    ,      
    input       wire                                    WritBack2Able    ,
    input       wire      [`ReNameRegBUs]               WritBack2Addr    ,                      
    input       wire                                    WritBack3Able    ,
    input       wire      [`ReNameRegBUs]               WritBack3Addr    ,    
    input       wire                                    WritBack4Able    ,
    input       wire      [`ReNameRegBUs]               WritBack4Addr    ,    
    input       wire                                    WritBack5Able    ,
    input       wire      [`ReNameRegBUs]               WritBack5Addr    ,    
    input       wire                                    WritBack6Able    ,
    input       wire      [`ReNameRegBUs]               WritBack6Addr    ,    
    input       wire                                    WritBack7Able    ,
    input       wire      [`ReNameRegBUs]               WritBack7Addr    ,    
    input       wire                                    WritBack8Able    ,
    input       wire      [`ReNameRegBUs]               WritBack8Addr    ,
    //to Freelist
    output      wire      [`ReNameRegBUs]               WriteNum1        ,
    output      wire                                    WriteAble1       ,
    output      wire      [`ReNameRegBUs]               WriteNum2        ,
    output      wire                                    WriteAble2       ,
    output      wire      [`ReNameRegBUs]               WriteNum3        ,
    output      wire                                    WriteAble3       ,
    output      wire      [`ReNameRegBUs]               WriteNum4        ,
    output      wire                                    WriteAble4       
);
    reg           REFLOCK       [0:127] ;
    reg    [6:0]  REFTABLEUSE   [0:127] ;
    reg    [6:0]  REFTABLEUNUSE [0:127] ;

    wire [7:0] Index1Unuse = ({8{(REFLOCK[0])  & (REFTABLEUSE[0] == REFTABLEUNUSE[0])}}   & {1'b1,7'd0})  |
                             ({8{(REFLOCK[4])  & (REFTABLEUSE[4] == REFTABLEUNUSE[4])}}   & {1'b1,7'd4})  | 
                             ({8{(REFLOCK[8])  & (REFTABLEUSE[8] == REFTABLEUNUSE[8])}}   & {1'b1,7'd8})  | 
                             ({8{(REFLOCK[12]) & (REFTABLEUSE[12] == REFTABLEUNUSE[12])}} & {1'b1,7'd12}) | 
                             ({8{(REFLOCK[16]) & (REFTABLEUSE[16] == REFTABLEUNUSE[16])}} & {1'b1,7'd16}) | 
                             ({8{(REFLOCK[20]) & (REFTABLEUSE[20] == REFTABLEUNUSE[20])}} & {1'b1,7'd20}) | 
                             ({8{(REFLOCK[24]) & (REFTABLEUSE[24] == REFTABLEUNUSE[24])}} & {1'b1,7'd24}) | 
                             ({8{(REFLOCK[28]) & (REFTABLEUSE[28] == REFTABLEUNUSE[28])}} & {1'b1,7'd28}) | 
                             ({8{(REFLOCK[32]) & (REFTABLEUSE[32] == REFTABLEUNUSE[32])}} & {1'b1,7'd32}) | 
                             ({8{(REFLOCK[36]) & (REFTABLEUSE[36] == REFTABLEUNUSE[36])}} & {1'b1,7'd36}) | 
                             ({8{(REFLOCK[40]) & (REFTABLEUSE[40] == REFTABLEUNUSE[40])}} & {1'b1,7'd40}) | 
                             ({8{(REFLOCK[44]) & (REFTABLEUSE[44] == REFTABLEUNUSE[44])}} & {1'b1,7'd44}) | 
                             ({8{(REFLOCK[48]) & (REFTABLEUSE[48] == REFTABLEUNUSE[48])}} & {1'b1,7'd48}) | 
                             ({8{(REFLOCK[52]) & (REFTABLEUSE[52] == REFTABLEUNUSE[52])}} & {1'b1,7'd52}) | 
                             ({8{(REFLOCK[56]) & (REFTABLEUSE[56] == REFTABLEUNUSE[56])}} & {1'b1,7'd56}) | 
                             ({8{(REFLOCK[60]) & (REFTABLEUSE[60] == REFTABLEUNUSE[60])}} & {1'b1,7'd60}) | 
                             //{8{(REFLOCK[64]) & (REFTABLEUSE[64] == REFTABLEUNUSE[64])}} & {1'b1,7'd64} | 
                             ({8{(REFLOCK[64]) & (REFTABLEUSE[64] == REFTABLEUNUSE[64])}} & {1'b1,7'd64}) | 
                             ({8{(REFLOCK[68]) & (REFTABLEUSE[68] == REFTABLEUNUSE[68])}} & {1'b1,7'd68}) | 
                             ({8{(REFLOCK[72]) & (REFTABLEUSE[72] == REFTABLEUNUSE[72])}} & {1'b1,7'd72}) | 
                             ({8{(REFLOCK[76]) & (REFTABLEUSE[76] == REFTABLEUNUSE[76])}} & {1'b1,7'd76}) | 
                             ({8{(REFLOCK[80]) & (REFTABLEUSE[80] == REFTABLEUNUSE[80])}} & {1'b1,7'd80}) | 
                             ({8{(REFLOCK[84]) & (REFTABLEUSE[84] == REFTABLEUNUSE[84])}} & {1'b1,7'd84}) | 
                             ({8{(REFLOCK[88]) & (REFTABLEUSE[88] == REFTABLEUNUSE[88])}} & {1'b1,7'd88}) | 
                             ({8{(REFLOCK[92]) & (REFTABLEUSE[92] == REFTABLEUNUSE[92])}} & {1'b1,7'd92}) | 
                             ({8{(REFLOCK[96]) & (REFTABLEUSE[96] == REFTABLEUNUSE[96])}} & {1'b1,7'd96}) | 
                             ({8{(REFLOCK[100]) & (REFTABLEUSE[100] == REFTABLEUNUSE[100])}} & {1'b1,7'd100}) | 
                             ({8{(REFLOCK[104]) & (REFTABLEUSE[104] == REFTABLEUNUSE[104])}} & {1'b1,7'd104}) | 
                             ({8{(REFLOCK[108]) & (REFTABLEUSE[108] == REFTABLEUNUSE[108])}} & {1'b1,7'd108}) | 
                             ({8{(REFLOCK[112]) & (REFTABLEUSE[112] == REFTABLEUNUSE[112])}} & {1'b1,7'd112}) | 
                             ({8{(REFLOCK[116]) & (REFTABLEUSE[116] == REFTABLEUNUSE[116])}} & {1'b1,7'd116}) | 
                             ({8{(REFLOCK[120]) & (REFTABLEUSE[120] == REFTABLEUNUSE[120])}} & {1'b1,7'd120}) | 
                             ({8{(REFLOCK[124]) & (REFTABLEUSE[124] == REFTABLEUNUSE[124])}} & {1'b1,7'd124}) ;
    wire [7:0] Index2Unuse = ({8{(REFLOCK[1])  & (REFTABLEUSE[1] == REFTABLEUNUSE[1])}}   & {1'b1,7'd1})  | 
                             ({8{(REFLOCK[5])  & (REFTABLEUSE[5] == REFTABLEUNUSE[5])}}   & {1'b1,7'd5})  |  
                             ({8{(REFLOCK[9])  & (REFTABLEUSE[9] == REFTABLEUNUSE[9])}}   & {1'b1,7'd9})  | 
                             ({8{(REFLOCK[13]) & (REFTABLEUSE[13] == REFTABLEUNUSE[13])}} & {1'b1,7'd13}) | 
                             ({8{(REFLOCK[17]) & (REFTABLEUSE[17] == REFTABLEUNUSE[17])}} & {1'b1,7'd17}) | 
                             ({8{(REFLOCK[21]) & (REFTABLEUSE[21] == REFTABLEUNUSE[21])}} & {1'b1,7'd21}) | 
                             ({8{(REFLOCK[25]) & (REFTABLEUSE[25] == REFTABLEUNUSE[25])}} & {1'b1,7'd25}) | 
                             ({8{(REFLOCK[29]) & (REFTABLEUSE[29] == REFTABLEUNUSE[29])}} & {1'b1,7'd29}) | 
                             ({8{(REFLOCK[33]) & (REFTABLEUSE[33] == REFTABLEUNUSE[33])}} & {1'b1,7'd33}) | 
                             ({8{(REFLOCK[37]) & (REFTABLEUSE[37] == REFTABLEUNUSE[37])}} & {1'b1,7'd37}) | 
                             ({8{(REFLOCK[41]) & (REFTABLEUSE[41] == REFTABLEUNUSE[41])}} & {1'b1,7'd41}) | 
                             ({8{(REFLOCK[45]) & (REFTABLEUSE[45] == REFTABLEUNUSE[45])}} & {1'b1,7'd45}) | 
                             ({8{(REFLOCK[49]) & (REFTABLEUSE[49] == REFTABLEUNUSE[49])}} & {1'b1,7'd49}) | 
                             ({8{(REFLOCK[53]) & (REFTABLEUSE[53] == REFTABLEUNUSE[53])}} & {1'b1,7'd53}) | 
                             ({8{(REFLOCK[57]) & (REFTABLEUSE[57] == REFTABLEUNUSE[57])}} & {1'b1,7'd57}) | 
                             ({8{(REFLOCK[61]) & (REFTABLEUSE[61] == REFTABLEUNUSE[61])}} & {1'b1,7'd61}) | 
                             ({8{(REFLOCK[65]) & (REFTABLEUSE[65] == REFTABLEUNUSE[65])}} & {1'b1,7'd65}) | 
                             //{8{(REFLOCK[65]) & (REFTABLEUSE[65] == REFTABLEUNUSE[65])}} & {1'b1,7'd65} | 
                             ({8{(REFLOCK[69]) & (REFTABLEUSE[69] == REFTABLEUNUSE[69])}} & {1'b1,7'd69}) | 
                             ({8{(REFLOCK[73]) & (REFTABLEUSE[73] == REFTABLEUNUSE[73])}} & {1'b1,7'd73}) | 
                             ({8{(REFLOCK[77]) & (REFTABLEUSE[77] == REFTABLEUNUSE[77])}} & {1'b1,7'd77}) | 
                             ({8{(REFLOCK[81]) & (REFTABLEUSE[81] == REFTABLEUNUSE[81])}} & {1'b1,7'd81}) | 
                             ({8{(REFLOCK[85]) & (REFTABLEUSE[85] == REFTABLEUNUSE[85])}} & {1'b1,7'd85}) | 
                             ({8{(REFLOCK[89]) & (REFTABLEUSE[89] == REFTABLEUNUSE[89])}} & {1'b1,7'd89}) | 
                             ({8{(REFLOCK[93]) & (REFTABLEUSE[93] == REFTABLEUNUSE[93])}} & {1'b1,7'd93}) | 
                             ({8{(REFLOCK[97]) & (REFTABLEUSE[97] == REFTABLEUNUSE[97])}} & {1'b1,7'd97}) | 
                             ({8{(REFLOCK[101]) & (REFTABLEUSE[101] == REFTABLEUNUSE[101])}} & {1'b1,7'd101}) | 
                             ({8{(REFLOCK[105]) & (REFTABLEUSE[105] == REFTABLEUNUSE[105])}} & {1'b1,7'd105}) | 
                             ({8{(REFLOCK[109]) & (REFTABLEUSE[109] == REFTABLEUNUSE[109])}} & {1'b1,7'd109}) | 
                             ({8{(REFLOCK[113]) & (REFTABLEUSE[113] == REFTABLEUNUSE[113])}} & {1'b1,7'd113}) | 
                             ({8{(REFLOCK[117]) & (REFTABLEUSE[117] == REFTABLEUNUSE[117])}} & {1'b1,7'd117}) | 
                             ({8{(REFLOCK[121]) & (REFTABLEUSE[121] == REFTABLEUNUSE[121])}} & {1'b1,7'd121}) | 
                             ({8{(REFLOCK[125]) & (REFTABLEUSE[125] == REFTABLEUNUSE[125])}} & {1'b1,7'd125}) ;
    wire [7:0] Index3Unuse = ({8{(REFLOCK[2])  & (REFTABLEUSE[2] == REFTABLEUNUSE[2])}}   & {1'b1,7'd2})  | 
                             ({8{(REFLOCK[6])  & (REFTABLEUSE[6] == REFTABLEUNUSE[6])}}   & {1'b1,7'd6})  |  
                             ({8{(REFLOCK[10]) & (REFTABLEUSE[10] == REFTABLEUNUSE[10])}} & {1'b1,7'd10}) | 
                             ({8{(REFLOCK[14]) & (REFTABLEUSE[14] == REFTABLEUNUSE[14])}} & {1'b1,7'd14}) | 
                             ({8{(REFLOCK[18]) & (REFTABLEUSE[18] == REFTABLEUNUSE[18])}} & {1'b1,7'd18}) | 
                             ({8{(REFLOCK[22]) & (REFTABLEUSE[22] == REFTABLEUNUSE[22])}} & {1'b1,7'd22}) | 
                             ({8{(REFLOCK[26]) & (REFTABLEUSE[26] == REFTABLEUNUSE[26])}} & {1'b1,7'd26}) | 
                             ({8{(REFLOCK[30]) & (REFTABLEUSE[30] == REFTABLEUNUSE[30])}} & {1'b1,7'd30}) | 
                             ({8{(REFLOCK[34]) & (REFTABLEUSE[34] == REFTABLEUNUSE[34])}} & {1'b1,7'd34}) | 
                             ({8{(REFLOCK[38]) & (REFTABLEUSE[38] == REFTABLEUNUSE[38])}} & {1'b1,7'd38}) | 
                             ({8{(REFLOCK[42]) & (REFTABLEUSE[42] == REFTABLEUNUSE[42])}} & {1'b1,7'd42}) | 
                             ({8{(REFLOCK[46]) & (REFTABLEUSE[46] == REFTABLEUNUSE[46])}} & {1'b1,7'd46}) | 
                             ({8{(REFLOCK[50]) & (REFTABLEUSE[50] == REFTABLEUNUSE[50])}} & {1'b1,7'd50}) | 
                             ({8{(REFLOCK[54]) & (REFTABLEUSE[54] == REFTABLEUNUSE[54])}} & {1'b1,7'd54}) | 
                             ({8{(REFLOCK[58]) & (REFTABLEUSE[58] == REFTABLEUNUSE[58])}} & {1'b1,7'd58}) | 
                             ({8{(REFLOCK[62]) & (REFTABLEUSE[62] == REFTABLEUNUSE[62])}} & {1'b1,7'd62}) | 
                             //{8{(REFLOCK[66]) & (REFTABLEUSE[66] == REFTABLEUNUSE[66])}} & {1'b1,7'd66} | 
                             ({8{(REFLOCK[66]) & (REFTABLEUSE[66] == REFTABLEUNUSE[66])}} & {1'b1,7'd66}) | 
                             ({8{(REFLOCK[70]) & (REFTABLEUSE[70] == REFTABLEUNUSE[70])}} & {1'b1,7'd70}) | 
                             ({8{(REFLOCK[74]) & (REFTABLEUSE[74] == REFTABLEUNUSE[74])}} & {1'b1,7'd74}) | 
                             ({8{(REFLOCK[78]) & (REFTABLEUSE[78] == REFTABLEUNUSE[78])}} & {1'b1,7'd78}) | 
                             ({8{(REFLOCK[82]) & (REFTABLEUSE[82] == REFTABLEUNUSE[82])}} & {1'b1,7'd82}) | 
                             ({8{(REFLOCK[86]) & (REFTABLEUSE[86] == REFTABLEUNUSE[86])}} & {1'b1,7'd86}) | 
                             ({8{(REFLOCK[90]) & (REFTABLEUSE[90] == REFTABLEUNUSE[90])}} & {1'b1,7'd90}) | 
                             ({8{(REFLOCK[94]) & (REFTABLEUSE[94] == REFTABLEUNUSE[94])}} & {1'b1,7'd94}) | 
                             ({8{(REFLOCK[98]) & (REFTABLEUSE[98] == REFTABLEUNUSE[98])}} & {1'b1,7'd98}) | 
                             ({8{(REFLOCK[102]) & (REFTABLEUSE[102] == REFTABLEUNUSE[102])}} & {1'b1,7'd102}) | 
                             ({8{(REFLOCK[106]) & (REFTABLEUSE[106] == REFTABLEUNUSE[106])}} & {1'b1,7'd106}) | 
                             ({8{(REFLOCK[110]) & (REFTABLEUSE[110] == REFTABLEUNUSE[110])}} & {1'b1,7'd110}) | 
                             ({8{(REFLOCK[114]) & (REFTABLEUSE[114] == REFTABLEUNUSE[114])}} & {1'b1,7'd114}) | 
                             ({8{(REFLOCK[118]) & (REFTABLEUSE[118] == REFTABLEUNUSE[118])}} & {1'b1,7'd118}) | 
                             ({8{(REFLOCK[122]) & (REFTABLEUSE[122] == REFTABLEUNUSE[122])}} & {1'b1,7'd122}) | 
                             ({8{(REFLOCK[126]) & (REFTABLEUSE[126] == REFTABLEUNUSE[126])}} & {1'b1,7'd126}) ;
    wire [7:0] Index4Unuse = ({8{(REFLOCK[3])  & (REFTABLEUSE[3] == REFTABLEUNUSE[3])}}   & {1'b1,7'd3})  | 
                             ({8{(REFLOCK[7])  & (REFTABLEUSE[7] == REFTABLEUNUSE[7])}}   & {1'b1,7'd7})  |  
                             ({8{(REFLOCK[11]) & (REFTABLEUSE[11] == REFTABLEUNUSE[11])}} & {1'b1,7'd11}) | 
                             ({8{(REFLOCK[15]) & (REFTABLEUSE[15] == REFTABLEUNUSE[15])}} & {1'b1,7'd15}) | 
                             ({8{(REFLOCK[19]) & (REFTABLEUSE[19] == REFTABLEUNUSE[19])}} & {1'b1,7'd19}) | 
                             ({8{(REFLOCK[23]) & (REFTABLEUSE[23] == REFTABLEUNUSE[23])}} & {1'b1,7'd23}) | 
                             ({8{(REFLOCK[27]) & (REFTABLEUSE[27] == REFTABLEUNUSE[27])}} & {1'b1,7'd27}) | 
                             ({8{(REFLOCK[31]) & (REFTABLEUSE[31] == REFTABLEUNUSE[31])}} & {1'b1,7'd31}) | 
                             ({8{(REFLOCK[35]) & (REFTABLEUSE[35] == REFTABLEUNUSE[35])}} & {1'b1,7'd35}) | 
                             ({8{(REFLOCK[39]) & (REFTABLEUSE[39] == REFTABLEUNUSE[39])}} & {1'b1,7'd39}) | 
                             ({8{(REFLOCK[43]) & (REFTABLEUSE[43] == REFTABLEUNUSE[43])}} & {1'b1,7'd43}) | 
                             ({8{(REFLOCK[47]) & (REFTABLEUSE[47] == REFTABLEUNUSE[47])}} & {1'b1,7'd47}) | 
                             ({8{(REFLOCK[51]) & (REFTABLEUSE[51] == REFTABLEUNUSE[51])}} & {1'b1,7'd51}) | 
                             ({8{(REFLOCK[55]) & (REFTABLEUSE[55] == REFTABLEUNUSE[55])}} & {1'b1,7'd55}) | 
                             ({8{(REFLOCK[59]) & (REFTABLEUSE[59] == REFTABLEUNUSE[59])}} & {1'b1,7'd59}) | 
                             ({8{(REFLOCK[63]) & (REFTABLEUSE[63] == REFTABLEUNUSE[63])}} & {1'b1,7'd63}) | 
                             //{8{(REFLOCK[67]) & (REFTABLEUSE[67] == REFTABLEUNUSE[67])}} & {1'b1,7'd67} | 
                             ({8{(REFLOCK[67]) & (REFTABLEUSE[67] == REFTABLEUNUSE[67])}} & {1'b1,7'd67}) | 
                             ({8{(REFLOCK[71]) & (REFTABLEUSE[71] == REFTABLEUNUSE[71])}} & {1'b1,7'd71}) | 
                             ({8{(REFLOCK[75]) & (REFTABLEUSE[75] == REFTABLEUNUSE[75])}} & {1'b1,7'd75}) | 
                             ({8{(REFLOCK[79]) & (REFTABLEUSE[79] == REFTABLEUNUSE[79])}} & {1'b1,7'd79}) | 
                             ({8{(REFLOCK[83]) & (REFTABLEUSE[83] == REFTABLEUNUSE[83])}} & {1'b1,7'd83}) | 
                             ({8{(REFLOCK[87]) & (REFTABLEUSE[87] == REFTABLEUNUSE[87])}} & {1'b1,7'd87}) | 
                             ({8{(REFLOCK[91]) & (REFTABLEUSE[91] == REFTABLEUNUSE[91])}} & {1'b1,7'd91}) | 
                             ({8{(REFLOCK[95]) & (REFTABLEUSE[95] == REFTABLEUNUSE[95])}} & {1'b1,7'd95}) | 
                             ({8{(REFLOCK[99]) & (REFTABLEUSE[99] == REFTABLEUNUSE[99])}} & {1'b1,7'd99}) | 
                             ({8{(REFLOCK[103]) & (REFTABLEUSE[103] == REFTABLEUNUSE[103])}} & {1'b1,7'd103}) | 
                             ({8{(REFLOCK[107]) & (REFTABLEUSE[107] == REFTABLEUNUSE[107])}} & {1'b1,7'd107}) | 
                             ({8{(REFLOCK[111]) & (REFTABLEUSE[111] == REFTABLEUNUSE[111])}} & {1'b1,7'd111}) | 
                             ({8{(REFLOCK[115]) & (REFTABLEUSE[115] == REFTABLEUNUSE[115])}} & {1'b1,7'd115}) | 
                             ({8{(REFLOCK[119]) & (REFTABLEUSE[119] == REFTABLEUNUSE[119])}} & {1'b1,7'd119}) | 
                             ({8{(REFLOCK[123]) & (REFTABLEUSE[123] == REFTABLEUNUSE[123])}} & {1'b1,7'd123}) | 
                             ({8{(REFLOCK[127]) & (REFTABLEUSE[127] == REFTABLEUNUSE[127])}} & {1'b1,7'd127}) ;

    wire                    ToFreelistAble1 ;
    wire  [`ReNameRegBUs]   TOFreeListDate1 ;
    wire                    ToFreelistAble2 ;
    wire  [`ReNameRegBUs]   TOFreeListDate2 ;
    wire                    ToFreelistAble3 ;
    wire  [`ReNameRegBUs]   TOFreeListDate3 ;
    wire                    ToFreelistAble4 ;
    wire  [`ReNameRegBUs]   TOFreeListDate4 ;

 

    assign {ToFreelistAble1,TOFreeListDate1} = Index1Unuse[7] ? Index1Unuse : 
                                               Index2Unuse[7] ? Index2Unuse : 
                                               Index3Unuse[7] ? Index3Unuse : 
                                               Index4Unuse[7] ? Index4Unuse : {`EnableValue, 7'd0} ;

    assign {ToFreelistAble2,TOFreeListDate2} = ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 3) ? Index2Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 5) ? Index3Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 6) ? Index3Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 7) ? Index2Unuse : 
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 9) ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 10) ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 11) ? Index2Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 12) ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 13) ? Index3Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 14) ? Index3Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 15) ? Index2Unuse :{`EnableValue, 7'd0} ;

    assign {ToFreelistAble3,TOFreeListDate3} = ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 7)   ? Index3Unuse : 
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 11)  ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 13)  ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 14)  ? Index4Unuse :
                                               ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 15)  ? Index3Unuse :{`EnableValue, 7'd0} ;

   assign {ToFreelistAble4,TOFreeListDate4} =  ({Index4Unuse[7],Index3Unuse[7],Index2Unuse[7],Index1Unuse[7]} == 15)  ? Index3Unuse :{`EnableValue, 7'd0} ;

    reg    [`ReNameRegBUs]     RegWriteNum1    ;
    reg                        RegWriteAble1   ;
    reg    [`ReNameRegBUs]     RegWriteNum2    ;
    reg                        RegWriteAble2   ;
    reg    [`ReNameRegBUs]     RegWriteNum3    ;
    reg                        RegWriteAble3   ;
    reg    [`ReNameRegBUs]     RegWriteNum4    ;
    reg                        RegWriteAble4   ;

    always @(posedge Clk) begin
        if(!Rest) begin
            RegWriteAble1 <= `EnableValue ;
            RegWriteNum1  <= 7'd0         ;
            RegWriteAble2 <= `EnableValue ;
            RegWriteNum2  <= 7'd0         ;
            RegWriteAble3 <= `EnableValue ;
            RegWriteNum3  <= 7'd0         ;
            RegWriteAble4 <= `EnableValue ;
            RegWriteNum4  <= 7'd0         ;
        end
        else if(RefTableFLash) begin
            RegWriteAble1 <= `EnableValue ;
            RegWriteNum1  <= 7'd0         ;
            RegWriteAble2 <= `EnableValue ;
            RegWriteNum2  <= 7'd0         ;
            RegWriteAble3 <= `EnableValue ;
            RegWriteNum3  <= 7'd0         ;
            RegWriteAble4 <= `EnableValue ;
            RegWriteNum4  <= 7'd0         ;
        end 
        else begin
           RegWriteAble1 <= ~RefTableStop ? ToFreelistAble1 : `EnableValue ;
           RegWriteNum1  <= ~RefTableStop ? TOFreeListDate1 : 7'd0         ;
           RegWriteAble2 <= ~RefTableStop ? ToFreelistAble2 : `EnableValue ;
           RegWriteNum2  <= ~RefTableStop ? TOFreeListDate2 : 7'd0         ;
           RegWriteAble3 <= ~RefTableStop ? ToFreelistAble3 : `EnableValue ;
           RegWriteNum3  <= ~RefTableStop ? TOFreeListDate3 : 7'd0         ;
           RegWriteAble4 <= ~RefTableStop ? ToFreelistAble4 : `EnableValue ;
           RegWriteNum4  <= ~RefTableStop ? TOFreeListDate4 : 7'd0         ;
        end
    end

    assign WriteAble1 = RegWriteAble1 ;
    assign WriteNum1  = RegWriteNum1  ;
    assign WriteAble2 = RegWriteAble2 ;
    assign WriteNum2  = RegWriteNum2  ;
    assign WriteAble3 = RegWriteAble3 ;
    assign WriteNum3  = RegWriteNum3  ;
    assign WriteAble4 = RegWriteAble4 ;
    assign WriteNum4  = RegWriteNum4  ;



// complier use --unroll-stmts 100000
    integer i ;
    integer j ;
    always @(posedge Clk) begin
        if(!Rest) begin
            for (i = 0; i<32;i=i+1 ) begin
                REFTABLEUSE[i] <= 7'd0 ;
                REFLOCK    [i] <= 1'b0 ;
                REFTABLEUSE[i+32] <= 7'd0 ;
                REFLOCK    [i+32] <= 1'b0 ;
                REFTABLEUSE[i+64] <= 7'd0 ;
                REFLOCK    [i+64] <= 1'b0 ;
                REFTABLEUSE[i+96] <= 7'd0 ;
                REFLOCK    [i+96] <= 1'b0 ;
            end
        end
        else if(RefTableFLash) begin
            for (j = 0; j<32;j=j+1 ) begin
                REFTABLEUSE[i] <= 7'd0 ;
                REFLOCK    [i] <= 1'b0 ;
                REFTABLEUSE[i+32] <= 7'd0 ;
                REFLOCK    [i+32] <= 1'b0 ;
                REFTABLEUSE[i+64] <= 7'd0 ;
                REFLOCK    [i+64] <= 1'b0 ;
                REFTABLEUSE[i+96] <= 7'd0 ;
                REFLOCK    [i+96] <= 1'b0 ;
            end
        end
        else begin
            REFTABLEUSE[Inst1Src1Addr] <= (Inst1Src1Able  )? REFTABLEUSE[Inst1Src1Addr] + 1 : REFTABLEUSE[Inst1Src1Addr] ;
            REFTABLEUSE[Inst1Src2Addr] <= (Inst1Src2Able  )? REFTABLEUSE[Inst1Src2Addr] + 1 : REFTABLEUSE[Inst1Src2Addr] ;
            REFTABLEUSE[Inst2Src1Addr] <= (Inst2Src1Able  ) ? REFTABLEUSE[Inst2Src1Addr] + 1 : REFTABLEUSE[Inst2Src1Addr] ;
            REFTABLEUSE[Inst2Src2Addr] <= (Inst2Src2Able  ) ? REFTABLEUSE[Inst2Src2Addr] + 1 : REFTABLEUSE[Inst2Src2Addr] ;
            REFTABLEUSE[Inst3Src1Addr] <= (Inst3Src1Able  ) ? REFTABLEUSE[Inst3Src1Addr] + 1 : REFTABLEUSE[Inst3Src1Addr] ;
            REFTABLEUSE[Inst3Src2Addr] <= (Inst3Src2Able  ) ? REFTABLEUSE[Inst3Src2Addr] + 1 : REFTABLEUSE[Inst3Src2Addr] ;
            REFTABLEUSE[Inst4Src1Addr] <= (Inst4Src1Able  )  ? REFTABLEUSE[Inst4Src1Addr] + 1 : REFTABLEUSE[Inst4Src1Addr] ;
            REFTABLEUSE[Inst4Src2Addr] <= (Inst4Src2Able  ) ? REFTABLEUSE[Inst4Src2Addr] + 1 : REFTABLEUSE[Inst4Src2Addr] ;
            REFTABLEUSE[Inst1RdAddr]   <= (Inst1RdAble )   ? REFTABLEUSE[Inst1RdAddr]   + 1 : REFTABLEUSE[Inst1RdAddr]   ;
            REFTABLEUSE[Inst2RdAddr]   <= (Inst2RdAble )   ? REFTABLEUSE[Inst2RdAddr]   + 1 : REFTABLEUSE[Inst2RdAddr]   ;
            REFTABLEUSE[Inst3RdAddr]   <= (Inst3RdAble )   ? REFTABLEUSE[Inst3RdAddr]   + 1 : REFTABLEUSE[Inst3RdAddr]   ;
            REFTABLEUSE[Inst4RdAddr]   <= (Inst4RdAble )   ? REFTABLEUSE[Inst4RdAddr]   + 1 : REFTABLEUSE[Inst4RdAddr]   ;
            REFLOCK    [Lock1Addr]     <= (Lock1Able   )     ? REFLOCK    [Lock1Addr]     + 1 : REFLOCK    [Lock1Addr]     ;
            REFLOCK    [Lock2Addr]     <= (Lock2Able   )     ? REFLOCK    [Lock2Addr]     + 1 : REFLOCK    [Lock2Addr]     ;
            REFLOCK    [Lock3Addr]     <= (Lock3Able   )     ? REFLOCK    [Lock3Addr]     + 1 : REFLOCK    [Lock3Addr]     ;
            REFLOCK    [Lock4Addr]     <= (Lock4Able   )     ? REFLOCK    [Lock4Addr]     + 1 : REFLOCK    [Lock4Addr]     ;
            REFLOCK    [Index1Unuse[6:0]]   <=  (Index1Unuse[7] ) ? `EnableValue : REFLOCK    [Index1Unuse[6:0]]  ;
            REFTABLEUSE[Index1Unuse[6:0]]   <=  (Index1Unuse[7] ) ? 7'd0         : REFTABLEUSE[Index1Unuse[6:0]]  ;
            REFLOCK    [Index2Unuse[6:0]]   <=  (Index2Unuse[7] ) ? `EnableValue : REFLOCK    [Index2Unuse[6:0]]  ;
            REFTABLEUSE[Index2Unuse[6:0]]   <=  (Index2Unuse[7] ) ? 7'd0         : REFTABLEUSE[Index2Unuse[6:0]]  ;
            REFLOCK    [Index3Unuse[6:0]]   <=  (Index3Unuse[7] ) ? `EnableValue : REFLOCK    [Index3Unuse[6:0]]  ;
            REFTABLEUSE[Index3Unuse[6:0]]   <=  (Index3Unuse[7] ) ? 7'd0         : REFTABLEUSE[Index3Unuse[6:0]]  ;
            REFLOCK    [Index4Unuse[6:0]]   <=  (Index4Unuse[7] ) ? `EnableValue : REFLOCK    [Index4Unuse[6:0]]  ;
            REFTABLEUSE[Index4Unuse[6:0]]   <=  (Index4Unuse[7] ) ? 7'd0         : REFTABLEUSE[Index4Unuse[6:0]]  ;
        end 
        
    end

    always @(posedge Clk) begin
        if(!Rest) begin
            for (i = 0; i<32;i=i+1 ) begin
                REFTABLEUNUSE[i] <= 7'd0 ;
                REFTABLEUNUSE[i+32] <= 7'd0 ;
                REFTABLEUNUSE[i+64] <= 7'd0 ;
                REFTABLEUNUSE[i+96] <= 7'd0 ;
            end
        end
        else if(RefTableFLash) begin
           for (j = 0; j<32;j=j+1 ) begin
                REFTABLEUNUSE[i] <= 7'd0 ;
                REFTABLEUNUSE[i+32] <= 7'd0 ;
                REFTABLEUNUSE[i+64] <= 7'd0 ;
                REFTABLEUNUSE[i+96] <= 7'd0 ;
            end 
        end
        else begin
            REFTABLEUNUSE[Inst1Read1Addr] <= (Inst1Read1Able ) ? REFTABLEUNUSE[Inst1Read1Addr] + 1 : REFTABLEUNUSE[Inst1Read1Addr] ;
            REFTABLEUNUSE[Inst1Read2Addr] <= (Inst1Read2Able ) ? REFTABLEUNUSE[Inst1Read2Addr] + 1 : REFTABLEUNUSE[Inst1Read2Addr] ;
            REFTABLEUNUSE[Inst2Read1Addr] <= (Inst2Read1Able ) ? REFTABLEUNUSE[Inst2Read1Addr] + 1 : REFTABLEUNUSE[Inst2Read1Addr] ;
            REFTABLEUNUSE[Inst2Read2Addr] <= (Inst2Read2Able ) ? REFTABLEUNUSE[Inst2Read2Addr] + 1 : REFTABLEUNUSE[Inst2Read2Addr] ;
            REFTABLEUNUSE[Inst3Read1Addr] <= (Inst3Read1Able ) ? REFTABLEUNUSE[Inst3Read1Addr] + 1 : REFTABLEUNUSE[Inst3Read1Addr] ;
            REFTABLEUNUSE[Inst3Read2Addr] <= (Inst3Read2Able ) ? REFTABLEUNUSE[Inst3Read2Addr] + 1 : REFTABLEUNUSE[Inst3Read2Addr] ;
            REFTABLEUNUSE[Inst4Read1Addr] <= (Inst4Read1Able ) ? REFTABLEUNUSE[Inst4Read1Addr] + 1 : REFTABLEUNUSE[Inst4Read1Addr] ;
            REFTABLEUNUSE[Inst4Read2Addr] <= (Inst4Read2Able ) ? REFTABLEUNUSE[Inst4Read2Addr] + 1 : REFTABLEUNUSE[Inst4Read2Addr] ;
            REFTABLEUNUSE[WritBack1Addr]  <= (WritBack1Able ) ? REFTABLEUNUSE[WritBack1Addr]  + 1 : REFTABLEUNUSE[WritBack1Addr]  ;
            REFTABLEUNUSE[WritBack2Addr]  <= (WritBack2Able ) ? REFTABLEUNUSE[WritBack2Addr]  + 1 : REFTABLEUNUSE[WritBack2Addr]  ;
            REFTABLEUNUSE[WritBack3Addr]  <= (WritBack3Able ) ? REFTABLEUNUSE[WritBack3Addr]  + 1 : REFTABLEUNUSE[WritBack3Addr]  ;
            REFTABLEUNUSE[WritBack4Addr]  <= (WritBack4Able ) ? REFTABLEUNUSE[WritBack4Addr]  + 1 : REFTABLEUNUSE[WritBack4Addr]  ;
            REFTABLEUNUSE[WritBack5Addr]  <= (WritBack5Able ) ? REFTABLEUNUSE[WritBack5Addr]  + 1 : REFTABLEUNUSE[WritBack5Addr]  ;
            REFTABLEUNUSE[WritBack6Addr]  <= (WritBack6Able ) ? REFTABLEUNUSE[WritBack6Addr]  + 1 : REFTABLEUNUSE[WritBack6Addr]  ;
            REFTABLEUNUSE[WritBack7Addr]  <= (WritBack7Able ) ? REFTABLEUNUSE[WritBack7Addr]  + 1 : REFTABLEUNUSE[WritBack7Addr]  ;
            REFTABLEUNUSE[WritBack8Addr]  <= (WritBack8Able ) ? REFTABLEUNUSE[WritBack8Addr]  + 1 : REFTABLEUNUSE[WritBack8Addr]  ;
            REFTABLEUNUSE[Index1Unuse[6:0]] <= (Index1Unuse[7] ) ? 7'd0 : REFTABLEUNUSE[Index1Unuse[6:0]] ;
            REFTABLEUNUSE[Index2Unuse[6:0]] <= (Index2Unuse[7] ) ? 7'd0 : REFTABLEUNUSE[Index2Unuse[6:0]] ;
            REFTABLEUNUSE[Index3Unuse[6:0]] <= (Index3Unuse[7] ) ? 7'd0 : REFTABLEUNUSE[Index3Unuse[6:0]] ;
            REFTABLEUNUSE[Index4Unuse[6:0]] <= (Index4Unuse[7] ) ? 7'd0 : REFTABLEUNUSE[Index4Unuse[6:0]] ;
        end
    end

    
endmodule
