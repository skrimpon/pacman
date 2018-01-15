`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:02:23 07/19/2014 
// Design Name: 
// Module Name:    siren 
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
module siren(clk, speaker_en, speaker_2, speaker);
input clk, speaker_en, speaker_2;
output speaker;

wire speaker_en2=speaker_en;

reg [21:0] tone;
always @(posedge clk) 
	if(~speaker_en2)
		tone <= 0;
	else
		tone <= tone+1;

wire [6:0] ramp = (tone[21] ? tone[20:14] : ~tone[20:14]);
wire [13:0] clkdivider = {2'b01, ramp, 5'b00000};

reg [14:0] counter;
always @(posedge clk) 
	if((counter==0) || ~speaker_en2) counter <= clkdivider; else counter <= counter-1;

reg speaker;
always @(posedge clk) 
	if(~speaker_en2) speaker <= speaker_2;
	else if(counter==0) speaker <= ~speaker;
endmodule
