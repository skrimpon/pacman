`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:01:55 08/01/2013 
// Design Name: 
// Module Name:    score_controller 
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
`include "parameter.h"
module score_controller(input clk,input reset, input [10:0] h_counter, input [9:0] v_counter,
input zero_pixel, input one_pixel, input two_pixel, input three_pixel,
input four_pixel,
output h_digit_zero, output h_digit_one, output h_digit_two, output h_digit_three,
output h_digit_four, output v_digit, output reg [7:0] score_pixel, output score_en);
	
	assign h_digit_zero = (h_counter > `H_DIGIT_ZERO_ON) & (h_counter < `H_DIGIT_ZERO_OFF);
	assign h_digit_one = (h_counter > `H_DIGIT_ONE_ON) & (h_counter < `H_DIGIT_ONE_OFF);
	assign h_digit_two = (h_counter > `H_DIGIT_TWO_ON) & (h_counter < `H_DIGIT_TWO_OFF);
	assign h_digit_three = (h_counter > `H_DIGIT_THREE_ON) & (h_counter < `H_DIGIT_THREE_OFF);
	assign h_digit_four = (h_counter > `H_DIGIT_FOUR_ON) & (h_counter < `H_DIGIT_FOUR_OFF);
	assign v_digit = (v_counter > `V_DIGIT_ON) & (v_counter < `V_DIGIT_OFF);
	assign score_en = ((h_digit_zero | h_digit_one | h_digit_two | h_digit_three |
	h_digit_four) & v_digit);



	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				score_pixel <= 0;
			else if(h_digit_zero & v_digit)
				begin
					if(zero_pixel)
						score_pixel <= 8'hf6;
					else
						score_pixel <= 8'h00;
				end
			else if(h_digit_one & v_digit)
				begin
					if(one_pixel)
						score_pixel <= 8'hf6;
					else
						score_pixel <= 8'h00;
				end
			else if(h_digit_two & v_digit)
				begin
					if(two_pixel)
						score_pixel <= 8'hf6;
					else
						score_pixel <= 8'h00;
				end
			else if(h_digit_three & v_digit)
				begin
					if(three_pixel)
						score_pixel <= 8'hf6;
					else
						score_pixel <= 8'h00;
				end
			else if(h_digit_four & v_digit)
				begin
					if(four_pixel)
						score_pixel <= 8'hf6;
					else
						score_pixel <= 8'h00;
				end
			else
				score_pixel <= 8'hff;
		end
endmodule
