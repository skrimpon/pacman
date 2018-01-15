`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:53:29 10/03/2013 
// Design Name: 
// Module Name:    live_controller 
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
module live_controller(
	 input clk,
	 input reset,
	 input [10:0]h_counter,
	 input [9:0] v_counter,
	 input [4:0] h_pacman_tile,
	 input [4:0] v_pacman_tile,
	 input [4:0] h_blinky_tile,
	 input [4:0] v_blinky_tile,
	 input [4:0] h_pinky_tile, 
	 input [4:0] v_pinky_tile,
	 input [4:0] h_inky_tile, 
	 input [4:0] v_inky_tile, 
	 input [4:0] h_clyde_tile,
	 input [4:0] v_clyde_tile, 
	 input scared_mode, 
	 input one_hz_enable,
	 input [3:0] scared_mode_timer,
	 output reg [7:0] live_pixel,
	 output live_en,
	 output reg pacman_dead,
	 output reg [1:0] blinky_dead, 
	 output reg [1:0] pinky_dead,
	 output reg [1:0] inky_dead, 
	 output reg [1:0] clyde_dead,
	 output 	reg new_game
	 );
	reg pacman_die;
	reg pacman_dead_1;
	reg pacman_dead_en;
	reg [1:0] blinky_dead_1;
	reg [1:0] pinky_dead_1;
	reg [1:0] inky_dead_1;
	reg [1:0] clyde_dead_1;
	reg [2:0] timer;
	reg [3:0] num_of_lifes;
	reg [3:0] num_of_lifes_1;
	reg [7:0] h_zero_addr;	
	reg [7:0] h_one_addr;	
	reg [7:0] h_two_addr;	
	reg [7:0] h_three_addr;	
	
	wire zero_pixel;
	wire one_pixel;
	wire two_pixel;
	wire three_pixel;
	
	wire zero_live = (h_counter > `H_LIVE_ZERO_ON) & (h_counter < `H_LIVE_ZERO_OFF);
	wire one_live = (h_counter > `H_LIVE_ONE_ON) & (h_counter < `H_LIVE_ONE_OFF);
	wire two_live = (h_counter > `H_LIVE_TWO_ON) & (h_counter < `H_LIVE_TWO_OFF);
	wire three_live = (h_counter > `H_LIVE_THREE_ON) & (h_counter < `H_LIVE_THREE_OFF);
	
	wire v_live = (v_counter > `V_LIVE_ON) & (v_counter < `V_LIVE_OFF);
	assign live_en = ((zero_live | one_live | two_live | three_live) & v_live);

	always @ ( posedge clk or posedge reset)
		begin
			if(reset)
				begin
					pacman_die <= 1;
					pacman_dead <= 0;
					blinky_dead <= 0;
					pinky_dead <= 0;
					inky_dead <= 0;
					clyde_dead <= 0;
					num_of_lifes <= 4'hf;
				end
			else if((scared_mode_timer==0) & scared_mode)
				begin
					num_of_lifes <= num_of_lifes_1;
					pacman_dead <= pacman_dead_1;
					blinky_dead <= 2'b0;
					inky_dead <= 2'b0;
					pinky_dead <= 2'b0;
					clyde_dead <= 2'b0;
					pacman_die <= 1;
				end
			else if((num_of_lifes != num_of_lifes_1) && pacman_die)
				begin
					num_of_lifes <= num_of_lifes_1;
					pacman_dead <= pacman_dead_1;
					blinky_dead <= blinky_dead_1;
					pinky_dead <= pinky_dead_1;
					inky_dead <= inky_dead_1;
					clyde_dead <= clyde_dead_1;
					pacman_die <= 0;
				end
			else if((num_of_lifes != num_of_lifes_1) && ~pacman_die)
				begin
					num_of_lifes <= num_of_lifes;
					pacman_dead <= pacman_dead_1;
					blinky_dead <= blinky_dead_1;
					pinky_dead <= pinky_dead_1;
					inky_dead <= inky_dead_1;
					clyde_dead <= clyde_dead_1;
					pacman_die <= 0;
				end
			else
				begin
					num_of_lifes <= num_of_lifes_1;
					pacman_dead <= pacman_dead_1;
					blinky_dead <= blinky_dead_1;
					pinky_dead <= pinky_dead_1;
					inky_dead <= inky_dead_1;
					clyde_dead <= clyde_dead_1;
					pacman_die <= 1;
				end
		end
	always @ ( * )
		begin
			num_of_lifes_1 = num_of_lifes;
			pacman_dead_1 = pacman_dead;
			blinky_dead_1 = blinky_dead;
			pinky_dead_1 = pinky_dead;
			inky_dead_1 = inky_dead;
			clyde_dead_1 = clyde_dead;
			if(((((h_pacman_tile == h_blinky_tile) & (v_pacman_tile == v_blinky_tile)) |
			((h_pacman_tile == h_pinky_tile) & (v_pacman_tile == v_pinky_tile)) |
			((h_pacman_tile == h_inky_tile) & (v_pacman_tile == v_inky_tile)) |
			((h_pacman_tile == h_clyde_tile) & (v_pacman_tile == v_clyde_tile))) & (!scared_mode))|
			(((h_pacman_tile == h_blinky_tile) & (v_pacman_tile == v_blinky_tile)) & scared_mode & (blinky_dead == 2))|
			(((h_pacman_tile == h_pinky_tile) & (v_pacman_tile == v_pinky_tile)) & scared_mode & (pinky_dead == 2)) |
			(((h_pacman_tile == h_inky_tile) & (v_pacman_tile == v_inky_tile)) & scared_mode & (inky_dead == 2)) |
			(((h_pacman_tile == h_clyde_tile) & (v_pacman_tile == v_clyde_tile)) & scared_mode & (clyde_dead == 2)))
				begin
					num_of_lifes_1 = (num_of_lifes >> 1);
					pacman_dead_1 = 1'b1;
					blinky_dead_1 = 2'b1;
					pinky_dead_1 = 2'b1;
					inky_dead_1 = 2'b1;
					clyde_dead_1 = 2'b1;
				end
			if((h_pacman_tile == h_blinky_tile) & (v_pacman_tile == v_blinky_tile) & scared_mode & (blinky_dead == 0))
				begin
					pacman_dead_1 = pacman_dead;
					blinky_dead_1 = 2'b1;
					pinky_dead_1 = pinky_dead;
					inky_dead_1 = inky_dead;
					clyde_dead_1 = clyde_dead;
				end
			if((h_pacman_tile == h_pinky_tile) & (v_pacman_tile == v_pinky_tile) & scared_mode & (pinky_dead == 0))
				begin
					pacman_dead_1 = pacman_dead;
					blinky_dead_1 = blinky_dead;
					pinky_dead_1 = 2'b1;
					inky_dead_1 = inky_dead;
					clyde_dead_1 = clyde_dead;
				end
			if((h_pacman_tile == h_inky_tile) & (v_pacman_tile == v_inky_tile) & scared_mode & (inky_dead == 0))
				begin
					pacman_dead_1 = pacman_dead;
					blinky_dead_1 = blinky_dead;
					pinky_dead_1 = pinky_dead;
					inky_dead_1 = 2'b1;
					clyde_dead_1 = clyde_dead;
				end
			if((h_pacman_tile == h_clyde_tile) & (v_pacman_tile == v_clyde_tile) & scared_mode & (clyde_dead == 0))
				begin
					pacman_dead_1 = pacman_dead;
					blinky_dead_1 = blinky_dead;
					pinky_dead_1 = pinky_dead;
					inky_dead_1 = inky_dead;
					clyde_dead_1 = 2'b1;
				end
			if (new_game & pacman_dead_en)
				begin
					pacman_dead_1 = 2'b0;
					blinky_dead_1 = 2'b0;
					pinky_dead_1 = 2'b0;
					inky_dead_1 = 2'b0;
					clyde_dead_1 = 2'b0;
				end
			if((h_blinky_tile == 14) & (v_blinky_tile == 12) & blinky_dead)
				blinky_dead_1 = 2'b10;
			if((h_pinky_tile == 14) & (v_pinky_tile == 12) & pinky_dead)
				pinky_dead_1 = 2'b10;
			if((h_inky_tile == 14) & (v_inky_tile == 12) & inky_dead)
				inky_dead_1 = 2'b10;
			if((h_clyde_tile == 14) & (v_clyde_tile == 12) & clyde_dead)
				clyde_dead_1 = 2'b10;
		end
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					timer <= 0;
					pacman_dead_en <= 0;
				end
			else if (timer == 3'h1)
				begin
					timer <= 0;
					pacman_dead_en <= 1;
				end
			else if (one_hz_enable & pacman_dead_1)
				begin
					timer <= timer + 1;
					pacman_dead_en <= 0;
				end
			else
				begin
					timer <= timer;
					pacman_dead_en <= 0;
				end		
		end
		
	always @ ( * )
		begin
			if(num_of_lifes>0)
				new_game = 1;
			else
				new_game = 0;
		end

// ALWAYS STATEMENT - PAC-MAN LIVe ROM
	always @ (posedge clk or posedge reset)	
		begin
			if (reset)
				begin
					h_zero_addr <= 1;
					h_one_addr <= 1;
					h_two_addr <= 1;
					h_three_addr <= 1;					
				end
			else if (zero_live)
				h_zero_addr <= h_zero_addr + 1'b1;
			else if (one_live)
				h_one_addr <= h_one_addr + 1'b1;
			else if (two_live)
				h_two_addr <= h_two_addr + 1'b1;
			else if (three_live)
				h_three_addr <= h_three_addr + 1'b1;
			else if (!v_live)
				begin
					h_zero_addr <= 1;
					h_one_addr <= 1;
					h_two_addr <= 1;
					h_three_addr <= 1;					
				end
			else
				begin
					h_zero_addr <= h_zero_addr;
					h_one_addr <= h_one_addr;
					h_two_addr <= h_two_addr;
					h_three_addr <= h_three_addr;					
				end
		end
// PAC-MAN LIVE PIXEL COLOUR
	always @ ( * )
		begin
			if(live_en)
				begin
					if(zero_live & num_of_lifes[3])
						begin
							if(!zero_pixel)
								live_pixel = 8'b0;
							else
								live_pixel = 8'hfc;
						end
					else if(one_live & num_of_lifes[2])
						begin
							if(!one_pixel)
								live_pixel = 8'b0;
							else
								live_pixel = 8'hfc;
						end
					else if(two_live & num_of_lifes[1])
						begin
							if(!two_pixel)
								live_pixel = 8'b0;
							else
								live_pixel = 8'hfc;
						end
					else if(three_live & num_of_lifes[0])
						begin
							if(!three_pixel)
								live_pixel = 8'b0;
							else
								live_pixel = 8'hfc;
						end
					else
						live_pixel = 8'b0;
				end
			else
				live_pixel = 8'b0;
		end
	live_rom Rom1(clk,h_zero_addr,zero_pixel,
						clk,h_one_addr,one_pixel);
	live_rom Rom2(clk,h_two_addr,two_pixel,
						clk,h_three_addr,three_pixel);
endmodule
