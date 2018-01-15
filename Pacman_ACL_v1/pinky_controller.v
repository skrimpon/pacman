`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:19 08/13/2013 
// Design Name: 
// Module Name:    pinky_controller 
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
module pinky_controller(input clk, input reset, input vsync_enable, input chase, input [10:0] h_counter,
input [9:0] v_counter,input pause, input stall, input up_pinky_limit, input down_pinky_limit, 
input left_pinky_limit, input right_pinky_limit, input [4:0] h_pinky_tile,
input [4:0] v_pinky_tile, input [4:0] h_pacman_tile, input [4:0] v_pacman_tile,
input scared_mode, input scared_mode_end, input end_of_game, input [1:0] pinky_pixel_sel, input up_pacman_state,
input down_pacman_state, input left_pacman_state, input right_pacman_state,
input [1:0] pinky_dead,input pacman_dead,
output reg [7:0] pinky_pixel, output pinky_en, output [10:0] h_pinky_tile_counter,
output [9:0] v_pinky_tile_counter, output reg up_pinky_state, output reg down_pinky_state,
output reg left_pinky_state, output reg right_pinky_state, output reg [13:0] h_pinky_addr);
// REGISTER DEFINITIONS
	reg blink;
	reg [4:0] blink_counter;
	reg image_sel;
	reg image_sel_1;
	reg pinky_slow;
	reg [4:0] h_target_tile;
	reg [4:0] v_target_tile;
	reg [1:0] pinky_state;
	reg [1:0] pinky_image;
	reg [1:0] pinky_next_state;
	reg [3:0] movement_en;
	reg [10:0] h_pinky_counter;
	reg [9:0] v_pinky_counter;
	reg [10:0] h_pinky_cnt;
	reg [9:0] v_pinky_cnt;
// WIRE DEFINITIONS
	
	wire h_pinky = (h_counter > (h_limit_on)) &
						 (h_counter < (h_limit_off));
	wire v_pinky = (v_counter > (v_limit_on)) &
						 (v_counter < (v_limit_off));
	wire pinky = h_pinky & v_pinky;
	
	wire [10:0] h_limit_on =  h_pinky_counter;
	wire [10:0] h_limit_off= (`H_PINKY_SIZE + h_pinky_counter);
	wire [9:0] v_limit_on = v_pinky_counter;

	wire [9:0] v_limit_off= (`V_PINKY_SIZE + v_pinky_counter);
	
	wire pinky_tile = (h_counter == (h_pinky_tile_counter)) &
							 (v_counter == (v_pinky_tile_counter));
	
	assign h_pinky_tile_counter = (h_limit_on + 5'b10001);
	assign v_pinky_tile_counter = (v_limit_on + 5'b10001);
	assign pause_en = (pause | stall);
	
// pinky MOVEMENT
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					image_sel <= 1;
					pinky_slow <= 1;
					movement_en <= 0;
					pinky_image <= 0;
					pinky_state <= 0;
					h_pinky_counter <= `H_PINKY_ON;
					v_pinky_counter <= `V_PINKY_ON;
				end
			else if(pacman_dead || end_of_game)
				begin
					image_sel <= 1;
					pinky_slow <= 1;
					movement_en <= 0;
					pinky_image <= 0;
					pinky_state <= 0;
					h_pinky_counter <= `H_PINKY_ON;
					v_pinky_counter <= `V_PINKY_ON;
				end
			else if (vsync_enable & pinky_slow &(!pause_en))
				begin
					if (movement_en == 4'b1010)
						begin
							image_sel <= image_sel_1;
							movement_en <= 0;
						end
					else
						image_sel <= image_sel;
					pinky_slow <= (pinky_dead>0)?1:(!scared_mode);
					movement_en <= movement_en + 1;
					h_pinky_counter <= h_pinky_cnt;
					v_pinky_counter <= v_pinky_cnt;
					pinky_state <= pinky_next_state;
					pinky_image <= pinky_next_state;
				end
			else
				begin
					image_sel <= image_sel;
					pinky_slow <= 1;
					movement_en <= movement_en;
					h_pinky_counter <= h_pinky_counter;
					v_pinky_counter <= v_pinky_counter;
					pinky_state <= pinky_state;
				end
		end
// TARGET TILE CALCULATION
	always @ ( * )
		begin
			if(((pinky_dead == 1) || (scared_mode && (pinky_dead == 0))))
				begin
					h_target_tile = 14;
					v_target_tile = 12;
				end
			else if(chase)
				begin
					h_target_tile = 1;
					v_target_tile = 3;
				end
			else
				begin
					h_target_tile = 0;
					v_target_tile = 0;
					if(up_pacman_state)
						begin
							h_target_tile = h_pacman_tile;
							v_target_tile = ((v_pacman_tile - 4)<0)?0:(v_pacman_tile - 4);
						end
					if(down_pacman_state)
						begin
							h_target_tile = h_pacman_tile;
							v_target_tile = (v_pacman_tile + 4);
						end
					if(left_pacman_state)
						begin
							h_target_tile = ((h_pacman_tile - 4)<0)?0:(h_pacman_tile - 4);
							v_target_tile = v_pacman_tile;
						end
					if(right_pacman_state)
						begin
							h_target_tile = (h_pacman_tile + 4);
							v_target_tile = v_pacman_tile;
						end
				end				
		end
// pinky MOVEMENT : Finite State Machine (FSM)
		always @ ( * )
			begin
				image_sel_1 = ~ image_sel;
				case(pinky_state)
					`S0:
						begin
							if(h_pinky_counter == (`H_BOARD_OFF-`H_PINKY_SIZE))
								begin
									h_pinky_cnt = `H_BOARD_ON + 1;
									v_pinky_cnt = `V_PACMAN_ON - 180;
									pinky_next_state = `S0;
								end
							else if((!right_pinky_limit) & (!up_pinky_limit))
								begin
									h_pinky_cnt = h_pinky_counter;
									v_pinky_cnt = v_pinky_counter + 1;
									pinky_next_state = `S2;
								end
							else if (!right_pinky_limit)
								begin
									if(!down_pinky_limit)
										begin
											h_pinky_cnt = h_pinky_counter;
											v_pinky_cnt = v_pinky_counter - 1;
											pinky_next_state = `S3;
										end
									else if (v_pinky_tile >= v_target_tile)
										begin
											h_pinky_cnt = h_pinky_counter;
											v_pinky_cnt = v_pinky_counter - 1;
											pinky_next_state = `S3;
										end
									else
										begin
											h_pinky_cnt = h_pinky_counter;
											v_pinky_cnt = v_pinky_counter + 1;
											pinky_next_state = `S2;
										end
								end
							else
								begin
									if (h_pinky_tile >= h_target_tile)
										begin
											if(v_pinky_tile <= v_target_tile)
												begin
													if(down_pinky_limit)
														begin
															h_pinky_cnt = h_pinky_counter;
															v_pinky_cnt = v_pinky_counter + 1;
															pinky_next_state = `S2;
														end
													else
														begin
															h_pinky_cnt = h_pinky_counter + 1;
															v_pinky_cnt = v_pinky_counter;
															pinky_next_state = `S0;
														end
												end
											else
												begin
													if(up_pinky_limit)
														begin
															h_pinky_cnt = h_pinky_counter;
															v_pinky_cnt = v_pinky_counter - 1;
															pinky_next_state = `S3;
														end
													else
														begin
															h_pinky_cnt = h_pinky_counter + 1;
															v_pinky_cnt = v_pinky_counter;
															pinky_next_state = `S0;
														end
												end
										end
									else
										begin
											h_pinky_cnt = h_pinky_counter + 1;
											v_pinky_cnt = v_pinky_counter;
											pinky_next_state = `S0;
										end
								end
						end
				`S1:
					begin
						if(h_pinky_counter == `H_BOARD_ON)
							begin
								h_pinky_cnt = `H_BOARD_OFF - 1;
								v_pinky_cnt = `V_PACMAN_ON - 180;
								pinky_next_state = `S1;
							end
						else if((!left_pinky_limit) & (!up_pinky_limit))
							begin
								h_pinky_cnt = h_pinky_counter;
								v_pinky_cnt = v_pinky_counter + 1;
								pinky_next_state = `S2;
							end
						else if (!left_pinky_limit)
							begin
								if(!down_pinky_limit)
									begin
										h_pinky_cnt = h_pinky_counter;
										v_pinky_cnt = v_pinky_counter - 1;
										pinky_next_state = `S3;
									end
								else if (v_pinky_tile >= v_target_tile)
									begin
										h_pinky_cnt = h_pinky_counter;
										v_pinky_cnt = v_pinky_counter - 1;
										pinky_next_state = `S3;
									end
								else
									begin
										h_pinky_cnt = h_pinky_counter;
										v_pinky_cnt = v_pinky_counter + 1;
										pinky_next_state = `S2;
									end
							end
						else
							begin
								if (h_pinky_tile <= h_target_tile)
									begin
										if(v_pinky_tile <= v_target_tile)
											begin
												if(down_pinky_limit)
													begin
														h_pinky_cnt = h_pinky_counter;
														v_pinky_cnt = v_pinky_counter + 1;
														pinky_next_state = `S2;
													end
												else
													begin
														h_pinky_cnt = h_pinky_counter - 1;
														v_pinky_cnt = v_pinky_counter;
														pinky_next_state = `S1;
													end
											end
										else
											begin
												if(up_pinky_limit)
													begin
														h_pinky_cnt = h_pinky_counter;
														v_pinky_cnt = v_pinky_counter - 1;
														pinky_next_state = `S3;
													end
												else
													begin
														h_pinky_cnt = h_pinky_counter - 1;
														v_pinky_cnt = v_pinky_counter;
														pinky_next_state = `S1;
													end
											end
									end
								else
									begin
										h_pinky_cnt = h_pinky_counter - 1;
										v_pinky_cnt = v_pinky_counter;
										pinky_next_state = `S1;
									end
							end
					end
				`S2:										
					begin
						if((!down_pinky_limit) & (!right_pinky_limit))
							begin
								h_pinky_cnt = h_pinky_counter - 1;
								v_pinky_cnt = v_pinky_counter;
								pinky_next_state = `S1;
							end
						else if(!down_pinky_limit)
							begin
								if(!left_pinky_limit)
									begin
										h_pinky_cnt = h_pinky_counter + 1;
										v_pinky_cnt = v_pinky_counter;
										pinky_next_state = `S0;
									end
								else if (h_pinky_tile >= h_target_tile)
									begin
										h_pinky_cnt = h_pinky_counter - 1;
										v_pinky_cnt = v_pinky_counter;
										pinky_next_state = `S1;
									end
								else
									begin
										h_pinky_cnt = h_pinky_counter + 1;
										v_pinky_cnt = v_pinky_counter;
										pinky_next_state = `S0;
									end
							end
						else
							begin
								if(v_pinky_tile >= v_target_tile) 
									begin
										if(h_pinky_tile <= h_target_tile)
											begin
												if(right_pinky_limit)
													begin
														h_pinky_cnt = h_pinky_counter + 1;
														v_pinky_cnt = v_pinky_counter;
														pinky_next_state = `S0;
													end
												else
													begin
														h_pinky_cnt = h_pinky_counter;
														v_pinky_cnt = v_pinky_counter + 1;
														pinky_next_state = `S2;
													end
											end
										else
											begin
												if(left_pinky_limit)
													begin
														h_pinky_cnt = h_pinky_counter - 1;
														v_pinky_cnt = v_pinky_counter;
														pinky_next_state = `S1;
													end
												else
													begin
														h_pinky_cnt = h_pinky_counter;
														v_pinky_cnt = v_pinky_counter + 1;
														pinky_next_state = `S2;
													end
											end
									end
								else
									begin
										h_pinky_cnt = h_pinky_counter;
										v_pinky_cnt = v_pinky_counter + 1;
										pinky_next_state = `S2;
									end
							end
					end
				`S3:
					begin
						if((!up_pinky_limit) & (!right_pinky_limit))
							begin
								h_pinky_cnt = h_pinky_counter - 1;
								v_pinky_cnt = v_pinky_counter;
								pinky_next_state = `S1;
							end
						else if(!up_pinky_limit)
							begin
								if(!left_pinky_limit)
									begin
										h_pinky_cnt = h_pinky_counter + 1;
										v_pinky_cnt = v_pinky_counter;
										pinky_next_state = `S0;
									end
								else if (h_pinky_tile >= h_target_tile)
									begin
										h_pinky_cnt = h_pinky_counter - 1;
										v_pinky_cnt = v_pinky_counter;
										pinky_next_state = `S1;
									end
								else
									begin
										h_pinky_cnt = h_pinky_counter + 1;
										v_pinky_cnt = v_pinky_counter;
										pinky_next_state = `S0;
									end
							end
						else
							begin
								if(v_pinky_tile <= v_target_tile) 
									begin
										if(h_pinky_tile <= h_target_tile)
											begin
												if(right_pinky_limit)
													begin
														h_pinky_cnt = h_pinky_counter + 1;
														v_pinky_cnt = v_pinky_counter;
														pinky_next_state = `S0;
													end
												else
													begin
														h_pinky_cnt = h_pinky_counter;
														v_pinky_cnt = v_pinky_counter - 1;
														pinky_next_state = `S3;
													end
											end
										else
											begin
												if(left_pinky_limit)
													begin
														h_pinky_cnt = h_pinky_counter - 1;
														v_pinky_cnt = v_pinky_counter;
														pinky_next_state = `S1;
													end
												else
													begin
														h_pinky_cnt = h_pinky_counter;
														v_pinky_cnt = v_pinky_counter - 1;
														pinky_next_state = `S3;
													end
											end
									end
								else
									begin
										h_pinky_cnt = h_pinky_counter;
										v_pinky_cnt = v_pinky_counter - 1;
										pinky_next_state = `S3;
									end
							end
					end
				endcase
			end
//	ALWAYS SATEMENT pinky STATES ON
	always @ ( * )
		begin
			if(pinky_state == `S0)
				begin
					up_pinky_state = 0;
					down_pinky_state = 0;
					left_pinky_state = 0;
					right_pinky_state = 1;
				end
			else if(pinky_state == `S1)
				begin
					up_pinky_state = 0;
					down_pinky_state = 0;
					left_pinky_state = 1;
					right_pinky_state = 0;
				end
			else if(pinky_state == `S2)
				begin
					up_pinky_state = 0;
					down_pinky_state = 1;
					left_pinky_state = 0;
					right_pinky_state = 0;
				end
			else if(pinky_state == `S3)
				begin
					up_pinky_state = 1;
					down_pinky_state = 0;
					left_pinky_state = 0;
					right_pinky_state = 0;
				end
			else
				begin
					up_pinky_state = 0;
					down_pinky_state = 0;
					left_pinky_state = 0;
					right_pinky_state = 0;
				end
		end
// ALWAYS STATEMENT - pinky ROM
		always @ (posedge clk or posedge reset)	
		begin
			if (reset)
				begin
					h_pinky_addr <= `S6;
				end
			else if (pinky)
				h_pinky_addr <= h_pinky_addr + 1'b1;
			else if (!v_pinky)
				begin
					case(pinky_image)
						`S0: h_pinky_addr <= (scared_mode & (pinky_dead==0))?(image_sel?9217:8193):(image_sel?1025:1);
						`S1: h_pinky_addr <= (scared_mode & (pinky_dead==0))?(image_sel?9217:8193):(image_sel?3073:2049);
						`S2: h_pinky_addr <= (scared_mode & (pinky_dead==0))?(image_sel?9217:8193):(image_sel?7169:6145);
						`S3: h_pinky_addr <= (scared_mode & (pinky_dead==0))?(image_sel?9217:8193):(image_sel?5121:4097);
					endcase
				end
			else
				begin
					h_pinky_addr <= h_pinky_addr;
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
			/*if(pinky_tile)
				pinky_pixel = 8'h1c;
			else */if(pinky & (!end_of_game))
				begin
					case(pinky_pixel_sel)
						`S0: pinky_pixel = 8'b0;
						`S1: pinky_pixel = (pinky_dead==1)?8'h0:((scared_mode & (pinky_dead==0))?((scared_mode_end & blink)?8'hff:8'h03):8'hcf);
						`S2: pinky_pixel = ((scared_mode_end & blink & (pinky_dead==2'b0))?8'he0:8'hff);
						`S3: pinky_pixel = 8'h27;
					endcase
				end
			else
				pinky_pixel = 8'b0;
		end
	assign pinky_en = pinky;
endmodule 