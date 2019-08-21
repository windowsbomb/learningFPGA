`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/20 13:41:22
// Design Name: 
// Module Name: rotator
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


module rotator(stage,wr1,wi1,wr2,wi2,wr3,wi3,wr4,wi4
    );
    parameter N=8, n=3;
    input[1:0] stage;
	output reg[N-1:0] wr1,wi1,wr2,wi2,wr3,wi3,wr4,wi4;
	
	always @(stage)
	case(stage)
        2'b11:
            begin 
                wr1=0; wi1=0;
                wr2=1; wi2=0;
                wr3=0; wi3=0;
                wr4=0; wi4=0; 
            end
        2'b10:
            begin 
                wr1=8'b01111111; wi1=8'b00000000;
                wr2=8'b01011010; wi2=8'b10100110;
                wr3=8'b00000000; wi3=8'b10000001;
                wr4=8'b10100110; wi4=8'b10100110; 
            end
        2'b01:
            begin 
                wr1=8'b01111111; wi1=8'b00000000;
                wr2=8'b00000000; wi2=8'b10000001;
                wr3=8'b01111111; wi3=8'b00000000;
                wr4=8'b00000000; wi4=8'b10000001;
            end
        2'b00:
            begin 
                wr1=8'b01111111; wi1=8'b00000000;
                wr2=8'b01111111; wi2=8'b00000000;
                wr3=8'b01111111; wi3=8'b00000000;
                wr4=8'b01111111; wi4=8'b00000000;
            end
        default: 
            begin 
                wr1=8'bx; wi1=8'bx; 
                wr2=8'bx; wi2=8'bx; 
                wr3=8'bx; wi3=8'bx; 
                wr4=8'bx; wi4=8'bx; 
            end
	endcase
	
	/*
	always @(k)
	case(K)
        2'b00:
            case(k)
                3'h0: begin wr=8'b01111111; wi=8'b00000000; end
                3'h1: begin wr=8'b01011010; wi=8'b10100110; end
                3'h2: begin wr=8'b00000000; wi=8'b10000001; end
                3'h3: begin wr=8'b10100110; wi=8'b10100110; end
                3'h4: begin wr=8'b10000001; wi=8'b00000000; end
                3'h5: begin wr=8'b10100110; wi=8'b01011010; end
                3'h6: begin wr=8'b00000000; wi=8'b01111111; end
                3'h7: begin wr=8'b01011010; wi=8'b01011010; end
                default: begin wr=8'bx; wi=8'bx; end
            endcase
        2'b01:
            case(k)
                3'h0: begin wr=8'b01111111; wi=8'b00000000; end
                3'h1: begin wr=8'b00000000; wi=8'b10000001; end
                3'h2: begin wr=8'b10000001; wi=8'b00000000; end
                3'h3: begin wr=8'b00000000; wi=8'b01111111; end
                default: begin wr=8'bx; wi=8'bx; end
            endcase
        2'b10:
            case(k)
                3'h0: begin wr=8'b01111111; wi=8'b00000000; end
                3'h1: begin wr=8'b10000001; wi=8'b00000000; end
                default: begin wr=8'bx; wi=8'bx; end
            endcase
	endcase
	*/
endmodule
