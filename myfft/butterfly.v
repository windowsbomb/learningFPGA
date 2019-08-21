`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/20 13:31:00
// Design Name: 
// Module Name: butterfly
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


module butterfly(in1r, in1i, in2r, in2i, wr, wi, out1r, out1i, out2r, out2i
    );
    parameter N=8;
	input[N-1:0] in1r, in1i, in2r, in2i;
	input[N-1:0] wr, wi;
	output [N-1:0] out1r, out1i, out2r, out2i;
	wire[2*N-1:0] prodrr, prodii, prodri, prodir;
    
    assign prodrr=in2r*wr;
	assign prodii=in2i*wi;
	assign prodri=in2r*wi;
	assign prodir=in2i*wr;
	
    assign out1r=in1r+prodrr[2*N-1:N]-prodii[2*N-1:N];
    assign out1i=in1i+prodri[2*N-1:N]+prodir[2*N-1:N];
	assign out2r=in1r-prodrr[2*N-1:N]+prodii[2*N-1:N];
	assign out2i=in1i-prodri[2*N-1:N]-prodir[2*N-1:N];
	always @(*)
	begin
    $display("bat %t in1r[4]=%d out1r%d prodrr=%d wr%d",$time, in1r, out1r, prodrr, wr);
    end
endmodule
