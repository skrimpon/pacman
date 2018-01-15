`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:19 08/13/2013 
// Design Name: 
// Module Name:    clyde_controller 
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
module clyde_controller(input clk, input reset, input vsync_enable, input chase, input [10:0] h_counter,
input [9:0] v_counter,input pause, input stall, input up_clyde_limit, input down_clyde_limit, 
input left_clyde_limit, input right_clyde_limit, input [4:0] h_clyde_tile,
input [4:0] v_clyde_tile, input [4:0] h_pacman_tile, input [4:0] v_pacman_tile,
input scared_mode, input scared_mode_end, input end_of_game, input [1:0] clyde_pixel_sel,
input [1:0] clyde_dead, input pacman_dead,
output reg [7:0] clyde_pixel, output clyde_en, output [10:0] h_clyde_tile_counter,
output [9:0] v_clyde_tile_counter, output reg up_clyde_state, output reg down_clyde_state,
output reg left_clyde_state, output reg right_clyde_state, output reg [13:0] h_clyde_addr);
// REGISTER DEFINITIONS
	reg blink;
	reg [4:0] blink_counter;
	reg image_sel;
	reg image_sel_1;
	reg clyde_slow;
	reg [4:0] h_target_tile;
	reg [4:0] v_target_tile;
	reg [1:0] clyde_state;
	reg [1:0] clyde_image;
	reg [1:0] clyde_next_state;
	reg [3:0] movement_en;
	reg [10:0] h_clyde_counter;
	reg [9:0] v_clyde_counter;
	reg [10:0] h_clyde_cnt;
	reg [9:0] v_clyde_cnt;
// WIRE DEFINITIONS
	
	wire h_clyde = (h_counter > (h_limit_on)) &
						 (h_counter < (h_limit_off));
	wire v_clyde = (v_counter > (v_limit_on)) &
						 (v_counter < (v_limit_off));
	wire clyde = h_clyde & v_clyde;
	
	wire [10:0] h_limit_on =  h_clyde_counter;
	wire [10:0] h_limit_off= (`H_CLYDE_SIZE + h_clyde_counter);
	wire [9:0] v_limit_on = v_clyde_counter;
	wire [9:0] v_limit_off= (`V_CLYDE_SIZE + v_clyde_counter);
	
	wire clyde_tile = (h_counter == (h_clyde_tile_counter)) &
							 (v_counter == (v_clyde_tile_counter));
	
	assign h_clyde_tile_counter = (h_limit_on + 5'b10001);
	assign v_clyde_tile_counter = (v_limit_on + 5'b10001);
	assign pause_en = (pause | stall);
	
// clyde MOVEMENT
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					image_sel <= 1;
					clyde_slow <= 1;
					movement_en <= 0;
					clyde_image <= 0;
					clyde_state <= 0;
					h_clyde_counter <= `H_CLYDE_ON;
					v_clyde_counter <= `V_CLYDE_ON;
				end
			else if(pacman_dead || end_of_game)
				begin
					image_sel <= 1;
					clyde_slow <= 1;
					movement_en <= 0;
					clyde_image <= 0;
					clyde_state <= 0;
					h_clyde_counter <= `H_CLYDE_ON;
					v_clyde_counter <= `V_CLYDE_ON;
				end
			else if (vsync_enable & clyde_slow &(!pause_en))
				begin
					if (movement_en == 4'b1010)
						begin
							image_sel <= image_sel_1;
							movement_en <= 0;
						end
					else
						image_sel <= image_sel;
					clyde_slow <= (clyde_dead>0)?1:(!scared_mode);
					movement_en <= movement_en + 1;
					h_clyde_counter <= h_clyde_cnt;
					v_clyde_counter <= v_clyde_cnt;
					clyde_state <= clyde_next_state;
					clyde_image <= clyde_next_state;
				end
			else
				begin
					image_sel <= image_sel;
					clyde_slow <= 1;
					movement_en <= movement_en;
					h_clyde_counter <= h_clyde_counter;
					v_clyde_counter <= v_clyde_counter;
					clyde_state <= clyde_state;
				end
		end
// TARGET TILE CALCULATION
	always @ ( * )
		begin
			if(((clyde_dead == 1) || (scared_mode && (clyde_dead == 0))))
				begin
					h_target_tile = 14;
					v_target_tile = 12;
				end
			else if(chase)
				begin
					h_target_tile = 3;
					v_target_tile = 32;
				end
			else
				begin
					if((((h_pacman_tile - h_clyde_tile)<<1) + ((h_pacman_tile - h_clyde_tile)<<1)) < 65)
						begin
							h_target_tile = 3;
							v_target_tile = 32;
						end
					else
						begin
							h_target_tile = h_pacman_tile;
							v_target_tile = v_pacman_tile;
						end
				end
		end
// clyde MOVEMENT : Finite State Machine (FSM)
		always @ ( * )
			begin
				image_sel_1 = ~ image_sel;
				case(clyde_state)
					`S0:
						begin
							if(h_clyde_counter == (`H_BOARD_OFF-`H_CLYDE_SIZE))
								begin
									h_clyde_cnt = `H_BOARD_ON + 1;
									v_clyde_cnt = `V_PACMAN_ON - 180;
									clyde_next_state = `S0;
								end
							else if((!right_clyde_limit) & (!up_clyde_limit))
								begin
									h_clyde_cnt = h_clyde_counter;
									v_clyde_cnt = v_clyde_counter + 1;
									clyde_next_state = `S2;
								end
							else if (!right_clyde_limit)
								begin
									if(!down_clyde_limit)
										begin
											h_clyde_cnt = h_clyde_counter;
											v_clyde_cnt = v_clyde_counter - 1;
											clyde_next_state = `S3;
										end
									else if (v_clyde_tile >= v_target_tile)
										begin
											h_clyde_cnt = h_clyde_counter;
											v_clyde_cnt = v_clyde_counter - 1;
											clyde_next_state = `S3;
										end
									else
										begin
											h_clyde_cnt = h_clyde_counter;
											v_clyde_cnt = v_clyde_counter + 1;
											clyde_next_state = `S2;
										end
								end
							else
								begin
									if (h_clyde_tile >= h_target_tile)
										begin
											if(v_clyde_tile <= v_target_tile)
												begin
													if(down_clyde_limit)
														begin
															h_clyde_cnt = h_clyde_counter;
															v_clyde_cnt = v_clyde_counter + 1;
															clyde_next_state = `S2;
														end
													else
														begin
															h_clyde_cnt = h_clyde_counter + 1;
															v_clyde_cnt = v_clyde_counter;
															clyde_next_state = `S0;
														end
												end
											else
												begin
													if(up_clyde_limit)
														begin
															h_clyde_cnt = h_clyde_counter;
															v_clyde_cnt = v_clyde_counter - 1;
															clyde_next_state = `S3;
														end
													else
														begin
															h_clyde_cnt = h_clyde_counter + 1;
															v_clyde_cnt = v_clyde_counter;
															clyde_next_state = `S0;
														end
												end
										end
									else
										begin
											h_clyde_cnt = h_clyde_counter + 1;
											v_clyde_cnt = v_clyde_counter;
											clyde_next_state = `S0;
										end
								end
						end
				`S1:
					begin
						if(h_clyde_counter == `H_BOARD_ON)
							begin
								h_clyde_cnt = `H_BOARD_OFF - 1;
								v_clyde_cnt = `V_PACMAN_ON - 180;
								clyde_next_state = `S1;
							end
						else if((!left_clyde_limit) & (!up_clyde_limit))
							begin
								h_clyde_cnt = h_clyde_counter;
								v_clyde_cnt = v_clyde_counter + 1;
								clyde_next_state = `S2;
							end
						else if (!left_clyde_limit)
							begin
								if(!down_clyde_limit)
									begin
										h_clyde_cnt = h_clyde_counter;
										v_clyde_cnt = v_clyde_counter - 1;
										clyde_next_state = `S3;
									end
								else if (v_clyde_tile >= v_target_tile)
									begin
										h_clyde_cnt = h_clyde_counter;
										v_clyde_cnt = v_clyde_counter - 1;
										clyde_next_state = `S3;
									end
								else
									begin
										h_clyde_cnt = h_clyde_counter;
										v_clyde_cnt = v_clyde_counter + 1;
										clyde_next_state = `S2;
									end
							end
						else
							begin
								if (h_clyde_tile <= h_target_tile)
									begin
										if(v_clyde_tile <= v_target_tile)
											begin
												if(down_clyde_limit)
													begin
														h_clyde_cnt = h_clyde_counter;
														v_clyde_cnt = v_clyde_counter + 1;
														clyde_next_state = `S2;
													end
												else
													begin
														h_clyde_cnt = h_clyde_counter - 1;
														v_clyde_cnt = v_clyde_counter;
														clyde_next_state = `S1;
													end
											end
										else
											begin
												if(up_clyde_limit)
													begin
														h_clyde_cnt = h_clyde_counter;
														v_clyde_cnt = v_clyde_counter - 1;
														clyde_next_state = `S3;
													end
												else
													begin
														h_clyde_cnt = h_clyde_counter - 1;
														v_clyde_cnt = v_clyde_counter;
														clyde_next_state = `S1;
													end
											end
									end
								else
									begin
										h_clyde_cnt = h_clyde_counter - 1;
										v_clyde_cnt = v_clyde_counter;
										clyde_next_state = `S1;
									end
							end
					end
				`S2:										
					begin
						if((!down_clyde_limit) & (!right_clyde_limit))
							begin
								h_clyde_cnt = h_clyde_counter - 1;
								v_clyde_cnt = v_clyde_counter;
								clyde_next_state = `S1;
							end
						else if(!down_clyde_limit)
							begin
								if(!left_clyde_limit)
									begin
										h_clyde_cnt = h_clyde_counter + 1;
										v_clyde_cnt = v_clyde_counter;
										clyde_next_state = `S0;
									end
								else if (h_clyde_tile >= h_target_tile)
									begin
										h_clyde_cnt = h_clyde_counter - 1;
										v_clyde_cnt = v_clyde_counter;
										clyde_next_state = `S1;
									end
								else
									begin
										h_clyde_cnt = h_clyde_counter + 1;
										v_clyde_cnt = v_clyde_counter;
										clyde_next_state = `S0;
									end
							end
						else
							begin
								if(v_clyde_tile >= v_target_tile) 
									begin
										if(h_clyde_tile <= h_target_tile)
											begin
												if(right_clyde_limit)
													begin
														h_clyde_cnt = h_clyde_counter + 1;
														v_clyde_cnt = v_clyde_counter;
														clyde_next_state = `S0;
													end
												else
													begin
														h_clyde_cnt = h_clyde_counter;
														v_clyde_cnt = v_clyde_counter + 1;
														clyde_next_state = `S2;
													end
											end
										else
											begin
												if(left_clyde_limit)
													begin
														h_clyde_cnt = h_clyde_counter - 1;
														v_clyde_cnt = v_clyde_counter;
														clyde_next_state = `S1;
													end
												else
													begin
														h_clyde_cnt = h_clyde_counter;
														v_clyde_cnt = v_clyde_counter + 1;
														clyde_next_state = `S2;
													end
											end
									end
								else
									begin
										h_clyde_cnt = h_clyde_counter;
										v_clyde_cnt = v_clyde_counter + 1;
										clyde_next_state = `S2;
									end
							end
					end
				`S3:
					begin
						if((!up_clyde_limit) & (!right_clyde_limit))
							begin
								h_clyde_cnt = h_clyde_counter - 1;
								v_clyde_cnt = v_clyde_counter;
								clyde_next_state = `S1;
							end
						else if(!up_clyde_limit)
							begin
								if(!left_clyde_limit)
									begin
										h_clyde_cnt = h_clyde_counter + 1;
										v_clyde_cnt = v_clyde_counter;
										clyde_next_state = `S0;
									end
								else if (h_clyde_tile >= h_target_tile)
									begin
										h_clyde_cnt = h_clyde_counter - 1;
										v_clyde_cnt = v_clyde_counter;
										clyde_next_state = `S1;
									end
								else
									begin
										h_clyde_cnt = h_clyde_counter + 1;
										v_clyde_cnt = v_clyde_counter;
										clyde_next_state = `S0;
									end
							end
						else
							begin
								if(v_clyde_tile <= v_target_tile) 
									begin
										if(h_clyde_tile <= h_target_tile)
											begin
												if(right_clyde_limit)
													begin
														h_clyde_cnt = h_clyde_counter + 1;
														v_clyde_cnt = v_clyde_counter;
														clyde_next_state = `S0;
													end
												else
													begin
														h_clyde_cnt = h_clyde_counter;
														v_clyde_cnt = v_clyde_counter - 1;
														clyde_next_state = `S3;
													end
											end
										else
											begin
												if(left_clyde_limit)
													begin
														h_clyde_cnt = h_clyde_counter - 1;
														v_clyde_cnt = v_clyde_counter;
														clyde_next_state = `S1;
													end
												else
													begin
														h_clyde_cnt = h_clyde_counter;
														v_clyde_cnt = v_clyde_counter - 1;
														clyde_next_state = `S3;
													end
											end
									end
								else
									begin
										h_clyde_cnt = h_clyde_counter;
										v_clyde_cnt = v_clyde_counter - 1;
										clyde_next_state = `S3;
									end
							end
					end
				endcase
			end
//	ALWAYS SATEMENT clyde STATES ON
	always @ ( * )
		begin
			if(clyde_state == `S0)
				begin
					up_clyde_state = 0;
					down_clyde_state = 0;
					left_clyde_state = 0;
					right_clyde_state = 1;
				end
			else if(clyde_state == `S1)
				begin
					up_clyde_state = 0;
					down_clyde_state = 0;
					left_clyde_state = 1;
					right_clyde_state = 0;
				end
			else if(clyde_state == `S2)
				begin
					up_clyde_state = 0;
					down_clyde_state = 1;
					left_clyde_state = 0;
					right_clyde_state = 0;
				end
			else if(clyde_state == `S3)
				begin
					up_clyde_state = 1;
					down_clyde_state = 0;
					left_clyde_state = 0;
					right_clyde_state = 0;
				end
			else
				begin
					up_clyde_state = 0;
					down_clyde_state = 0;
					left_clyde_state = 0;
					right_clyde_state = 0;
				end
		end
// ALWAYS STATEMENT - clyde ROM
	always @ (posedge clk or posedge reset)	
		begin
			if (reset)
				begin
					h_clyde_addr <= `S6;
				end
			else if (clyde)
				h_clyde_addr <= h_clyde_addr + 1'b1;
			else if (!v_clyde)
				begin
					case(clyde_image)
						`S0: h_clyde_addr <= (scared_mode & (clyde_dead==0))?(image_sel?9217:8193):(image_sel?1025:1);
						`S1: h_clyde_addr <= (scared_mode & (clyde_dead==0))?(image_sel?9217:8193):(image_sel?3073:2049);
						`S2: h_clyde_addr <= (scared_mode & (clyde_dead==0))?(image_sel?9217:8193):(image_sel?7169:6145);
						`S3: h_clyde_addr <= (scared_mode & (clyde_dead==0))?(image_sel?9217:8193):(image_sel?5121:4097);
					endcase
				end
			else
				begin
					h_clyde_addr <= h_clyde_addr;
				end
		end	
//SCARED MODE BLINK
	always @ ( posedge clk or posedge reset)
		begin
			if(reset)
				begin
					blink <= 1;
					blink_counter <= 0;
				end
			else if((blink_counter == 5'h2e) & (!pause_en))
				begin
					blink <= blink + 1;
					blink_counter <= 0;
				end
			else if((!pause_en)&(vsync_enable))
				begin
					blink <= blink;
					blink_counter <= blink_counter + 1'b1;
				end
			else
				begin
					blink <= blink;
					blink_counter <= blink_counter;
				end						
		end
// PAC-MAN PIXEL COLOUR
	always @ ( * )
		begin
			/*if(clyde_tile)
				clyde_pixel = 8'h1c;
			else */if(clyde & (!end_of_game))
				begin
					case(clyde_pixel_sel)
						`S0: clyde_pixel = 8'b0;
						`S1: clyde_pixel = (clyde_dead==1)?8'h0:((scared_mode & (clyde_dead==0))?((scared_mode_end & blink)?8'hff:8'h03):8'hd1);
						`S2: clyde_pixel = ((scared_mode_end & blink & (clyde_dead==2'b0))?8'he0:8'hff);
						`S3: clyde_pixel = 8'h27;
					endcase
				end
			else
				clyde_pixel = 8'b0;
		end
	assign clyde_en = clyde;
endmodule 