`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/20 20:25:29
// Design Name: 
// Module Name: looper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module looper(clk, rst,
    inrinr, outroutr, iniini, outiouti, outEN
    );
    parameter N=8, n=3, nsample=8;
    input clk, rst;
    output outEN;
    input[63:0] inrinr, iniini;
    output[63:0] outroutr, outiouti;
    wire[N-1:0] inr[nsample-1:0];
    wire[N-1:0] ini[nsample-1:0];
    reg[N-1:0] outr[nsample-1:0];
    reg[N-1:0] outi[nsample-1:0];
    wire[N-1:0] dataOutr[nsample-1:0];
    wire[N-1:0] dataOuti[nsample-1:0];
    wire[N/2-1:0] Wr[nsample-1:0];
    wire[N/2-1:0] Wi[nsample-1:0];
    
    reg[N-1:0] dataInr[nsample-1:0];
    reg[N-1:0] dataIni[nsample-1:0];
    reg[1:0] stage;
    
    assign inr[0]=inrinr[7:0], ini[0]=iniini[7:0];
    assign inr[1]=inrinr[15:8], ini[1]=iniini[15:8];
    assign inr[2]=inrinr[23:16], ini[2]=iniini[23:16];
    assign inr[3]=inrinr[31:24], ini[3]=iniini[31:24];
    assign inr[4]=inrinr[39:32], ini[4]=iniini[39:32];
    assign inr[5]=inrinr[47:40], ini[5]=iniini[47:40];
    assign inr[6]=inrinr[55:48], ini[6]=iniini[55:48];
    assign inr[7]=inrinr[63:56], ini[7]=iniini[63:56];
    
        
    assign outroutr[7:0]=outr[0], outiouti[7:0]=outi[0];
    assign outroutr[15:8]=outr[1], outiouti[15:8]=outi[1];
    assign outroutr[23:16]=outr[2], outiouti[23:16]=outi[2];
    assign outroutr[31:24]=outr[3], outiouti[31:24]=outi[3];
    assign outroutr[39:32]=outr[4], outiouti[39:32]=outi[4];
    assign outroutr[47:40]=outr[5], outiouti[47:40]=outi[5];
    assign outroutr[55:48]=outr[6], outiouti[55:48]=outi[6];
    assign outroutr[63:56]=outr[7], outiouti[63:56]=outi[7];
    
    butterfly bf0(
        .in1r(dataInr[0]), .in1i(dataIni[0]), .in2r(dataInr[1]), .in2i(dataIni[1]),
        .wr(Wr[0]), .wi(Wi[0]), 
        .out1r(dataOutr[0]), .out1i(dataOuti[0]), .out2r(dataOutr[1]), .out2i(dataOuti[1])
    );
    butterfly bf1(
        .in1r(dataInr[2]), .in1i(dataIni[2]), .in2r(dataInr[3]), .in2i(dataIni[3]),
        .wr(Wr[1]), .wi(Wi[1]), 
        .out1r(dataOutr[2]), .out1i(dataOuti[2]), .out2r(dataOutr[3]), .out2i(dataOuti[3])
    );
    butterfly bf2(
        .in1r(dataInr[4]), .in1i(dataIni[4]), .in2r(dataInr[5]), .in2i(dataIni[5]),
        .wr(Wr[2]), .wi(Wi[2]), 
        .out1r(dataOutr[4]), .out1i(dataOuti[4]), .out2r(dataOutr[5]), .out2i(dataOuti[5])
    );
    butterfly bf3(
        .in1r(dataInr[6]), .in1i(dataIni[6]), .in2r(dataInr[7]), .in2i(dataIni[7]),
        .wr(Wr[3]), .wi(Wi[3]), 
        .out1r(dataOutr[6]), .out1i(dataOuti[6]), .out2r(dataOutr[7]), .out2i(dataOuti[7])
    );
    
    rotator Rtt(stage,Wr[0],Wi[0],Wr[1],Wi[1],Wr[2],Wi[2],Wr[3],Wi[3]);

    assign outEN=(stage==0) ? 1:0;

    always @(negedge rst)
    if (~rst)
    begin
        stage=0;
        
        outr[0]=0;
        outr[1]=0;
        outr[2]=0;
        outr[3]=0;
        outr[4]=0;
        outr[5]=0;
        outr[6]=0;
        outr[7]=0;
        
        outi[0]=0;
        outi[1]=0;
        outi[2]=0;
        outi[3]=0;
        outi[4]=0;
        outi[5]=0;
        outi[6]=0;
        outi[7]=0;
        
        dataInr[0]=0;
        dataInr[1]=0;
        dataInr[2]=0;
        dataInr[3]=0;
        dataInr[4]=0;
        dataInr[5]=0;
        dataInr[6]=0;
        dataInr[7]=0;
        
        dataIni[0]=0;
        dataIni[1]=0;
        dataIni[2]=0;
        dataIni[3]=0;
        dataIni[4]=0;
        dataIni[5]=0;
        dataIni[6]=0;
        dataIni[7]=0;
    end

    always @(posedge clk)
    begin
        stage<=stage+1;
    $display("at %t inr[4]=%d s%d dataInr[1]=%d Wr%d",$time, inr[4], stage, dataInr[1],Wr[1]);
    case (stage)
    0:
        begin
            dataInr[0]<=inr[0]; dataIni[0]<=ini[0];
            dataInr[1]<=inr[4]; dataIni[1]<=ini[4];
            dataInr[2]<=inr[2]; dataIni[2]<=ini[2];
            dataInr[3]<=inr[6]; dataIni[3]<=ini[6];
            dataInr[4]<=inr[1]; dataIni[4]<=ini[1];
            dataInr[5]<=inr[5]; dataIni[5]<=ini[5];
            dataInr[6]<=inr[3]; dataIni[6]<=ini[3];
            dataInr[7]<=inr[7]; dataIni[7]<=ini[7];
        end
    1:
        begin
            dataInr[0]<=dataOutr[0]; dataIni[0]<=dataOuti[0];
            dataInr[2]<=dataOutr[1]; dataIni[2]<=dataOuti[1];
            dataInr[1]<=dataOutr[2]; dataIni[1]<=dataOuti[2];
            dataInr[3]<=dataOutr[3]; dataIni[3]<=dataOuti[3];
            dataInr[4]<=dataOutr[4]; dataIni[4]<=dataOuti[4];
            dataInr[6]<=dataOutr[5]; dataIni[6]<=dataOuti[5];
            dataInr[5]<=dataOutr[6]; dataIni[5]<=dataOuti[6];
            dataInr[7]<=dataOutr[7]; dataIni[7]<=dataOuti[7];
        end
    2:
        begin
            dataInr[0]<=dataOutr[0]; dataIni[0]<=dataOuti[0];
            dataInr[1]<=dataOutr[4]; dataIni[1]<=dataOuti[4];
            dataInr[2]<=dataOutr[2]; dataIni[2]<=dataOuti[2];
            dataInr[3]<=dataOutr[6]; dataIni[3]<=dataOuti[6];
            dataInr[4]<=dataOutr[1]; dataIni[4]<=dataOuti[1];
            dataInr[5]<=dataOutr[5]; dataIni[5]<=dataOuti[5];
            dataInr[6]<=dataOutr[3]; dataIni[6]<=dataOuti[3];
            dataInr[7]<=dataOutr[7]; dataIni[7]<=dataOuti[7];
        end
    3:
        begin
            outr[0]<=dataOutr[0]; outi[0]<=dataOuti[0];
            outr[1]<=dataOutr[2]; outi[1]<=dataOuti[2];
            outr[2]<=dataOutr[4]; outi[2]<=dataOuti[4];
            outr[3]<=dataOutr[6]; outi[3]<=dataOuti[6];
            outr[4]<=dataOutr[1]; outi[4]<=dataOuti[1];
            outr[5]<=dataOutr[3]; outi[5]<=dataOuti[3];
            outr[6]<=dataOutr[5]; outi[6]<=dataOuti[5];
            outr[7]<=dataOutr[7]; outi[7]<=dataOuti[7];
        end
    endcase
    $display("at %t inr[4]=%d s%d dataInr[1]=%d Wr%d",$time, inr[4], stage, dataInr[1],Wr[1]);
    end
    
endmodule
