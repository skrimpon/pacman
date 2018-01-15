`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Josh Sackos
// 
// Create Date:    07/26/2012
// Module Name:    selData
// Project Name: 	 PmodACL_Demo
// Target Devices: Nexys3
// Tool versions:  ISE 14.1
// Description: This module converts axis data from 2's compliment to its magnitude
//					 representation.  Based upon the input switches SW(1) and SW(0) either
//					 the x-axis, y-axis, or z-axis data will be output on the DOUT output.
//
// Revision History: 
// 						Revision 0.01 - File Created (Josh Sackos)
///////////////////////////////////////////////////////////////////////////////////////////

// ====================================================================================
// 										  Define Module
// ====================================================================================
module sel_Data(
		CLK,
		RST,
		xAxis,
		yAxis,
		x_DOUT,
		y_DOUT
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================
   input        CLK;
   input        RST;
   input [9:0]  xAxis;
   input [9:0]  yAxis;
   output [9:0] x_DOUT;
   output [9:0] y_DOUT;
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
   reg [9:0]    x_DOUT;
   reg [9:0]    y_DOUT;   
//  ===================================================================================
// 							  				Implementation
//  ===================================================================================
		//-----------------------------------------------
		//	Select Display Data and Convert to Magnitude
		//-----------------------------------------------
		always @(posedge CLK or posedge RST)
			begin
				if (RST == 1'b1)
					begin
						x_DOUT <= 10'b0000000000;
						y_DOUT <= 10'b0000000000;
					end
				else 
					begin
						if (xAxis[9] == 1'b1)
							x_DOUT <= {xAxis[9], (9'b000000000 - xAxis[8:0])};
						else
							x_DOUT <= xAxis;
						if (yAxis[9] == 1'b1)
							y_DOUT <= {yAxis[9], (9'b000000000 - yAxis[8:0])};
						else
							y_DOUT <= yAxis;
					end
			end	
endmodule

