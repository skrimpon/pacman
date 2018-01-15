`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:19 08/13/2013 
// Design Name: 
// Module Name:    blinky_controller 
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
module blinky_controller(
	 input clk, 
	 input reset, 
	 input pause, 
	 input stall,
	 input chase,
	 input end_of_game,
	 input pacman_dead,
	 input scared_mode, 
	 input vsync_enable, 
	 input scared_mode_end, 
	 input up_blinky_limit,
	 input down_blinky_limit, 
	 input left_blinky_limit,
	 input right_blinky_limit, 
	 input [1:0] blinky_dead,
	 input [1:0] blinky_pixel_sel,
	 input [4:0] h_blinky_tile,
	 input [4:0] v_blinky_tile,
	 input [4:0] h_pacman_tile,
	 input [4:0] v_pacman_tile,
	 input [9:0] v_counter,
	 input [10:0] h_counter,
	 output blinky_en,
	 output [9:0] v_blinky_tile_counter, 
	 output [10:0] h_blinky_tile_counter,
	 output reg up_blinky_state, 
	 output reg down_blinky_state,
	 output reg left_blinky_state, 
	 output reg right_blinky_state,
	 output reg [7:0] blinky_pixel,
	 output reg [13:0] h_blinky_addr
	 );
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	reg blink;
	reg [4:0] blink_counter;
	reg image_sel;
	reg image_sel_1;
	reg blinky_slow;
	reg [4:0] h_target_tile;
	reg [4:0] v_target_tile;
	reg [1:0] blinky_state;
	reg [1:0] blinky_image;
	reg [1:0] blinky_next_state;
	reg [3:0] movement_en;
	reg [9:0] v_blinky_cnt;
	reg [9:0] v_blinky_counter;
	reg [10:0] h_blinky_counter;
	reg [10:0] h_blinky_cnt;
	
	wire h_blinky = (h_counter > (h_limit_on)) &
						 (h_counter < (h_limit_off));
	wire v_blinky = (v_counter > (v_limit_on)) &
						 (v_counter < (v_limit_off));
	wire blinky = h_blinky & v_blinky;
	
	wire [9:0] v_limit_on = v_blinky_counter;
	wire [9:0] v_limit_off= (`V_BLINKY_SIZE + v_blinky_counter);
	wire [10:0] h_limit_on =  h_blinky_counter;
	wire [10:0] h_limit_off= (`H_BLINKY_SIZE + h_blinky_counter);
	
	wire blinky_tile = (h_counter == (h_blinky_tile_counter)) &
							 (v_counter == (v_blinky_tile_counter));
	
	assign h_blinky_tile_counter = (h_limit_on + 5'b10001);
	assign v_blinky_tile_counter = (v_limit_on + 5'b10001);
	assign pause_en = (pause | stall);// ====================================================================================
// 										 Implementation
// ====================================================================================
	//-----------------------------------------------
	//					Read the ROM
	// 		display the map on the screen 
	//-----------------------------------------------
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					image_sel <= 1;
					blinky_slow <= 1;
					movement_en <= 0;
					blinky_image <= 0;
					blinky_state <= 0;
					h_blinky_counter <= `H_BLINKY_ON;
					v_blinky_counter <= `V_BLINKY_ON;
				end
			else if(pacman_dead || end_of_game)
				begin
					image_sel <= 1;
					blinky_slow <= 1;
					movement_en <= 0;
					blinky_image <= 0;
					blinky_state <= 0;
					h_blinky_counter <= `H_BLINKY_ON;
					v_blinky_counter <= `V_BLINKY_ON;
				end
			else if (vsync_enable & blinky_slow &(!pause_en))
				begin
					if (movement_en == 4'b1010)
						begin
							image_sel <= image_sel_1;
							movement_en <= 0;
						end
					else
						image_sel <= image_sel;
					blinky_slow <= (blinky_dead>0)?1:(!scared_mode);
					movement_en <= movement_en + 1;
					h_blinky_counter <= h_blinky_cnt;
					v_blinky_counter <= v_blinky_cnt;
					blinky_state <= blinky_next_state;
					blinky_image <= blinky_next_state;
				end
			else
				begin
					image_sel <= image_sel;
					blinky_slow <= 1;
					movement_en <= movement_en;
					h_blinky_counter <= h_blinky_counter;
					v_blinky_counter <= v_blinky_counter;
					blinky_state <= blinky_state;
				end
		end
	//-----------------------------------------------
	//			CALCULATE BLINKY TARGET TILE
	//-----------------------------------------------
	always @ ( * )
		begin
			// if blinky is dead or blue target tile is his start tile
			if(((blinky_dead == 1) || (scared_mode &&(blinky_dead == 0))))
				begin
					h_target_tile = 14;
					v_target_tile = 12;
				end
			// if blinky is not in chase mode target tile is the upper left corner
			else if(chase)
				begin
					h_target_tile = 1;
					v_target_tile = 25;
				end
			// if blinky is in chase mode target tile is pacman's tile
			else
				begin
					h_target_tile = h_pacman_tile;
					v_target_tile = v_pacman_tile;
				end
		end
	//-----------------------------------------------------
	//		BLINKY MOVEMENT FSM: STATE 0 : BLINKY GOES RIGHT 
	//									STATE 1 : BLINKY GOES LEFT
	//									STATE 2 : BLINKY GOES DOWN
	//									STATE 3 : BLINKY GOES UP
	//-----------------------------------------------------
		always @ ( * )
			begin
				image_sel_1 = ~ image_sel;	// Change image in order to make blinky looks like moving
				case(blinky_state)
					`S0:
						begin
							if(h_blinky_counter == (`H_BOARD_OFF-`H_BLINKY_SIZE))
								begin
									h_blinky_cnt = `H_BOARD_ON + 1;
									v_blinky_cnt = `V_PACMAN_ON - 180;
									blinky_next_state = `S0;
								end
							else if((!right_blinky_limit) & (!up_blinky_limit))
								begin
									h_blinky_cnt = h_blinky_counter;
									v_blinky_cnt = v_blinky_counter + 1;
									blinky_next_state = `S2;
								end
							else if (!right_blinky_limit)
								begin
									if(!down_blinky_limit)
										begin
											h_blinky_cnt = h_blinky_counter;
											v_blinky_cnt = v_blinky_counter - 1;
											blinky_next_state = `S3;
										end
									else if (v_blinky_tile >= v_target_tile)
										begin
											h_blinky_cnt = h_blinky_counter;
											v_blinky_cnt = v_blinky_counter - 1;
											blinky_next_state = `S3;
										end
									else
										begin
											h_blinky_cnt = h_blinky_counter;
											v_blinky_cnt = v_blinky_counter + 1;
											blinky_next_state = `S2;
										end
								end
							else
								begin
									if (h_blinky_tile >= h_target_tile)
										begin
											if(v_blinky_tile <= v_target_tile)
												begin
													if(down_blinky_limit)
														begin
															h_blinky_cnt = h_blinky_counter;
															v_blinky_cnt = v_blinky_counter + 1;
															blinky_next_state = `S2;
														end
													else
														begin
															h_blinky_cnt = h_blinky_counter + 1;
															v_blinky_cnt = v_blinky_counter;
															blinky_next_state = `S0;
														end
												end
											else
												begin
													if(up_blinky_limit)
														begin
															h_blinky_cnt = h_blinky_counter;
															v_blinky_cnt = v_blinky_counter - 1;
															blinky_next_state = `S3;
														end
													else
														begin
															h_blinky_cnt = h_blinky_counter + 1;
															v_blinky_cnt = v_blinky_counter;
															blinky_next_state = `S0;
														end
												end
										end
									else
										begin
											h_blinky_cnt = h_blinky_counter + 1;
											v_blinky_cnt = v_blinky_counter;
											blinky_next_state = `S0;
										end
								end
						end
				`S1:
					begin
						if(h_blinky_counter == `H_BOARD_ON)
							begin
								h_blinky_cnt = `H_BOARD_OFF - 1;
								v_blinky_cnt = `V_PACMAN_ON - 180;
								blinky_next_state = `S1;
							end
						else if((!left_blinky_limit) & (!up_blinky_limit))
							begin
								h_blinky_cnt = h_blinky_counter;
								v_blinky_cnt = v_blinky_counter + 1;
								blinky_next_state = `S2;
							end
						else if (!left_blinky_limit)
							begin
								if(!down_blinky_limit)
									begin
										h_blinky_cnt = h_blinky_counter;
										v_blinky_cnt = v_blinky_counter - 1;
										blinky_next_state = `S3;
									end
								else if (v_blinky_tile >= v_target_tile)
									begin
										h_blinky_cnt = h_blinky_counter;
										v_blinky_cnt = v_blinky_counter - 1;
										blinky_next_state = `S3;
									end
								else
									begin
										h_blinky_cnt = h_blinky_counter;
										v_blinky_cnt = v_blinky_counter + 1;
										blinky_next_state = `S2;
									end
							end
						else
							begin
								if (h_blinky_tile <= h_target_tile)
									begin
										if(v_blinky_tile <= v_target_tile)
											begin
												if(down_blinky_limit)
													begin
														h_blinky_cnt = h_blinky_counter;
														v_blinky_cnt = v_blinky_counter + 1;
														blinky_next_state = `S2;
													end
												else
													begin
														h_blinky_cnt = h_blinky_counter - 1;
														v_blinky_cnt = v_blinky_counter;
														blinky_next_state = `S1;
													end
											end
										else
											begin
												if(up_blinky_limit)
													begin
														h_blinky_cnt = h_blinky_counter;
														v_blinky_cnt = v_blinky_counter - 1;
														blinky_next_state = `S3;
													end
												else
													begin
														h_blinky_cnt = h_blinky_counter - 1;
														v_blinky_cnt = v_blinky_counter;
														blinky_next_state = `S1;
													end
											end
									end
								else
									begin
										h_blinky_cnt = h_blinky_counter - 1;
										v_blinky_cnt = v_blinky_counter;
										blinky_next_state = `S1;
									end
							end
					end
				`S2:										
					begin
						if((!down_blinky_limit) & (!right_blinky_limit))
							begin
								h_blinky_cnt = h_blinky_counter - 1;
								v_blinky_cnt = v_blinky_counter;
								blinky_next_state = `S1;
							end
						else if(!down_blinky_limit)
							begin
								if(!left_blinky_limit)
									begin
										h_blinky_cnt = h_blinky_counter + 1;
										v_blinky_cnt = v_blinky_counter;
										blinky_next_state = `S0;
									end
								else if (h_blinky_tile >= h_target_tile)
									begin
										h_blinky_cnt = h_blinky_counter - 1;
										v_blinky_cnt = v_blinky_counter;
										blinky_next_state = `S1;
									end
								else
									begin
										h_blinky_cnt = h_blinky_counter + 1;
										v_blinky_cnt = v_blinky_counter;
										blinky_next_state = `S0;
									end
							end
						else
							begin
								if(v_blinky_tile >= v_target_tile) 
									begin
										if(h_blinky_tile <= h_target_tile)
											begin
												if(right_blinky_limit)
													begin
														h_blinky_cnt = h_blinky_counter + 1;
														v_blinky_cnt = v_blinky_counter;
														blinky_next_state = `S0;
													end
												else
													begin
														h_blinky_cnt = h_blinky_counter;
														v_blinky_cnt = v_blinky_counter + 1;
														blinky_next_state = `S2;
													end
											end
										else
											begin
												if(left_blinky_limit)
													begin
														h_blinky_cnt = h_blinky_counter - 1;
														v_blinky_cnt = v_blinky_counter;
														blinky_next_state = `S1;
													end
												else
													begin
														h_blinky_cnt = h_blinky_counter;
														v_blinky_cnt = v_blinky_counter + 1;
														blinky_next_state = `S2;
													end
											end
									end
								else
									begin
										h_blinky_cnt = h_blinky_counter;
										v_blinky_cnt = v_blinky_counter + 1;
										blinky_next_state = `S2;
									end
							end
					end
				`S3:
					begin
						if((!up_blinky_limit) & (!right_blinky_limit))
							begin
								h_blinky_cnt = h_blinky_counter - 1;
								v_blinky_cnt = v_blinky_counter;
								blinky_next_state = `S1;
							end
						else if(!up_blinky_limit)
							begin
								if(!left_blinky_limit)
									begin
										h_blinky_cnt = h_blinky_counter + 1;
										v_blinky_cnt = v_blinky_counter;
										blinky_next_state = `S0;
									end
								else if (h_blinky_tile >= h_target_tile)
									begin
										h_blinky_cnt = h_blinky_counter - 1;
										v_blinky_cnt = v_blinky_counter;
										blinky_next_state = `S1;
									end
								else
									begin
										h_blinky_cnt = h_blinky_counter + 1;
										v_blinky_cnt = v_blinky_counter;
										blinky_next_state = `S0;
									end
							end
						else
							begin
								if(v_blinky_tile <= v_target_tile) 
									begin
										if(h_blinky_tile <= h_target_tile)
											begin
												if(right_blinky_limit)
													begin
														h_blinky_cnt = h_blinky_counter + 1;
														v_blinky_cnt = v_blinky_counter;
														blinky_next_state = `S0;
													end
												else
													begin
														h_blinky_cnt = h_blinky_counter;
														v_blinky_cnt = v_blinky_counter - 1;
														blinky_next_state = `S3;
													end
											end
										else
											begin
												if(left_blinky_limit)
													begin
														h_blinky_cnt = h_blinky_counter - 1;
														v_blinky_cnt = v_blinky_counter;
														blinky_next_state = `S1;
													end
												else
													begin
														h_blinky_cnt = h_blinky_counter;
														v_blinky_cnt = v_blinky_counter - 1;
														blinky_next_state = `S3;
													end
											end
									end
								else
									begin
										h_blinky_cnt = h_blinky_counter;
										v_blinky_cnt = v_blinky_counter - 1;
										blinky_next_state = `S3;
									end
							end
					end
				endcase
			end
	//-----------------------------------------------
	//				BLINKY NEXT MOVEMENT ENABLE
	//-----------------------------------------------
	always @ ( * )
		begin
			// if Blinky goes right and he is in the middle of the tile then he can go only right or left
			if(blinky_state == `S0)
				begin
					up_blinky_state = 0;
					down_blinky_state = 0;
					left_blinky_state = 0;
					right_blinky_state = 1;
				end
			// if Blinky goes left and he is in the middle of the tile then he can go only right or left
			else if(blinky_state == `S1)
				begin
					up_blinky_state = 0;
					down_blinky_state = 0;
					left_blinky_state = 1;
					right_blinky_state = 0;
				end
			// if Blinky goes up and he is in the middle of the tile then he can go only up or down
			else if(blinky_state == `S2)
				begin
					up_blinky_state = 0;
					down_blinky_state = 1;
					left_blinky_state = 0;
					right_blinky_state = 0;
				end
			// if Blinky goes down and he is in the middle of the tile then he can go only up or down
			else if(blinky_state == `S3)
				begin
					up_blinky_state = 1;
					down_blinky_state = 0;
					left_blinky_state = 0;
					right_blinky_state = 0;
				end
			else
				begin
					up_blinky_state = 0;
					down_blinky_state = 0;
					left_blinky_state = 0;
					right_blinky_state = 0;
				end
		end
	//-----------------------------------------------
	//				READ BLINKY ROM
	//-----------------------------------------------
	always @ (posedge clk or posedge reset)	
		begin
			if (reset)
				begin
					h_blinky_addr <= `S6;
				end
			else if (blinky)
				h_blinky_addr <= h_blinky_addr + 1'b1;
			else if (!v_blinky)
				begin
					case(blinky_image)
						`S0: h_blinky_addr <= (scared_mode & (blinky_dead==0))?(image_sel?9217:8193):(image_sel?1025:1);
						`S1: h_blinky_addr <= (scared_mode & (blinky_dead==0))?(image_sel?9217:8193):(image_sel?3073:2049);
						`S2: h_blinky_addr <= (scared_mode & (blinky_dead==0))?(image_sel?9217:8193):(image_sel?7169:6145);
						`S3: h_blinky_addr <= (scared_mode & (blinky_dead==0))?(image_sel?9217:8193):(image_sel?5121:4097);
					endcase
				end
			else
				begin
					h_blinky_addr <= h_blinky_addr;
				end
		end	
	//-----------------------------------------------
	//				BLINKY NEXT MOVEMENT ENABLE
	//-----------------------------------------------
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
	//-----------------------------------------------
	//				BLINKY NEXT MOVEMENT ENABLE
	//-----------------------------------------------
	always @ ( * )
		begin
			/*if(blinky_tile)
				blinky_pixel = 8'h1c;
			else */if(blinky & (!end_of_game))
				begin
					case(blinky_pixel_sel)
						`S0: blinky_pixel = 8'b0;
						`S1: blinky_pixel = (blinky_dead == 1)?8'h0:((scared_mode & (blinky_dead==0))?((scared_mode_end & blink)?8'hff:8'h03):8'he0);
						`S2: blinky_pixel = ((scared_mode_end & blink & (blinky_dead==2'b0))?8'he0:8'hff);
						`S3: blinky_pixel = 8'h27;
					endcase
				end
			else
				blinky_pixel = 8'b0;
		end
	assign blinky_en = blinky;
endmodule 