`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:06:44 10/12/2013 
// Design Name: 
// Module Name:    one_hz_enable_generator 
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
module one_hz_enable_generator(input clk,input reset,output reg one_hz_enable);
	parameter MAX = 75000000;
	integer counter;
	
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					one_hz_enable <= 0;
					counter <= 0;
				end
			else if(counter == MAX)
				begin
					one_hz_enable <= 1;
					counter <= 0;
				end
			else
				begin
					one_hz_enable <= 0;
					counter <= counter + 1;
				end
		end


endmodule
