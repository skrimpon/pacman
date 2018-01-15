`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:08 07/22/2013 
// Design Name: 
// Module Name:    vsync_pulse 
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
module vsync_pulse(input clk, input reset, input Vsync, output reg pulse);
	reg [1:0] state;
	reg [1:0] nextstate;
	
	parameter S0 = 2'b0;
	parameter S1 = 2'b1;
	parameter S2 = 2'b10;
	parameter S3 = 2'b11;
	
    always @(state, Vsync)
      begin
			case(state)
				S0:
						begin
							pulse = 1'b0;
							nextstate = Vsync?S1:S0;
						end
				S1:
						begin
							pulse = 1'b1;
							nextstate = Vsync?S2:S0;
						end
				S2:
						begin
							pulse = 1'b1;
							nextstate = Vsync?S3:S0;
						end
				S3:
						begin
							pulse = 1'b0;
							nextstate = Vsync?S3:S0;
						end
				default: nextstate = 2'b0;
			endcase
      end
		
		always @(posedge clk or posedge reset)
			begin
				if(reset)
					state <= 2'b0;
				else
					state <= nextstate;
		  end
  
endmodule

