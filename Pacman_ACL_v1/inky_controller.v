`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:19 08/13/2013 
// Design Name: 
// Module Name:    inky_controller 
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
module inky_controller(input clk, input reset, input vsync_enable, input chase, input [10:0] h_counter,
input [9:0] v_counter,input pause, input stall, input up_inky_limit, input down_inky_limit, 
input left_inky_limit, input right_inky_limit, input [4:0] h_inky_tile,
input [4:0] v_inky_tile, input [4:0] h_pacman_tile, input [4:0] v_pacman_tile,
input [4:0] h_blinky_tile, input [4:0] v_blinky_tile,
input scared_mode, input scared_mode_end, input end_of_game, input [1:0] inky_pixel_sel, input up_pacman_state,
input down_pacman_state, input left_pacman_state, input right_pacman_state,
input [1:0] inky_dead,input pacman_dead,
output reg [7:0] inky_pixel, output inky_en, output [10:0] h_inky_tile_counter,
output [9:0] v_inky_tile_counter, output reg up_inky_state, output reg down_inky_state,
output reg left_inky_state, output reg right_inky_state, output reg [13:0] h_inky_addr);
// REGISTER DEFINITIONS
	reg blink;
	reg [4:0] blink_counter;
	reg image_sel;
	reg image_sel_1;
	reg inky_slow;
	reg [4:0] h_target_tile;
	reg [4:0] v_target_tile;
	reg [1:0] inky_state;
	reg [1:0] inky_image;
	reg [1:0] inky_next_state;
	reg [3:0] movement_en;
	reg [10:0] h_inky_counter;
	reg [9:0] v_inky_counter;
	reg [10:0] h_inky_cnt;
	reg [9:0] v_inky_cnt;
// WIRE DEFINITIONS
	
	wire h_inky = (h_counter > (h_limit_on)) &
						 (h_counter < (h_limit_off));
	wire v_inky = (v_counter > (v_limit_on)) &
						 (v_counter < (v_limit_off));
	wire inky = h_inky & v_inky;
	
	wire [10:0] h_limit_on =  h_inky_counter;
	wire [10:0] h_limit_off= (`H_INKY_SIZE + h_inky_counter);
	wire [9:0] v_limit_on = v_inky_counter;
	wire [9:0] v_limit_off= (`V_INKY_SIZE + v_inky_counter);
	
	wire inky_tile = (h_counter == (h_inky_tile_counter)) &
							 (v_counter == (v_inky_tile_counter));
	
	assign h_inky_tile_counter = (h_limit_on + 5'b10001);
	assign v_inky_tile_counter = (v_limit_on + 5'b10001);
	assign pause_en = (pause | stall);
	
// inky MOVEMENT
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					image_sel <= 1;
					inky_slow <= 1;
					movement_en <= 0;
					inky_image <= 0;
					inky_state <= 0;
					h_inky_counter <= `H_INKY_ON;
					v_inky_counter <= `V_INKY_ON;
				end
			else if(pacman_dead || end_of_game)
				begin
					image_sel <= 1;
					inky_slow <= 1;
					movement_en <= 0;
					inky_image <= 0;
					inky_state <= 0;
					h_inky_counter <= `H_INKY_ON;
					v_inky_counter <= `V_INKY_ON;
				end
			else if (vsync_enable & inky_slow &(!pause_en))
				begin
					if (movement_en == 4'b1010)
						begin
							image_sel <= image_sel_1;
							movement_en <= 0;
						end
					else
						image_sel <= image_sel;
					inky_slow <= (inky_dead>0)?1:(!scared_mode);
					movement_en <= movement_en + 1;
					h_inky_counter <= h_inky_cnt;
					v_inky_counter <= v_inky_cnt;
					inky_state <= inky_next_state;
					inky_image <= inky_next_state;
				end
			else
				begin
					image_sel <= image_sel;
					inky_slow <= 1;
					movement_en <= movement_en;
					h_inky_counter <= h_inky_counter;
					v_inky_counter <= v_inky_counter;
					inky_state <= inky_state;
				end
		end
// TARGET TILE CALCULATION
	always @ ( * )
		begin
			if(((inky_dead == 1) || (scared_mode && (inky_dead == 0))))
				begin
					h_target_tile = 14;
					v_target_tile = 12;
				end
			else if(chase)
				begin
					h_target_tile = 25;
					v_target_tile = 32;
				end
			else
				begin
					h_target_tile = 0;
					v_target_tile = 0;
					if(up_pacman_state)
						begin
							h_target_tile = (((h_pacman_tile)<<1)- h_blinky_tile);
							v_target_tile = (((v_pacman_tile - 2)<<1)- v_blinky_tile);
						end
					if(down_pacman_state)
						begin
							h_target_tile = (((h_pacman_tile)<<1)-h_blinky_tile);
							v_target_tile = (((v_pacman_tile + 2)<<1)- v_blinky_tile);
						end
					if(left_pacman_state)
						begin
							h_target_tile = (((h_pacman_tile - 2)<<1)-h_blinky_tile);
							v_target_tile = (((v_pacman_tile)<<1)- v_blinky_tile);
						end
					if(right_pacman_state)
						begin
							h_target_tile = (((h_pacman_tile+2)<<1)-h_blinky_tile);
							v_target_tile = (((v_pacman_tile)<<1)- v_blinky_tile);
						end
					h_target_tile = (h_target_tile<0)?0:h_target_tile;
					v_target_tile = (v_target_tile<0)?0:v_target_tile;
				end			
		end
// inky MOVEMENT : Finite State Machine (FSM)
		always @ ( * )
			begin
				image_sel_1 = ~ image_sel;
				case(inky_state)
					`S0:
						begin
							if(h_inky_counter == (`H_BOARD_OFF-`H_INKY_SIZE))
								begin
									h_inky_cnt = `H_BOARD_ON + 1;
									v_inky_cnt = `V_PACMAN_ON - 180;
									inky_next_state = `S0;
								end
							else if((!right_inky_limit) & (!up_inky_limit))
								begin
									h_inky_cnt = h_inky_counter;
									v_inky_cnt = v_inky_counter + 1;
									inky_next_state = `S2;
								end
							else if (!right_inky_limit)
								begin
									if(!down_inky_limit)
										begin
											h_inky_cnt = h_inky_counter;
											v_inky_cnt = v_inky_counter - 1;
											inky_next_state = `S3;
										end
									else if (v_inky_tile >= v_target_tile)
										begin
											h_inky_cnt = h_inky_counter;
											v_inky_cnt = v_inky_counter - 1;
											inky_next_state = `S3;
										end
									else
										begin
											h_inky_cnt = h_inky_counter;
											v_inky_cnt = v_inky_counter + 1;
											inky_next_state = `S2;
										end
								end
							else
								begin
									if (h_inky_tile >= h_target_tile)
										begin
											if(v_inky_tile <= v_target_tile)
												begin
													if(down_inky_limit)
														begin
															h_inky_cnt = h_inky_counter;
															v_inky_cnt = v_inky_counter + 1;
															inky_next_state = `S2;
														end
													else
														begin
															h_inky_cnt = h_inky_counter + 1;
															v_inky_cnt = v_inky_counter;
															inky_next_state = `S0;
														end
												end
											else
												begin
													if(up_inky_limit)
														begin
															h_inky_cnt = h_inky_counter;
															v_inky_cnt = v_inky_counter - 1;
															inky_next_state = `S3;
														end
													else
														begin
															h_inky_cnt = h_inky_counter + 1;
															v_inky_cnt = v_inky_counter;
															inky_next_state = `S0;
														end
												end
										end
									else
										begin
											h_inky_cnt = h_inky_counter + 1;
											v_inky_cnt = v_inky_counter;
											inky_next_state = `S0;
										end
								end
						end
				`S1:
					begin
						if(h_inky_counter == `H_BOARD_ON)
							begin
								h_inky_cnt = `H_BOARD_OFF - 1;
								v_inky_cnt = `V_PACMAN_ON - 180;
								inky_next_state = `S1;
							end
						else if((!left_inky_limit) & (!up_inky_limit))
							begin
								h_inky_cnt = h_inky_counter;
								v_inky_cnt = v_inky_counter + 1;
								inky_next_state = `S2;
							end
						else if (!left_inky_limit)
							begin
								if(!down_inky_limit)
									begin
										h_inky_cnt = h_inky_counter;
										v_inky_cnt = v_inky_counter - 1;
										inky_next_state = `S3;
									end
								else if (v_inky_tile >= v_target_tile)
									begin
										h_inky_cnt = h_inky_counter;
										v_inky_cnt = v_inky_counter - 1;
										inky_next_state = `S3;
									end
								else
									begin
										h_inky_cnt = h_inky_counter;
										v_inky_cnt = v_inky_counter + 1;
										inky_next_state = `S2;
									end
							end
						else
							begin
								if (h_inky_tile <= h_target_tile)
									begin
										if(v_inky_tile <= v_target_tile)
											begin
												if(down_inky_limit)
													begin
														h_inky_cnt = h_inky_counter;
														v_inky_cnt = v_inky_counter + 1;
														inky_next_state = `S2;
													end
												else
													begin
														h_inky_cnt = h_inky_counter - 1;
														v_inky_cnt = v_inky_counter;
														inky_next_state = `S1;
													end
											end
										else
											begin
												if(up_inky_limit)
													begin
														h_inky_cnt = h_inky_counter;
														v_inky_cnt = v_inky_counter - 1;
														inky_next_state = `S3;
													end
												else
													begin
														h_inky_cnt = h_inky_counter - 1;
														v_inky_cnt = v_inky_counter;
														inky_next_state = `S1;
													end
											end
									end
								else
									begin
										h_inky_cnt = h_inky_counter - 1;
										v_inky_cnt = v_inky_counter;
										inky_next_state = `S1;
									end
							end
					end
				`S2:										
					begin
						if((!down_inky_limit) & (!right_inky_limit))
							begin
								h_inky_cnt = h_inky_counter - 1;
								v_inky_cnt = v_inky_counter;
								inky_next_state = `S1;
							end
						else if(!down_inky_limit)
							begin
								if(!left_inky_limit)
									begin
										h_inky_cnt = h_inky_counter + 1;
										v_inky_cnt = v_inky_counter;
										inky_next_state = `S0;
									end
								else if (h_inky_tile >= h_target_tile)
									begin
										h_inky_cnt = h_inky_counter - 1;
										v_inky_cnt = v_inky_counter;
										inky_next_state = `S1;
									end
								else
									begin
										h_inky_cnt = h_inky_counter + 1;
										v_inky_cnt = v_inky_counter;
										inky_next_state = `S0;
									end
							end
						else
							begin
								if(v_inky_tile >= v_target_tile) 
									begin
										if(h_inky_tile <= h_target_tile)
											begin
												if(right_inky_limit)
													begin
														h_inky_cnt = h_inky_counter + 1;
														v_inky_cnt = v_inky_counter;
														inky_next_state = `S0;
													end
												else
													begin
														h_inky_cnt = h_inky_counter;
														v_inky_cnt = v_inky_counter + 1;
														inky_next_state = `S2;
													end
											end
										else
											begin
												if(left_inky_limit)
													begin
														h_inky_cnt = h_inky_counter - 1;
														v_inky_cnt = v_inky_counter;
														inky_next_state = `S1;
													end
												else
													begin
														h_inky_cnt = h_inky_counter;
														v_inky_cnt = v_inky_counter + 1;
														inky_next_state = `S2;
													end
											end
									end
								else
									begin
										h_inky_cnt = h_inky_counter;
										v_inky_cnt = v_inky_counter + 1;
										inky_next_state = `S2;
									end
							end
					end
				`S3:
					begin
						if((!up_inky_limit) & (!right_inky_limit))
							begin
								h_inky_cnt = h_inky_counter - 1;
								v_inky_cnt = v_inky_counter;
								inky_next_state = `S1;
							end
						else if(!up_inky_limit)
							begin
								if(!left_inky_limit)
									begin
										h_inky_cnt = h_inky_counter + 1;
										v_inky_cnt = v_inky_counter;
										inky_next_state = `S0;
									end
								else if (h_inky_tile >= h_target_tile)
									begin
										h_inky_cnt = h_inky_counter - 1;
										v_inky_cnt = v_inky_counter;
										inky_next_state = `S1;
									end
								else
									begin
										h_inky_cnt = h_inky_counter + 1;
										v_inky_cnt = v_inky_counter;
										inky_next_state = `S0;
									end
							end
						else
							begin
								if(v_inky_tile <= v_target_tile) 
									begin
										if(h_inky_tile <= h_target_tile)
											begin
												if(right_inky_limit)
													begin
														h_inky_cnt = h_inky_counter + 1;
														v_inky_cnt = v_inky_counter;
														inky_next_state = `S0;
													end
												else
													begin
														h_inky_cnt = h_inky_counter;
														v_inky_cnt = v_inky_counter - 1;
														inky_next_state = `S3;
													end
											end
										else
											begin
												if(left_inky_limit)
													begin
														h_inky_cnt = h_inky_counter - 1;
														v_inky_cnt = v_inky_counter;
														inky_next_state = `S1;
													end
												else
													begin
														h_inky_cnt = h_inky_counter;
														v_inky_cnt = v_inky_counter - 1;
														inky_next_state = `S3;
													end
											end
									end
								else
									begin
										h_inky_cnt = h_inky_counter;
										v_inky_cnt = v_inky_counter - 1;
										inky_next_state = `S3;
									end
							end
					end
				endcase
			end
//	ALWAYS SATEMENT inky STATES ON
	always @ ( * )
		begin
			if(inky_state == `S0)
				begin
					up_inky_state = 0;
					down_inky_state = 0;
					left_inky_state = 0;
					right_inky_state = 1;
				end
			else if(inky_state == `S1)
				begin
					up_inky_state = 0;
					down_inky_state = 0;
					left_inky_state = 1;
					right_inky_state = 0;
				end
			else if(inky_state == `S2)
				begin
					up_inky_state = 0;
					down_inky_state = 1;
					left_inky_state = 0;
					right_inky_state = 0;
				end
			else if(inky_state == `S3)
				begin
					up_inky_state = 1;
					down_inky_state = 0;
					left_inky_state = 0;
					right_inky_state = 0;
				end
			else
				begin
					up_inky_state = 0;
					down_inky_state = 0;
					left_inky_state = 0;
					right_inky_state = 0;
				end
		end
// ALWAYS STATEMENT - inky ROM
		always @ (posedge clk or posedge reset)	
		begin
			if (reset)
				begin
					h_inky_addr <= `S6;
				end
			else if (inky)
				h_inky_addr <= h_inky_addr + 1'b1;
			else if (!v_inky)
				begin
					case(inky_image)
						`S0: h_inky_addr <= (scared_mode & (inky_dead==0))?(image_sel?9217:8193):(image_sel?1025:1);
						`S1: h_inky_addr <= (scared_mode & (inky_dead==0))?(image_sel?9217:8193):(image_sel?3073:2049);
						`S2: h_inky_addr <= (scared_mode & (inky_dead==0))?(image_sel?9217:8193):(image_sel?7169:6145);
						`S3: h_inky_addr <= (scared_mode & (inky_dead==0))?(image_sel?9217:8193):(image_sel?5121:4097);
					endcase
				end
			else
				begin
					h_inky_addr <= h_inky_addr;
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
			/*if(inky_tile)
				inky_pixel = 8'h1c;
			else*/if(inky & (!end_of_game))
				begin
					case(inky_pixel_sel)
						`S0: inky_pixel = 8'b0;
						`S1: inky_pixel = (inky_dead==1)?8'h0:(((scared_mode & (inky_dead==0)))?((scared_mode_end & blink)?8'hff:8'h03):8'h16);
						`S2: inky_pixel = ((scared_mode_end & blink & (inky_dead==2'b0))?8'he0:8'hff);
						`S3: inky_pixel = 8'h27;
					endcase
				end
			else
				inky_pixel = 8'b0;
		end
	assign inky_en = inky;
endmodule 