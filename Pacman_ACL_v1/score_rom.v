`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UTH
// Engineer: Panagiotis Skrimponis
// 
// Create Date:    12:07:32 07/15/2013 
// Design Name: 
// Module Name:    score_rom 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module score_rom(input clk, input reset,input [3:0] score_val, input h_enable,
input v_enable,
output reg pixel);
	reg pixel_temp;
	reg [15:0] zero [15:0];
	reg [15:0] one [15:0];
	reg [15:0] two [15:0];
	reg [15:0] three [15:0];
	reg [15:0] four [15:0];
	reg [15:0] five [15:0];
	reg [15:0] six [15:0];
	reg [15:0] seven [15:0];
	reg [15:0] eight [15:0];
	reg [15:0] nine [15:0];
	reg [4:0] counter_x;
	reg [3:0] counter_y;
	parameter S0 = 4'h0;
	parameter S1 = 4'h1;
	parameter S2 = 4'h2;
	parameter S3 = 4'h3;
	parameter S4 = 4'h4;
	parameter S5 = 4'h5;
	parameter S6 = 4'h6;
	parameter S7 = 4'h7;
	parameter S8 = 4'h8;
	parameter S9 = 4'h9;
	
	always @(posedge clk or posedge reset)
		begin
			if(reset)
				begin
//zero
					zero[0] <= 16'hffff;
					zero[1] <= 16'hffff;
					zero[2] <= 16'hf00f;
					zero[3] <= 16'hf00f;
					zero[4] <= 16'hf00f;
					zero[5] <= 16'hf00f;
					zero[6] <= 16'hf00f;
					zero[7] <= 16'hf00f;
					zero[8] <= 16'hf00f;
					zero[9] <= 16'hf00f;
					zero[10] <= 16'hf00f;
					zero[11] <= 16'hf00f;
					zero[12] <= 16'hf00f;
					zero[13] <= 16'hf00f;
					zero[14] <= 16'hffff;
					zero[15] <= 16'hffff;
//one
					one[0] <= 16'h03c0;
					one[1] <= 16'h03c0;
					one[2] <= 16'h03c0;
					one[3] <= 16'h03c0;
					one[4] <= 16'h03c0;
					one[5] <= 16'h03c0;
					one[6] <= 16'h03c0;
					one[7] <= 16'h03c0;
					one[8] <= 16'h03c0;
					one[9] <= 16'h03c0;
					one[10] <= 16'h03c0;
					one[11] <= 16'h03c0;
					one[12] <= 16'h03c0;
					one[13] <= 16'h03c0;
					one[14] <= 16'hffff;
					one[15] <= 16'hffff;
//two
					two[0] <= 16'hffff;
					two[1] <= 16'hffff;
					two[2] <= 16'hf000;
					two[3] <= 16'hf000;
					two[4] <= 16'hf000;
					two[5] <= 16'hf000;
					two[6] <= 16'hf000;
					two[7] <= 16'hffff;
					two[8] <= 16'hffff;
					two[9] <= 16'h000f;
					two[10] <= 16'h000f;
					two[11] <= 16'h000f;
					two[12] <= 16'h000f;
					two[13] <= 16'h000f;
					two[14] <= 16'hffff;
					two[15] <= 16'hffff;
//three
					three[0] <= 16'hffff;
					three[1] <= 16'hffff;
					three[2] <= 16'hf000;
					three[3] <= 16'hf000;
					three[4] <= 16'hf000;
					three[5] <= 16'hf000;
					three[6] <= 16'hf000;
					three[7] <= 16'hfff0;
					three[8] <= 16'hfff0;
					three[9] <= 16'hf000;
					three[10] <= 16'hf000;
					three[11] <= 16'hf000;
					three[12] <= 16'hf000;
					three[13] <= 16'hf000;
					three[14] <= 16'hffff;
					three[15] <= 16'hffff;
//four
					four[0] <= 16'hf00f;
					four[1] <= 16'hf00f;
					four[2] <= 16'hf00f;
					four[3] <= 16'hf00f;
					four[4] <= 16'hf00f;
					four[5] <= 16'hf00f;
					four[6] <= 16'hf00f;
					four[7] <= 16'hf00f;
					four[8] <= 16'hffff;
					four[9] <= 16'hffff;
					four[10] <= 16'hf000;
					four[11] <= 16'hf000;
					four[12] <= 16'hf000;
					four[13] <= 16'hf000;
					four[14] <= 16'hf000;
					four[15] <= 16'hf000;
//five
					five[0] <= 16'hffff;
					five[1] <= 16'hffff;
					five[2] <= 16'h000f;
					five[3] <= 16'h000f;
					five[4] <= 16'h000f;
					five[5] <= 16'h000f;
					five[6] <= 16'h000f;
					five[7] <= 16'hffff;
					five[8] <= 16'hffff;
					five[9] <= 16'hf000;
					five[10] <= 16'hf000;
					five[11] <= 16'hf000;
					five[12] <= 16'hf000;
					five[13] <= 16'hf000;
					five[14] <= 16'hffff;
					five[15] <= 16'hffff;
//six
					six[0] <= 16'hffff;
					six[1] <= 16'hffff;
					six[2] <= 16'h000f;
					six[3] <= 16'h000f;
					six[4] <= 16'h000f;
					six[5] <= 16'h000f;
					six[6] <= 16'h000f;
					six[7] <= 16'hffff;
					six[8] <= 16'hffff;
					six[9] <= 16'hf00f;
					six[10] <= 16'hf00f;
					six[11] <= 16'hf00f;
					six[12] <= 16'hf00f;
					six[13] <= 16'hf00f;
					six[14] <= 16'hffff;
					six[15] <= 16'hffff;
//seven
					seven[0] <= 16'hffff;
					seven[1] <= 16'hffff;
					seven[2] <= 16'hf000;
					seven[3] <= 16'hf000;
					seven[4] <= 16'hf000;
					seven[5] <= 16'hf000;
					seven[6] <= 16'hf000;
					seven[7] <= 16'hf000;
					seven[8] <= 16'hf000;
					seven[9] <= 16'hf000;
					seven[10] <= 16'hf000;
					seven[11] <= 16'hf000;
					seven[12] <= 16'hf000;
					seven[13] <= 16'hf000;
					seven[14] <= 16'hf000;
					seven[15] <= 16'hf000;
//eight
					eight[0] <= 16'hffff;
					eight[1] <= 16'hffff;
					eight[2] <= 16'hf00f;
					eight[3] <= 16'hf00f;
					eight[4] <= 16'hf00f;
					eight[5] <= 16'hf00f;
					eight[6] <= 16'hf00f;
					eight[7] <= 16'hffff;
					eight[8] <= 16'hffff;
					eight[9] <= 16'hf00f;
					eight[10] <= 16'hf00f;
					eight[11] <= 16'hf00f;
					eight[12] <= 16'hf00f;
					eight[13] <= 16'hf00f;
					eight[14] <= 16'hffff;
					eight[15] <= 16'hffff;
//nine
					nine[0] <= 16'hffff;
					nine[1] <= 16'hffff;
					nine[2] <= 16'hf00f;
					nine[3] <= 16'hf00f;
					nine[4] <= 16'hf00f;
					nine[5] <= 16'hf00f;
					nine[6] <= 16'hf00f;
					nine[7] <= 16'hffff;
					nine[8] <= 16'hffff;
					nine[9] <= 16'hf000;
					nine[10] <= 16'hf000;
					nine[11] <= 16'hf000;
					nine[12] <= 16'hf000;
					nine[13] <= 16'hf000;
					nine[14] <= 16'hffff;
					nine[15] <= 16'hffff;
					counter_x <= 0;
					counter_y <= 0;
				end
			else
				begin
					case(score_val)
						S0: pixel <= zero[counter_y][counter_x];
						S1: pixel <= one[counter_y][counter_x];
						S2: pixel <= two[counter_y][counter_x];
						S3: pixel <= three[counter_y][counter_x];
						S4: pixel <= four[counter_y][counter_x];
						S5: pixel <= five[counter_y][counter_x];
						S6: pixel <= six[counter_y][counter_x];
						S7: pixel <= seven[counter_y][counter_x];
						S8: pixel <= eight[counter_y][counter_x];
						S9: pixel <= nine[counter_y][counter_x];
						default: pixel <= zero[counter_y][counter_x];
					endcase
					if((h_enable & v_enable)==1)
						begin
							counter_x <= counter_x + 1;
						end
					else if (v_enable == 0)
						begin
							counter_x <= 0;
							counter_y <= 0;
						end
					else if(counter_x)
						begin
							counter_y <= counter_y + 1;
							counter_x <= 0;
						end
				end
		end
		

endmodule
