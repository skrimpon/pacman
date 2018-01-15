`timescale 1ns / 1ps
//  ===================================================================================
//  								Define Module, Inputs and Outputs
//  ===================================================================================
module ssdCtrl(
		CLK,
		RST,
		x_DIN,
		y_DIN,
		x_bcdData,
		y_bcdData
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================
   input            CLK;
   input            RST;
   input [9:0]      x_DIN;
   input [9:0]      y_DIN;
	output [15:0]	  x_bcdData;
 	output [15:0]	  y_bcdData;   
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================   
   // 1 kHz Clock Divider
   parameter [15:0] cntEndVal = 16'hC350;
   reg [15:0]       clkCount;
   reg              DCLK;
// ====================================================================================
// 										 Implementation
// ====================================================================================
		// Assign minus sign if applicable
		assign x_bcdData[15:12] = (x_DIN[9] == 1'b0) ? (4'h0) : (4'hF);
		assign y_bcdData[15:12] = (y_DIN[9] == 1'b0) ? (4'h0) : (4'hF);
		
		//------------------------------
		//		 	Format xAxis Data 
		//------------------------------
		Format_Data XFDATA(
				.CLK(CLK),
				.DCLK(DCLK),
				.RST(RST),
				.DIN(x_DIN[8:0]),
				.BCDOUT(x_bcdData[11:0])
		);
		//------------------------------
		//		 	Format yAxis Data
		//------------------------------
		Format_Data YFDATA(
				.CLK(CLK),
				.DCLK(DCLK),
				.RST(RST),
				.DIN(y_DIN[8:0]),
				.BCDOUT(y_bcdData[11:0])
		);
		
		//------------------------------
		//			1khz Clock Divider
		//  Timing for refreshing the
		//  			 SSD, etc.
		//------------------------------
		always @(posedge CLK) begin
				if (clkCount == cntEndVal) begin
					DCLK <= 1'b1;
					clkCount <= 16'h0000;
				end
				else begin
					DCLK <= 1'b0;
					clkCount <= clkCount + 1'b1;
				end
		end
endmodule


