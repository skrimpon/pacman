`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:26:00 10/03/2013 
// Design Name: 
// Module Name:    bonus_controller 
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
module bonus_controller(input clk, input reset ,input [10:0]h_counter, input [9:0] v_counter,
input bonus_eaten,input one_hz_enable,input pause,input pacman_dead,
output reg [7:0] bonus_pixel,output bonus_en,output reg stall);
	reg [2:0] stall_counter;
	reg [10:0] h_zero_addr;	
	reg [10:0] h_one_addr;	
	reg [11:0] h_ready_addr;	
	
	wire [1:0] zero_pixel;
	wire [1:0] one_pixel;
	wire ready_pixel;
	
	wire zero_bonus = (h_counter > `H_BONUS_ZERO_ON) & (h_counter < `H_BONUS_ZERO_OFF);
	wire one_bonus = (h_counter > `H_BONUS_ONE_ON) & (h_counter < `H_BONUS_ONE_OFF);
	wire h_ready_message = (h_counter > `H_READY_ON) & (h_counter < `H_READY_OFF);
	wire v_ready_message = (v_counter > `V_READY_ON) & (v_counter < `V_READY_OFF);
	wire ready_message = h_ready_message & v_ready_message & stall;
	
	wire v_zero_bonus = (v_counter > `V_BONUS_ZERO_ON) & (v_counter < `V_BONUS_ZERO_OFF);
	wire v_one_bonus = (v_counter > `V_BONUS_ONE_ON) & (v_counter < `V_BONUS_ONE_OFF);
	assign bonus_en = ((((zero_bonus & v_zero_bonus & bonus_eaten) | 
	(one_bonus & v_one_bonus & (!bonus_eaten)))&(!stall))| ready_message);
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					stall <= 1;
					stall_counter <= 0;
				end
			else if(stall_counter == 4)
				begin
					stall <= 0;
					stall_counter <= 0;
				end
			else if(pacman_dead)
				begin
					stall <= 1;
					stall_counter <= 0;
				end
			else if((one_hz_enable)&(!pause))
				begin
					stall <= stall;
					stall_counter <= stall_counter + 1'b1;
				end
			else
				begin
					stall <= stall;
					stall_counter <= stall_counter;
				end
		end
	
// ALWAYS STATEMENT - PAC-MAN bonus ROM
	always @ (posedge clk or posedge reset)	
		begin
			if (reset)
				begin
					h_zero_addr <= 256;
					h_one_addr <= 1;	
					h_ready_addr <= 1;						
				end
			else if (ready_message)
				h_ready_addr <= h_ready_addr + 1'b1;
			else if (zero_bonus)
				h_zero_addr <= h_zero_addr + 1'b1;
			else if (one_bonus)
				h_one_addr <= h_one_addr + 1'b1;
			else
				begin
					h_zero_addr <= v_zero_bonus?h_zero_addr:256;
					h_one_addr <= v_one_bonus?h_one_addr:1; 			
					h_ready_addr <= v_ready_message?h_ready_addr:1; 			
				end
		end
// PAC-MAN bonus PIXEL COLOUR
	always @ ( * )
		begin
			if(bonus_en)
				begin
					if(ready_message)
						bonus_pixel = ready_pixel?8'hfc:8'h0;
					else if(zero_bonus)
						begin
							case(zero_pixel)
								`S0:bonus_pixel = 8'b0;
								`S1:bonus_pixel = 8'he0;
								`S2:bonus_pixel = 8'h20;
								`S3:bonus_pixel = 8'hff;
							endcase
						end
					else if(one_bonus)
						begin
							case(one_pixel)
								`S0:bonus_pixel = 8'b0;
								`S1:bonus_pixel = 8'he0;
								`S2:bonus_pixel = 8'h20;
								`S3:bonus_pixel = 8'hff;
							endcase
						end
					else
						bonus_pixel = 8'b0;
				end
			else
				bonus_pixel = 8'b0;
		end
	bonus_rom Rom1(clk,h_zero_addr,zero_pixel,
						clk,h_one_addr,one_pixel);
	ready_mem ROM (clk,h_ready_addr,ready_pixel);
endmodule
