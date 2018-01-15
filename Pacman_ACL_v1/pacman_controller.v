`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:30:20 08/07/2013 
// Design Name: 
// Module Name:    pacman_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//  ===================================================================================
//  								Define Module, Inputs and Outputs
//  ===================================================================================
`include "parameter.h"
module pacman_controller(
	 input clk,										// VGA CLK 75MHz
	 input reset, 									// System Reset
    input [15:0]   xAxis,						// x-axis data from PmodACL
    input [15:0]   yAxis,						// y-axis data from PmodACL
	 input pause,									// User's pause button
	 input stall, 									// System pause
	 input hz_enable, 							// 1Hz enable signal
	 input pacman_dead, 							// determines whether the Pac-Man is dead
	 input end_of_game,							// determines whether the game has ended
	 input up_pacman_limit,						// determines if pacman can go up
	 input down_pacman_limit,					// determines if pacman can go down
	 input left_pacman_limit,					// determines if pacman can go left
	 input right_pacman_limit,					// determines if pacman can do right
	 input [9:0] v_counter,						// Screen's vertical counter
	 input [10:0] h_counter,					// Screen's horizontal counter
	 output pacman_en,							// Pac-Man's enable signal
	 output [9:0] v_pacman_tile_counter,   // Pac-Man's center dot vertical coordinate 
	 output [10:0] h_pacman_tile_counter,  // Pac-Man's center dot horizontal coordinate
	 output reg waka,
	 output reg up_pacman_state, 				// if Pac-Man goes up and he is in the middle of the tile then he can go only up or down 
	 output reg down_pacman_state,			// if Pac-Man goes down and he is in the middle of the tile then he can go only up or down 
	 output reg left_pacman_state, 			// if Pac-Man goes left and he is in the middle of the tile then he can go only left or right 
	 output reg right_pacman_state,			// if Pac-Man goes right and he is in the middle of the tile then he can go only left or right
	 output reg [7:0] pacman_pixel			// 8-bit Pac-Man's RGB
	 );
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	reg up;
	reg down;
	reg left;
	reg right;
	reg image_sel;							//
	reg image_sel_1;						//
	reg [1:0] pacman_state;				//
	reg [1:0] pacman_image;				//
	reg [1:0] pacman_next_state;		//
	reg [7:0] movement_en;				//
	reg [13:0] h_addr;					//
	reg [10:0] h_pacman_counter;		//
	reg [9:0] v_pacman_counter;		//
	reg [10:0] h_pacman_cnt;			//
	reg [9:0] v_pacman_cnt;				//
	
	wire pixel;																			//
	wire h_pacman = (h_counter > (h_limit_on)) &								//
						 (h_counter < (h_limit_off));								//
	wire v_pacman = (v_counter > (v_limit_on)) &								//
						 (v_counter < (v_limit_off));								//
	wire pacman = h_pacman & v_pacman;											//
	wire [10:0] h_limit_on = h_pacman_counter;								//
	wire [10:0] h_limit_off = (h_pacman_counter + `H_PACMAN_SIZE);		//
	wire [9:0] v_limit_on = v_pacman_counter;									//
	wire [9:0] v_limit_off = (v_pacman_counter + `V_PACMAN_SIZE);		//
	
	wire pacman_tile = (h_counter == h_pacman_tile_counter) &			//
							 (v_counter == v_pacman_tile_counter);				//
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					up <= 1'b0;
					down <= 1'b0;
					left <= 1'b0;
					right <= 1'b0;
				end
			else
				begin
					if(xAxis[15:12] == 4'h0)
						begin
							if(xAxis[11:8] == 4'h1)
								begin
									up <= 1'b1;
									down <= 1'b0;
								end
							else if(xAxis[7:4] > 4'h4)
								begin
									up <= 1'b1;
									down <= 1'b0;
								end
							else
								begin
									up <= 1'b0;
									down <= 1'b0;
								end
						end
					else
						begin
							if(xAxis[11:8] == 4'h1)
								begin
									down <= 1'b1;
									up <= 1'b0;
								end
							else if(xAxis[7:4] > 4'h4)
								begin
									down <= 1'b1;
									up <= 1'b0;
								end
							else
								begin
									down <= 1'b0;
									up <= 1'b0;
								end
						end
					if(yAxis[15:12] == 4'hf)
						begin
							if(yAxis[11:8] == 4'h1)
								begin
									right <= 1'b1;
									left <= 1'b0;
								end
							else if(yAxis[7:4] > 4'h4)
								begin
									right <= 1'b1;
									left <= 1'b0;
								end
							else
								begin
									right <= 1'b0;
									left <= 1'b0;
								end
						end
					else
						begin
							if(yAxis[11:8] == 4'h1)
								begin
									left <= 1'b1;
									right <= 1'b0;
								end
							else if(yAxis[7:4] > 4'h4)
								begin
									left <= 1'b1;
									right <= 1'b0;
								end
							else
								begin
									left <= 1'b0;
									right <= 1'b0;
								end
						end
				end
		end
	
	assign h_pacman_tile_counter = (h_pacman_counter + 5'b10001);		//
	assign v_pacman_tile_counter = (v_pacman_counter + 5'b10001);		//
	assign pause_en = (pause | stall);											//
// ====================================================================================
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
					movement_en <= 0;
					pacman_image <= 0;
					pacman_state <= 0;
					h_pacman_counter <= `H_PACMAN_ON;
					v_pacman_counter <= `V_PACMAN_ON;
				end
			else if(pacman_dead || end_of_game)
				begin
					image_sel <= 1;
					movement_en <= 0;
					pacman_image <= 0;
					pacman_state <= 0;
					h_pacman_counter <= `H_PACMAN_ON;
					v_pacman_counter <= `V_PACMAN_ON;
				end
			else if (hz_enable & (!pause_en))
				begin
					if(!pacman_dead)
						begin
							if (movement_en == 8'b1010)
								begin
									image_sel <= image_sel_1;
									movement_en <= 0;
								end
							else
								begin
									image_sel <= image_sel;
									movement_en <= movement_en + 1;
								end
							h_pacman_counter <= (h_pacman_cnt);
							v_pacman_counter <= (v_pacman_cnt);
							pacman_state <= pacman_next_state;
							pacman_image <= pacman_next_state;
						end
					else
						begin
						/*	if (movement_en == 8'hff)
								begin
									image_sel <= 1'b0;
									movement_en <= 0;
								end
							else
								begin
									image_sel <= 1'b1;
									movement_en <= movement_en + 1;
								end*/
						//	h_pacman_counter <= (h_pacman_cnt);
						//	v_pacman_counter <= (v_pacman_cnt);
							h_pacman_counter <= `H_PACMAN_ON;
							v_pacman_counter <= `V_PACMAN_ON;
							
							pacman_state <= pacman_state;
							pacman_image <= pacman_state;
						end
				end
			else
				begin
					image_sel <= image_sel;
					movement_en <= movement_en;
					h_pacman_counter <= (h_pacman_counter);
					v_pacman_counter <= (v_pacman_counter);
					pacman_state <= pacman_state;
				end
		end
// PAC-MAN MOVEMENT : Finite State Machine (FSM)
	always @ ( * )
		begin
			waka = 1'b1;
			case(pacman_state)
				`S0:
					begin
						image_sel_1 = ~image_sel;
						if(up)
							begin
								if(!up_pacman_limit)
									begin
										if(h_pacman_counter == (`H_BOARD_OFF-`H_PACMAN_SIZE))
											begin
												h_pacman_cnt = `H_BOARD_ON + 1;
												v_pacman_cnt = `V_PACMAN_ON - 180;
												pacman_next_state = `S0;
												end
										else if(!right_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S0;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter + 1;
												v_pacman_cnt = v_pacman_counter;
												pacman_next_state = `S0;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter - 1;
										pacman_next_state = `S3;
									end
										
							end
						else if (down)
							begin
								if(!down_pacman_limit)
									begin
										if(h_pacman_counter  == (`H_BOARD_OFF - `H_PACMAN_SIZE))
											begin
												h_pacman_cnt = `H_BOARD_ON + 1;
												v_pacman_cnt = `V_PACMAN_ON - 180;
												pacman_next_state = `S0;
											end
										else if(!right_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S0;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter + 1;
												v_pacman_cnt = v_pacman_counter;
												pacman_next_state = `S0;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter + 1;
										pacman_next_state = `S2;
									end
							end
						else if (left)
							begin
								if(h_pacman_counter == `H_BOARD_ON)
									begin
										h_pacman_cnt = `H_BOARD_OFF - 1 - `H_PACMAN_SIZE;
										v_pacman_cnt = `V_PACMAN_ON - 180;
										pacman_next_state = `S1;
									end
								else if(!left_pacman_limit)
									begin
										if(h_pacman_counter  == (`H_BOARD_OFF - `H_PACMAN_SIZE))
											begin
												h_pacman_cnt = `H_BOARD_ON + 1;
												v_pacman_cnt = `V_PACMAN_ON - 180;
												pacman_next_state = `S0;
											end
										else if(!right_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S0;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter + 1;
												v_pacman_cnt = v_pacman_counter;
												pacman_next_state = `S0;
											end										
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter - 1;
										v_pacman_cnt = v_pacman_counter;
										pacman_next_state = `S1;
									end			
							end
						else
							begin									
								if(h_pacman_counter == (`H_BOARD_OFF-`H_PACMAN_SIZE))
									begin
										h_pacman_cnt = `H_BOARD_ON + 1;
										v_pacman_cnt = `V_PACMAN_ON - 180;
										pacman_next_state = `S0;
									end
								else if(!right_pacman_limit)
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter;
										waka = 1'b0;
										pacman_next_state = `S0;
										image_sel_1 = 1;
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter + 1;
										v_pacman_cnt = v_pacman_counter;
										pacman_next_state = `S0;
									end
							end
					end
				`S1:
					begin
						image_sel_1 = ~image_sel;
						if(up)
							begin
								if(!up_pacman_limit)
									begin
										if(h_pacman_counter == `H_BOARD_ON)
											begin
												h_pacman_cnt = `H_BOARD_OFF - 1 - `H_PACMAN_SIZE;
												v_pacman_cnt = `V_PACMAN_ON - 180;
												pacman_next_state = `S1;
											end
										else if(!left_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S1;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter - 1;
												v_pacman_cnt = v_pacman_counter;
												pacman_next_state = `S1;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter - 1;
										pacman_next_state = `S3;
									end
							end
						else if (down)
							begin
								if(!down_pacman_limit)
									begin
										if(h_pacman_counter == `H_BOARD_ON)
											begin
												h_pacman_cnt = `H_BOARD_OFF - 1 - `H_PACMAN_SIZE;
												v_pacman_cnt = `V_PACMAN_ON - 180;
												pacman_next_state = `S1;
											end
										else if(!left_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S1;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter - 1;
												v_pacman_cnt = v_pacman_counter;
												pacman_next_state = `S1;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter + 1;
										pacman_next_state = `S2;
									end
							end
						else if (right)
							begin									
								if(h_pacman_counter == (`H_BOARD_OFF-`H_PACMAN_SIZE))
									begin
										h_pacman_cnt = `H_BOARD_ON + 1;
										v_pacman_cnt = `V_PACMAN_ON - 180;
										pacman_next_state = `S0;
									end
								else if(!right_pacman_limit)
									begin
										if(h_pacman_counter == `H_BOARD_ON)
											begin
												h_pacman_cnt = `H_BOARD_OFF - 1 - `H_PACMAN_SIZE;
												v_pacman_cnt = `V_PACMAN_ON - 180;
												pacman_next_state = `S1;
											end
										else if(!left_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S1;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter - 1;
												v_pacman_cnt = v_pacman_counter;
												pacman_next_state = `S1;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter + 1;
										v_pacman_cnt = v_pacman_counter;
										pacman_next_state = `S0;
									end
							end
						else
							begin
								if(h_pacman_counter == `H_BOARD_ON)
									begin
										h_pacman_cnt = `H_BOARD_OFF - 1 - `H_PACMAN_SIZE;
										v_pacman_cnt = `V_PACMAN_ON - 180;
										pacman_next_state = `S1;
									end
								else if(!left_pacman_limit)
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter;
										waka = 1'b0;
										pacman_next_state = `S1;
										image_sel_1 = 1;
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter - 1;
										v_pacman_cnt = v_pacman_counter;
										pacman_next_state = `S1;
									end
							end
					end
				`S2:
					begin
						image_sel_1 = ~image_sel;
						if(up)
							begin
								if(!up_pacman_limit)
									begin
										if(!down_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S2;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter + 1;
												pacman_next_state = `S2;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter - 1;
										pacman_next_state = `S3;
									end
							end
						else if (right)
							begin									
								if(h_pacman_counter == (`H_BOARD_OFF-`H_PACMAN_SIZE))
									begin
										h_pacman_cnt = `H_BOARD_ON + 1;
										v_pacman_cnt = `V_PACMAN_ON - 180;
										pacman_next_state = `S0;
									end
								else if(!right_pacman_limit)
									begin
										if(!down_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S2;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter + 1;
												pacman_next_state = `S2;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter + 1;
										v_pacman_cnt = v_pacman_counter;
										pacman_next_state = `S0;
									end
							end
						else if (left)
							begin
								if(h_pacman_counter == `H_BOARD_ON)
									begin
										h_pacman_cnt = `H_BOARD_OFF - 1 - `H_PACMAN_SIZE;
										v_pacman_cnt = `V_PACMAN_ON - 180;
										pacman_next_state = `S1;
									end
								else if(!left_pacman_limit)
									begin
										if(!down_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S2;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter + 1;
												pacman_next_state = `S2;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter - 1;
										v_pacman_cnt = v_pacman_counter;
										pacman_next_state = `S1;
									end
							end
						else
							begin
								if(!down_pacman_limit)
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter;
										waka = 1'b0;
										pacman_next_state = `S2;
										image_sel_1 = 1;
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter + 1;
										pacman_next_state = `S2;
									end
							end
					end
				`S3:
					begin
						image_sel_1 = ~image_sel;
						if (right)
							begin									
								if(h_pacman_counter == (`H_BOARD_OFF-`H_PACMAN_SIZE))
									begin
										h_pacman_cnt = `H_BOARD_ON + 1;
										v_pacman_cnt = `V_PACMAN_ON - 180;
										pacman_next_state = `S0;
									end
								else if(!right_pacman_limit)
									begin
										if(!up_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S3;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter - 1;
												pacman_next_state = `S3;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter + 1;
										v_pacman_cnt = v_pacman_counter;
										pacman_next_state = `S0;
									end
							end
						else if (left)
							begin
								if(h_pacman_counter == `H_BOARD_ON)
									begin
										h_pacman_cnt = `H_BOARD_OFF - 1 - `H_PACMAN_SIZE;
										v_pacman_cnt = `V_PACMAN_ON - 180;
										pacman_next_state = `S1;
									end
								else if(!left_pacman_limit)
									begin
										if(!up_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S3;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter - 1;
												pacman_next_state = `S3;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter - 1;
										v_pacman_cnt = v_pacman_counter;
										pacman_next_state = `S1;
									end
							end
						else if (down)
							begin
								if(!down_pacman_limit)
									begin
										if(!up_pacman_limit)
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter;
												waka = 1'b0;
												pacman_next_state = `S3;
												image_sel_1 = 1;
											end
										else 
											begin
												h_pacman_cnt = h_pacman_counter;
												v_pacman_cnt = v_pacman_counter - 1;
												pacman_next_state = `S3;
											end
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter + 1;
										pacman_next_state = `S2;
									end
							end
						else
							begin
								if(!up_pacman_limit)
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter;
										waka = 1'b0;
										pacman_next_state = `S3;
										image_sel_1 = 1;
									end
								else 
									begin
										h_pacman_cnt = h_pacman_counter;
										v_pacman_cnt = v_pacman_counter - 1;
										pacman_next_state = `S3;
									end
							end
					end
			endcase
		end
//	ALWAYS SATEMENT PAC-MAN STATES ON
	always @ ( * )
		begin
			if(pacman_state == `S0)
				begin
					up_pacman_state = 0;
					down_pacman_state = 0;
					left_pacman_state = 0;
					right_pacman_state = 1;
				end
			else if(pacman_state == `S1)
				begin
					up_pacman_state = 0;
					down_pacman_state = 0;
					left_pacman_state = 1;
					right_pacman_state = 0;
				end
			else if(pacman_state == `S2)
				begin
					up_pacman_state = 0;
					down_pacman_state = 1;
					left_pacman_state = 0;
					right_pacman_state = 0;
				end
			else if(pacman_state == `S3)
				begin
					up_pacman_state = 1;
					down_pacman_state = 0;
					left_pacman_state = 0;
					right_pacman_state = 0;
				end
			else
				begin
					up_pacman_state = 0;
					down_pacman_state = 0;
					left_pacman_state = 0;
					right_pacman_state = 0;
				end
		end

	always @ (posedge clk or posedge reset)	
		begin
			if (reset)
				begin
					h_addr <= 2049;
				end
			else if (pacman)
				begin
					if(stall)
						h_addr <= h_addr + 1;
					else if(!pacman_dead)
						begin
							case(pacman_image)
								`S0: h_addr <= h_addr + 1;
								`S1: h_addr <= h_addr - 1;
								`S2: h_addr <= h_addr + 32;
								`S3: h_addr <= h_addr + 32;
							endcase
						end 
					else
						h_addr <= h_addr + 1;
				end
			else if ((h_counter == (h_limit_off))&(v_pacman))
				begin
					if(stall)
						h_addr <= h_addr;
					else if(!pacman_dead)
						begin
							case(pacman_image)
								`S0: h_addr <= h_addr;
								`S1: h_addr <= h_addr;
								`S2: h_addr <= h_addr - 1023;
								`S3: h_addr <= h_addr - 1025;
							endcase
						end
					else
						h_addr <= h_addr;
				end
			else if (!v_pacman)
				begin
					if(!pacman_dead)
						begin
							case(pacman_image)
								`S0: h_addr <= image_sel?1025:1;
								`S1: h_addr <= image_sel?2047:1023;
								`S2: h_addr <= image_sel?1024:0;
								`S3: h_addr <= image_sel?1055:31;
							endcase
						end
					else if(stall & (!pacman_dead))
						h_addr <= 2049;
				/*	else if(pacman_dead)
						begin
							case(image_sel)
								`S0: h_addr <= h_addr - 1;
								`S1: h_addr <= h_addr - 1025;
							endcase
						end*/
						else if (pacman_dead)
							begin
								h_addr <= 2049;
							end
					else
						h_addr <= h_addr;
				end
			else
				begin
					h_addr <= h_addr;
				end
		end
// PAC-MAN PIXEL COLOUR
	always @ ( * )
		begin
			/*if(pacman_tile)
				pacman_pixel = 8'h1c;
			else */if(pacman & (!end_of_game))
				begin
					if(pixel == 0)
						pacman_pixel = 8'b0;
					else
						pacman_pixel = 8'hfc;
				end
			else
				pacman_pixel = 8'b0;
		end
	assign pacman_en = pacman;
	pacmanRom Rom(clk,h_addr,pixel);
endmodule
