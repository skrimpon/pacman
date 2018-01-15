`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:05:13 10/22/2013 
// Design Name: 
// Module Name:    ghost_chase 
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
module ghost_chase(input clk, input reset,input one_hz_enable, output reg chase);
	reg [4:0] chase_counter;
	
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					chase <= 1;
					chase_counter <= 0;
				end
			else if(chase_counter == 10)
				begin
					chase <= ~chase;
					chase_counter <= 0;
				end
			else if(one_hz_enable)
				begin
					chase <= chase;
					chase_counter <= chase_counter + 1;
				end
			else
				begin
					chase <= chase;
					chase_counter <= chase_counter;
				end
				
				
		end

endmodule
