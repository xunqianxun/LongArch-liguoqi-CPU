`timescale 1ps/1ps
`include "../define.v"

module TlbEntry #(
    parameter TLBNUM = 64 
) (
    input        wire                                        Clk           ,
    input        wire                                        Rest          ,

    //inst search 
    //input        wire                                        S0Fetch       ,
    input        wire      [18:0]                            S0Vppn        ,
    input        wire                                        S0OddPage     ,
    input        wire      [ 9:0]                            S0Asid        ,
    output       wire                                        S0Fund        ,
    //output       wire      [$clog2(TLBNUM)-1:0]              S0Index       ,
    output       wire      [ 5:0]                            S0Ps          ,
    output       wire      [19:0]                            S0Ppn         ,
    output       wire                                        S0V           ,
    output       wire                                        S0D           ,
    output       wire      [ 1:0]                            S0Mat         ,
    output       wire      [ 1:0]                            S0Plv         ,
    //Load search 
    //input        wire                                        S1Fetch       ,
    input        wire      [18:0]                            S1Vppn        ,
    input        wire                                        S1OddPage     ,
    input        wire      [ 9:0]                            S1Asid        ,
    output       wire                                        S1Fund        ,
    //output       wire      [$clog2(TLBNUM)-1:0]              S1Index       ,
    output       wire      [ 5:0]                            S1Ps          ,
    output       wire      [19:0]                            S1Ppn         ,
    output       wire                                        S1V           ,
    output       wire                                        S1D           ,
    output       wire      [ 1:0]                            S1Mat         ,
    output       wire      [ 1:0]                            S1Plv         ,  
    //store search 
    //input        wire                                        S2Fetch       ,
    input        wire      [18:0]                            S2Vppn        ,
    input        wire                                        S2OddPage     ,
    input        wire      [ 9:0]                            S2Asid        ,
    output       wire                                        S2Fund        ,
    //output       wire      [$clog2(TLBNUM)-1:0]              S2Index       ,
    output       wire      [ 5:0]                            S2Ps          ,
    output       wire      [19:0]                            S2Ppn         ,
    output       wire                                        S2V           ,
    output       wire                                        S2D           ,
    output       wire      [ 1:0]                            S2Mat         ,
    output       wire      [ 1:0]                            S2Plv         , 
    //CSR serch
    //input        wire                                        CsrSerch      ,
    input        wire      [29-1:0]                          CsrSerchInfrom,
    output       wire                                        CsrSerchSucces,
    output       wire      [5:0]                             csrSerchDate  ,
    // write TLB
    input        wire                                        We            ,
    input        wire      [$clog2(TLBNUM)-1:0]              WIndex        ,
    input        wire      [18:0]                            WVppn         ,
    input        wire      [ 9:0]                            WAsid         ,
    input        wire                                        WG            ,
    input        wire      [ 5:0]                            WPs           ,
    input        wire                                        WE            ,
    input        wire                                        WV0           ,
    input        wire                                        WD0           ,
    input        wire      [ 1:0]                            WMat0         ,
    input        wire      [ 1:0]                            WPlv0         ,
    input        wire      [19:0]                            WPpn0         ,
    input        wire                                        WV1           ,
    input        wire                                        WD1           ,
    input        wire      [ 1:0]                            WMat1         ,
    input        wire      [ 1:0]                            WPlv1         ,
    input        wire      [19:0]                            WPpn1         ,
    // read TLB
    input        wire      [$clog2(TLBNUM)-1:0]              RIndex        ,
    output       wire      [18:0]                            RVppn         ,
    output       wire      [ 9:0]                            RAsid         ,
    output       wire                                        RG            ,
    output       wire      [ 5:0]                            RPs           ,
    output       wire                                        RE            ,
    output       wire                                        RV0           ,
    output       wire                                        RD0           ,
    output       wire      [ 1:0]                            RMat0         ,
    output       wire      [ 1:0]                            RPlv0         ,
    output       wire      [19:0]                            RPpn0         ,
    output       wire                                        RV1           ,
    output       wire                                        RD1           ,
    output       wire      [ 1:0]                            RMat1         ,
    output       wire      [ 1:0]                            RPlv1         ,
    output       wire      [19:0]                            RPpn1         ,
    //invable
    input        wire                                        InvEn         ,
    input        wire      [ 4:0]                            InvOp         ,
    input        wire      [ 9:0]                            InvAsid       ,
    input        wire      [18:0]                            InvVppn
);

    reg [18:0] TLBVPPN      [TLBNUM-1:0];
    reg        TLBE         [TLBNUM-1:0];
    reg [ 9:0] TLBASID      [TLBNUM-1:0];
    reg        TLBG         [TLBNUM-1:0];
    reg [ 5:0] TLBPS        [TLBNUM-1:0];
    reg [19:0] TLBPPN0      [TLBNUM-1:0];
    reg [ 1:0] TLBPLV0      [TLBNUM-1:0];
    reg [ 1:0] TLBMAT0      [TLBNUM-1:0];
    reg        TLBD0        [TLBNUM-1:0];
    reg        TLBV0        [TLBNUM-1:0];
    reg [19:0] TLBPPN1      [TLBNUM-1:0];
    reg [ 1:0] TLBPLV1      [TLBNUM-1:0]; 
    reg [ 1:0] TLBMAT1      [TLBNUM-1:0];
    reg        TLBD1        [TLBNUM-1:0];
    reg        TLBV1        [TLBNUM-1:0];

    wire [TLBNUM-1:0]       TwoChioseS0   ;
    wire [TLBNUM-1:0]       DateMatchS0   ;
    wire [TLBNUM-1:0]       TwoChioseS1   ;
    wire [TLBNUM-1:0]       DateMatchS1   ;
    wire [TLBNUM-1:0]       TwoChioseS2   ;
    wire [TLBNUM-1:0]       DateMatchS2   ;
    wire [TLBNUM-1:0]       DateMatchC0   ;
    //fror search 
    genvar i ;
    generate
        for (i =0 ;i< TLBNUM;i=i+1 ) begin
            assign TwoChioseS0[i] = (TLBPS[i] == 6'd12) ? S0OddPage : S0Vppn[8]; //0 mean odd 1 mean even
            assign DateMatchS0[i] = (TLBE[i] && (TLBPS[i] == 6'd12)) ? (TLBVPPN[i] == S0Vppn) : ((TLBVPPN[i][18:9] == S0Vppn[18:9]) && ((TLBASID[i] == S0Asid) || (TLBG)));
            assign TwoChioseS1[i] = (TLBPS[i] == 6'd12) ? S1OddPage : S1Vppn[8];
            assign DateMatchS1[i] = (TLBE[i] && (TLBPS[i] == 6'd12)) ? (TLBVPPN[i] == S1Vppn) : ((TLBVPPN[i][18:9] == S1Vppn[18:9]) && ((TLBASID[i] == S1Asid) || (TLBG)));
            assign TwoChioseS2[i] = (TLBPS[i] == 6'd12) ? S2OddPage : S2Vppn[8];
            assign DateMatchS2[i] = (TLBE[i] && (TLBPS[i] == 6'd12)) ? (TLBVPPN[i] == S2Vppn) : ((TLBVPPN[i][18:9] == S2Vppn[18:9]) && ((TLBASID[i] == S2Asid) || (TLBG)));
            assign DateMatchC0[i] = (TLBE[i] && (TLBPS[i] == 6'd12)) ? (TLBVPPN[i] == CsrSerchInfrom[18:0]) : ((TLBVPPN[i][18:9] == CsrSerchInfrom[18:9]) && ((TLBASID[i] == CsrSerchInfrom[28:19]) || (TLBG)));
        end
    endgenerate
    
    wire [$clog2(TLBNUM)-1:0] S0SearchIndex;
    wire [$clog2(TLBNUM)-1:0] S1SearchIndex;
    wire [$clog2(TLBNUM)-1:0] S2SearchIndex;
    wire [$clog2(TLBNUM)-1:0] C0SearchIndex;
    
    assign S0SearchIndex = ({6{DateMatchS0[0]}}  & 6'd0) | 
                           ({6{DateMatchS0[1]}}  & 6'd1) | 
                           ({6{DateMatchS0[2]}}  & 6'd2) | 
                           ({6{DateMatchS0[3]}}  & 6'd3) | 
                           ({6{DateMatchS0[4]}}  & 6'd4) | 
                           ({6{DateMatchS0[5]}}  & 6'd5) | 
                           ({6{DateMatchS0[6]}}  & 6'd6) | 
                           ({6{DateMatchS0[7]}}  & 6'd7) | 
                           ({6{DateMatchS0[8]}}  & 6'd8) | 
                           ({6{DateMatchS0[9]}}  & 6'd9) | 
                           ({6{DateMatchS0[10]}} & 6'd10)| 
                           ({6{DateMatchS0[11]}} & 6'd11)| 
                           ({6{DateMatchS0[12]}} & 6'd12)| 
                           ({6{DateMatchS0[13]}} & 6'd13)| 
                           ({6{DateMatchS0[14]}} & 6'd14)| 
                           ({6{DateMatchS0[15]}} & 6'd15)| 
                           ({6{DateMatchS0[16]}} & 6'd16)| 
                           ({6{DateMatchS0[17]}} & 6'd17)| 
                           ({6{DateMatchS0[18]}} & 6'd18)| 
                           ({6{DateMatchS0[19]}} & 6'd19)| 
                           ({6{DateMatchS0[20]}} & 6'd20)| 
                           ({6{DateMatchS0[21]}} & 6'd21)| 
                           ({6{DateMatchS0[22]}} & 6'd22)| 
                           ({6{DateMatchS0[23]}} & 6'd23)| 
                           ({6{DateMatchS0[24]}} & 6'd24)| 
                           ({6{DateMatchS0[25]}} & 6'd25)| 
                           ({6{DateMatchS0[26]}} & 6'd26)| 
                           ({6{DateMatchS0[27]}} & 6'd27)| 
                           ({6{DateMatchS0[28]}} & 6'd28)| 
                           ({6{DateMatchS0[29]}} & 6'd29)| 
                           ({6{DateMatchS0[30]}} & 6'd30)| 
                           ({6{DateMatchS0[31]}} & 6'd31)| 
                           ({6{DateMatchS0[32]}} & 6'd32)| 
                           ({6{DateMatchS0[33]}} & 6'd33)| 
                           ({6{DateMatchS0[34]}} & 6'd34)| 
                           ({6{DateMatchS0[35]}} & 6'd35)| 
                           ({6{DateMatchS0[36]}} & 6'd36)| 
                           ({6{DateMatchS0[37]}} & 6'd37)| 
                           ({6{DateMatchS0[38]}} & 6'd38)| 
                           ({6{DateMatchS0[39]}} & 6'd39)| 
                           ({6{DateMatchS0[40]}} & 6'd40)| 
                           ({6{DateMatchS0[41]}} & 6'd41)| 
                           ({6{DateMatchS0[42]}} & 6'd42)| 
                           ({6{DateMatchS0[43]}} & 6'd43)| 
                           ({6{DateMatchS0[44]}} & 6'd44)| 
                           ({6{DateMatchS0[45]}} & 6'd45)| 
                           ({6{DateMatchS0[46]}} & 6'd46)| 
                           ({6{DateMatchS0[47]}} & 6'd47)| 
                           ({6{DateMatchS0[48]}} & 6'd48)| 
                           ({6{DateMatchS0[49]}} & 6'd49)| 
                           ({6{DateMatchS0[50]}} & 6'd50)| 
                           ({6{DateMatchS0[51]}} & 6'd51)| 
                           ({6{DateMatchS0[52]}} & 6'd52)| 
                           ({6{DateMatchS0[53]}} & 6'd53)| 
                           ({6{DateMatchS0[54]}} & 6'd54)| 
                           ({6{DateMatchS0[55]}} & 6'd55)| 
                           ({6{DateMatchS0[56]}} & 6'd56)| 
                           ({6{DateMatchS0[57]}} & 6'd57)| 
                           ({6{DateMatchS0[58]}} & 6'd58)| 
                           ({6{DateMatchS0[59]}} & 6'd59)| 
                           ({6{DateMatchS0[60]}} & 6'd60)| 
                           ({6{DateMatchS0[61]}} & 6'd61)| 
                           ({6{DateMatchS0[62]}} & 6'd62)| 
                           ({6{DateMatchS0[63]}} & 6'd63); 

    assign S1SearchIndex = ({6{DateMatchS1[0]}}  & 6'd0) | 
                           ({6{DateMatchS1[1]}}  & 6'd1) | 
                           ({6{DateMatchS1[2]}}  & 6'd2) | 
                           ({6{DateMatchS1[3]}}  & 6'd3) | 
                           ({6{DateMatchS1[4]}}  & 6'd4) | 
                           ({6{DateMatchS1[5]}}  & 6'd5) | 
                           ({6{DateMatchS1[6]}}  & 6'd6) | 
                           ({6{DateMatchS1[7]}}  & 6'd7) | 
                           ({6{DateMatchS1[8]}}  & 6'd8) | 
                           ({6{DateMatchS1[9]}}  & 6'd9) | 
                           ({6{DateMatchS1[10]}} & 6'd10)| 
                           ({6{DateMatchS1[11]}} & 6'd11)| 
                           ({6{DateMatchS1[12]}} & 6'd12)| 
                           ({6{DateMatchS1[13]}} & 6'd13)| 
                           ({6{DateMatchS1[14]}} & 6'd14)| 
                           ({6{DateMatchS1[15]}} & 6'd15)| 
                           ({6{DateMatchS1[16]}} & 6'd16)| 
                           ({6{DateMatchS1[17]}} & 6'd17)| 
                           ({6{DateMatchS1[18]}} & 6'd18)| 
                           ({6{DateMatchS1[19]}} & 6'd19)| 
                           ({6{DateMatchS1[20]}} & 6'd20)| 
                           ({6{DateMatchS1[21]}} & 6'd21)| 
                           ({6{DateMatchS1[22]}} & 6'd22)| 
                           ({6{DateMatchS1[23]}} & 6'd23)| 
                           ({6{DateMatchS1[24]}} & 6'd24)| 
                           ({6{DateMatchS1[25]}} & 6'd25)| 
                           ({6{DateMatchS1[26]}} & 6'd26)| 
                           ({6{DateMatchS1[27]}} & 6'd27)| 
                           ({6{DateMatchS1[28]}} & 6'd28)| 
                           ({6{DateMatchS1[29]}} & 6'd29)| 
                           ({6{DateMatchS1[30]}} & 6'd30)| 
                           ({6{DateMatchS1[31]}} & 6'd31)| 
                           ({6{DateMatchS1[32]}} & 6'd32)| 
                           ({6{DateMatchS1[33]}} & 6'd33)| 
                           ({6{DateMatchS1[34]}} & 6'd34)| 
                           ({6{DateMatchS1[35]}} & 6'd35)| 
                           ({6{DateMatchS1[36]}} & 6'd36)| 
                           ({6{DateMatchS1[37]}} & 6'd37)| 
                           ({6{DateMatchS1[38]}} & 6'd38)| 
                           ({6{DateMatchS1[39]}} & 6'd39)| 
                           ({6{DateMatchS1[40]}} & 6'd40)| 
                           ({6{DateMatchS1[41]}} & 6'd41)| 
                           ({6{DateMatchS1[42]}} & 6'd42)| 
                           ({6{DateMatchS1[43]}} & 6'd43)| 
                           ({6{DateMatchS1[44]}} & 6'd44)| 
                           ({6{DateMatchS1[45]}} & 6'd45)| 
                           ({6{DateMatchS1[46]}} & 6'd46)| 
                           ({6{DateMatchS1[47]}} & 6'd47)| 
                           ({6{DateMatchS1[48]}} & 6'd48)| 
                           ({6{DateMatchS1[49]}} & 6'd49)| 
                           ({6{DateMatchS1[50]}} & 6'd50)| 
                           ({6{DateMatchS1[51]}} & 6'd51)| 
                           ({6{DateMatchS1[52]}} & 6'd52)| 
                           ({6{DateMatchS1[53]}} & 6'd53)| 
                           ({6{DateMatchS1[54]}} & 6'd54)| 
                           ({6{DateMatchS1[55]}} & 6'd55)| 
                           ({6{DateMatchS1[56]}} & 6'd56)| 
                           ({6{DateMatchS1[57]}} & 6'd57)| 
                           ({6{DateMatchS1[58]}} & 6'd58)| 
                           ({6{DateMatchS1[59]}} & 6'd59)| 
                           ({6{DateMatchS1[60]}} & 6'd60)| 
                           ({6{DateMatchS1[61]}} & 6'd61)| 
                           ({6{DateMatchS1[62]}} & 6'd62)| 
                           ({6{DateMatchS1[63]}} & 6'd63); 

    assign S2SearchIndex = ({6{DateMatchS2[0]}}  & 6'd0) | 
                           ({6{DateMatchS2[1]}}  & 6'd1) | 
                           ({6{DateMatchS2[2]}}  & 6'd2) | 
                           ({6{DateMatchS2[3]}}  & 6'd3) | 
                           ({6{DateMatchS2[4]}}  & 6'd4) | 
                           ({6{DateMatchS2[5]}}  & 6'd5) | 
                           ({6{DateMatchS2[6]}}  & 6'd6) | 
                           ({6{DateMatchS2[7]}}  & 6'd7) | 
                           ({6{DateMatchS2[8]}}  & 6'd8) | 
                           ({6{DateMatchS2[9]}}  & 6'd9) | 
                           ({6{DateMatchS2[10]}} & 6'd10)| 
                           ({6{DateMatchS2[11]}} & 6'd11)| 
                           ({6{DateMatchS2[12]}} & 6'd12)| 
                           ({6{DateMatchS2[13]}} & 6'd13)| 
                           ({6{DateMatchS2[14]}} & 6'd14)| 
                           ({6{DateMatchS2[15]}} & 6'd15)| 
                           ({6{DateMatchS2[16]}} & 6'd16)| 
                           ({6{DateMatchS2[17]}} & 6'd17)| 
                           ({6{DateMatchS2[18]}} & 6'd18)| 
                           ({6{DateMatchS2[19]}} & 6'd19)| 
                           ({6{DateMatchS2[20]}} & 6'd20)| 
                           ({6{DateMatchS2[21]}} & 6'd21)| 
                           ({6{DateMatchS2[22]}} & 6'd22)| 
                           ({6{DateMatchS2[23]}} & 6'd23)| 
                           ({6{DateMatchS2[24]}} & 6'd24)| 
                           ({6{DateMatchS2[25]}} & 6'd25)| 
                           ({6{DateMatchS2[26]}} & 6'd26)| 
                           ({6{DateMatchS2[27]}} & 6'd27)| 
                           ({6{DateMatchS2[28]}} & 6'd28)| 
                           ({6{DateMatchS2[29]}} & 6'd29)| 
                           ({6{DateMatchS2[30]}} & 6'd30)| 
                           ({6{DateMatchS2[31]}} & 6'd31)| 
                           ({6{DateMatchS2[32]}} & 6'd32)| 
                           ({6{DateMatchS2[33]}} & 6'd33)| 
                           ({6{DateMatchS2[34]}} & 6'd34)| 
                           ({6{DateMatchS2[35]}} & 6'd35)| 
                           ({6{DateMatchS2[36]}} & 6'd36)| 
                           ({6{DateMatchS2[37]}} & 6'd37)| 
                           ({6{DateMatchS2[38]}} & 6'd38)| 
                           ({6{DateMatchS2[39]}} & 6'd39)| 
                           ({6{DateMatchS2[40]}} & 6'd40)| 
                           ({6{DateMatchS2[41]}} & 6'd41)| 
                           ({6{DateMatchS2[42]}} & 6'd42)| 
                           ({6{DateMatchS2[43]}} & 6'd43)| 
                           ({6{DateMatchS2[44]}} & 6'd44)| 
                           ({6{DateMatchS2[45]}} & 6'd45)| 
                           ({6{DateMatchS2[46]}} & 6'd46)| 
                           ({6{DateMatchS2[47]}} & 6'd47)| 
                           ({6{DateMatchS2[48]}} & 6'd48)| 
                           ({6{DateMatchS2[49]}} & 6'd49)| 
                           ({6{DateMatchS2[50]}} & 6'd50)| 
                           ({6{DateMatchS2[51]}} & 6'd51)| 
                           ({6{DateMatchS2[52]}} & 6'd52)| 
                           ({6{DateMatchS2[53]}} & 6'd53)| 
                           ({6{DateMatchS2[54]}} & 6'd54)| 
                           ({6{DateMatchS2[55]}} & 6'd55)| 
                           ({6{DateMatchS2[56]}} & 6'd56)| 
                           ({6{DateMatchS2[57]}} & 6'd57)| 
                           ({6{DateMatchS2[58]}} & 6'd58)| 
                           ({6{DateMatchS2[59]}} & 6'd59)| 
                           ({6{DateMatchS2[60]}} & 6'd60)| 
                           ({6{DateMatchS2[61]}} & 6'd61)| 
                           ({6{DateMatchS2[62]}} & 6'd62)| 
                           ({6{DateMatchS2[63]}} & 6'd63); 

    assign C0SearchIndex=  ({6{DateMatchC0[0]}}  & 6'd0) | 
                           ({6{DateMatchC0[1]}}  & 6'd1) | 
                           ({6{DateMatchC0[2]}}  & 6'd2) | 
                           ({6{DateMatchC0[3]}}  & 6'd3) | 
                           ({6{DateMatchC0[4]}}  & 6'd4) | 
                           ({6{DateMatchC0[5]}}  & 6'd5) | 
                           ({6{DateMatchC0[6]}}  & 6'd6) | 
                           ({6{DateMatchC0[7]}}  & 6'd7) | 
                           ({6{DateMatchC0[8]}}  & 6'd8) | 
                           ({6{DateMatchC0[9]}}  & 6'd9) | 
                           ({6{DateMatchC0[10]}} & 6'd10)| 
                           ({6{DateMatchC0[11]}} & 6'd11)| 
                           ({6{DateMatchC0[12]}} & 6'd12)| 
                           ({6{DateMatchC0[13]}} & 6'd13)| 
                           ({6{DateMatchC0[14]}} & 6'd14)| 
                           ({6{DateMatchC0[15]}} & 6'd15)| 
                           ({6{DateMatchC0[16]}} & 6'd16)| 
                           ({6{DateMatchC0[17]}} & 6'd17)| 
                           ({6{DateMatchC0[18]}} & 6'd18)| 
                           ({6{DateMatchC0[19]}} & 6'd19)| 
                           ({6{DateMatchC0[20]}} & 6'd20)| 
                           ({6{DateMatchC0[21]}} & 6'd21)| 
                           ({6{DateMatchC0[22]}} & 6'd22)| 
                           ({6{DateMatchC0[23]}} & 6'd23)| 
                           ({6{DateMatchC0[24]}} & 6'd24)| 
                           ({6{DateMatchC0[25]}} & 6'd25)| 
                           ({6{DateMatchC0[26]}} & 6'd26)| 
                           ({6{DateMatchC0[27]}} & 6'd27)| 
                           ({6{DateMatchC0[28]}} & 6'd28)| 
                           ({6{DateMatchC0[29]}} & 6'd29)| 
                           ({6{DateMatchC0[30]}} & 6'd30)| 
                           ({6{DateMatchC0[31]}} & 6'd31)| 
                           ({6{DateMatchC0[32]}} & 6'd32)| 
                           ({6{DateMatchC0[33]}} & 6'd33)| 
                           ({6{DateMatchC0[34]}} & 6'd34)| 
                           ({6{DateMatchC0[35]}} & 6'd35)| 
                           ({6{DateMatchC0[36]}} & 6'd36)| 
                           ({6{DateMatchC0[37]}} & 6'd37)| 
                           ({6{DateMatchC0[38]}} & 6'd38)| 
                           ({6{DateMatchC0[39]}} & 6'd39)| 
                           ({6{DateMatchC0[40]}} & 6'd40)| 
                           ({6{DateMatchC0[41]}} & 6'd41)| 
                           ({6{DateMatchC0[42]}} & 6'd42)| 
                           ({6{DateMatchC0[43]}} & 6'd43)| 
                           ({6{DateMatchC0[44]}} & 6'd44)| 
                           ({6{DateMatchC0[45]}} & 6'd45)| 
                           ({6{DateMatchC0[46]}} & 6'd46)| 
                           ({6{DateMatchC0[47]}} & 6'd47)| 
                           ({6{DateMatchC0[48]}} & 6'd48)| 
                           ({6{DateMatchC0[49]}} & 6'd49)| 
                           ({6{DateMatchC0[50]}} & 6'd50)| 
                           ({6{DateMatchC0[51]}} & 6'd51)| 
                           ({6{DateMatchC0[52]}} & 6'd52)| 
                           ({6{DateMatchC0[53]}} & 6'd53)| 
                           ({6{DateMatchC0[54]}} & 6'd54)| 
                           ({6{DateMatchC0[55]}} & 6'd55)| 
                           ({6{DateMatchC0[56]}} & 6'd56)| 
                           ({6{DateMatchC0[57]}} & 6'd57)| 
                           ({6{DateMatchC0[58]}} & 6'd58)| 
                           ({6{DateMatchC0[59]}} & 6'd59)| 
                           ({6{DateMatchC0[60]}} & 6'd60)| 
                           ({6{DateMatchC0[61]}} & 6'd61)| 
                           ({6{DateMatchC0[62]}} & 6'd62)| 
                           ({6{DateMatchC0[63]}} & 6'd63); 

    assign   CsrSerchSucces = | C0SearchIndex ;
    assign   csrSerchDate   = C0SearchIndex   ;

    assign   S0Fund       = | DateMatchS0         ;
    //assign   S0Index      = S0SearchIndex        ;    
    assign   S0Ps         = TLBPS[S0SearchIndex] ;
    assign   S0Ppn        = TwoChioseS0[S0SearchIndex] ? TLBPPN1 : TLBPPN0 ;
    assign   S0V          = TwoChioseS0[S0SearchIndex] ? TLBV1   : TLBV0   ;
    assign   S0D          = TwoChioseS0[S0SearchIndex] ? TLBD1   : TLBD0   ;
    assign   S0Mat        = TwoChioseS0[S0SearchIndex] ? TLBMAT1 : TLBMAT0 ;
    assign   S0Plv        = TwoChioseS0[S0SearchIndex] ? TLBPLV1 : TLBPLV0 ;
    assign   S1Fund       = |DateMatchS1         ;
    //assign   S1Index      = S1SearchIndex        ;    
    assign   S1Ps         = TLBPS[S1SearchIndex] ;
    assign   S1Ppn        = TwoChioseS1[S1SearchIndex] ? TLBPPN1 : TLBPPN0 ;
    assign   S1V          = TwoChioseS1[S1SearchIndex] ? TLBV1   : TLBV0   ;
    assign   S1D          = TwoChioseS1[S1SearchIndex] ? TLBD1   : TLBD0   ;
    assign   S1Mat        = TwoChioseS1[S1SearchIndex] ? TLBMAT1 : TLBMAT0 ;
    assign   S1Plv        = TwoChioseS1[S1SearchIndex] ? TLBPLV1 : TLBPLV0 ;

    assign   S2Fund       = |DateMatchS2         ;
    //assign   S2Index      = S1SearchIndex        ;    
    assign   S2Ps         = TLBPS[S2SearchIndex] ;
    assign   S2Ppn        = TwoChioseS2[S2SearchIndex] ? TLBPPN1 : TLBPPN0 ;
    assign   S2V          = TwoChioseS2[S2SearchIndex] ? TLBV1   : TLBV0   ;
    assign   S2D          = TwoChioseS2[S2SearchIndex] ? TLBD1   : TLBD0   ;
    assign   S2Mat        = TwoChioseS2[S2SearchIndex] ? TLBMAT1 : TLBMAT0 ;
    assign   S2Plv        = TwoChioseS2[S2SearchIndex] ? TLBPLV1 : TLBPLV0 ;

    assign   RVppn        = TLBVPPN[RIndex]      ;        
    assign   RAsid        = TLBASID[RIndex]      ;
    assign   RG           = TLBG[RIndex]         ;
    assign   RPs          = TLBPS[RIndex]        ;
    assign   RE           = TLBE[RIndex]         ;
    assign   RV0          = TLBV0[RIndex]        ;
    assign   RD0          = TLBD0[RIndex]        ;
    assign   RMat0        = TLBMAT0[RIndex]      ;
    assign   RPlv0        = TLBPLV0[RIndex]      ;
    assign   RPpn0        = TLBPPN0[RIndex]      ;
    assign   RV1          = TLBV1[RIndex]        ;
    assign   RD1          = TLBD1[RIndex]        ;
    assign   RMat1        = TLBMAT1[RIndex]      ;
    assign   RPlv1        = TLBPLV1[RIndex]      ;
    assign   RPpn1        = TLBPPN1[RIndex]      ;

    integer a ;
    integer b ;
    always @(posedge Clk) begin
        if(!Rest)
            for (a =0 ;a < TLBNUM ;a=a+1 ) begin
                TLBVPPN[a] <= 19'd0 ;
                TLBE[a]    <= 1'd0  ;
                TLBASID[a] <= 10'd0 ;
                TLBG[a]    <= 1'd0  ;
                TLBPS[a]   <= 6'd0  ;
                TLBPPN0[a] <= 20'd0 ;
                TLBPLV0[a] <= 2'd0  ;
                TLBMAT0[a] <= 2'd0  ;
                TLBD0[a]   <= 1'd0  ;
                TLBV0[a]   <= 1'd0  ;
                TLBPPN1[a] <= 20'd0 ;
                TLBPLV1[a] <= 2'd0  ; 
                TLBMAT1[a] <= 2'd0  ;
                TLBD1[a]   <= 1'd0  ;
                TLBV1[a]   <= 1'd0  ;  
            end
            else if(We) begin
                TLBVPPN[WIndex] <= WVppn ;
                TLBE[WIndex]    <= WE    ;
                TLBASID[WIndex] <= WAsid ;
                TLBG[WIndex]    <= WG    ;
                TLBPS[WIndex]   <= WPs   ;
                TLBPPN0[WIndex] <= WPpn0 ;
                TLBPLV0[WIndex] <= WPlv0 ;
                TLBMAT0[WIndex] <= WMat0 ;
                TLBD0[WIndex]   <= WD0   ;
                TLBV0[WIndex]   <= WV0   ;
                TLBPPN1[WIndex] <= WPpn1 ;
                TLBPLV1[WIndex] <= WPlv1 ; 
                TLBMAT1[WIndex] <= WMat1 ;
                TLBD1[WIndex]   <= WD1   ;
                TLBV1[WIndex]   <= WV1   ; 
            end
            else if(InvEn)begin
                for (b =0 ;b < TLBNUM ;b=b+1 ) begin
                    if((InvOp == 0) || (InvOp == 1)) begin
                        TLBE[b] <= 1'd0  ;
                    end 
                    if(InvOp == 2) begin
                        TLBE[b] <= TLBG[b] ? `EnableValue : TLBE[b] ; 
                    end
                    if(InvOp == 3) begin
                        TLBE[b] <= ~TLBG[b] ? `EnableValue : TLBE[b] ; 
                    end
                    if(InvOp == 4) begin
                        TLBE[b] <= (~TLBG[b] && (TLBASID[b] == InvAsid)) ? `EnableValue :  TLBE[b] ;
                    end
                    if(InvOp == 5) begin
                        TLBE[b] <= (~TLBG[b] && (TLBASID[b] == InvAsid) && (TLBVPPN[b] == InvVppn)) ? `EnableValue :  TLBE[b] ;
                    end
                    if(InvOp == 6) begin
                        TLBE[b] <= (TLBG[b] && (TLBASID[b] == InvAsid) && (TLBVPPN[b] == InvVppn)) ? `EnableValue :  TLBE[b] ;
                    end
                end
            end
    end
  
endmodule
