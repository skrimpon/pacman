`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:56 11/06/2013 
// Design Name: 
// Module Name:    music 
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
module music(
    input clk,
	 input RST,
	 input pause,
	 input stall,
    output reg speaker
    );
	
	reg [22:0] tone;
	always @(posedge clk or posedge RST)
		begin
			if(RST)
				tone <= 0;
			else if (pause | stall)
				tone <= 0;
			else
				tone <= tone+1;
		end
	wire [6:0] ramp = (tone[22] ? tone[21:15] : ~tone[21:15]);
	wire [14:0] clkdivider = {2'b01, ramp, 6'b000000};

	reg [14:0] counter;
	always @(posedge clk or posedge RST)
		begin
			if(RST)
				counter <= 0;
			else if(pause | stall)
				counter <= 0;
			else if(counter==0) 
				counter <= clkdivider;
			else
				counter <= counter-1;
		end
	always @(posedge clk or posedge RST)
		begin
			if(RST)
				speaker <= 0;
			else if(pause | stall)
				speaker <= 0;
			else if(counter==0)
				speaker <= ~speaker;
			else
				speaker <= speaker;
		end
endmodule
