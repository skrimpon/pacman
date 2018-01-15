`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Panagiotis Skrimponis
// 
// Create Date:    20:07:45 07/16/2013 
// Design Name: Pac-Man
// Module Name:    vga_controler 
// Project Name: DESIGN OF AN INTERACTIVE GAME IN A RECONFIGURABLE PLATFORM
// Target Devices: Spartan 6 Nexys 3
// Tool versions: 
// Description: This module controls the colour of the pixel, the horizontal synch pulse,
//	the vertical synch pulse.
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
module vga_controller(
	 input clk,							// VGA CLK 75MHz
	 input reset, 						// System Reset
	 input board_en, 					// Board enable signal
	 input dot_en,						// Pill and Super Pill enable signal
	 input score_en,					// Score enable signal
	 input pacman_en,					//	Pacman enable signal
	 input blinky_en, 				//	Blinky enable signal
	 input pinky_en, 					//	Pinky enable signal				
	 input inky_en, 					//	Inky enable signal
	 input clyde_en, 					//	Clyde enable signal
	 input live_en, 					//	Pacman's lifes enable signal
	 input bonus_en, 					//	Bonus enable signal
	 input [1:0] blinky_dead,
	 input [1:0] pinky_dead,
	 input [1:0] inky_dead,
	 input [1:0] clyde_dead,
	 input [7:0] board_pixel,		// Board 8-bit colour
	 input [7:0] score_pixel,		// Score 8-bit colour
	 input [7:0] pacman_pixel,		// Pacman 8-bit colour
	 input [7:0] blinky_pixel,		// Blinky 8-bit colour
	 input [7:0] pinky_pixel,		// Pinky 8-bit colour
	 input [7:0] inky_pixel,		// Inky 8-bit colour
	 input [7:0] clyde_pixel,		// Clyde 8-bit colour
	 input [7:0] live_pixel,		// Pac-Man's lifes pixel
	 input [7:0] bonus_pixel,		// Bonus 8-bit colour
	 output [7:0] RGB,				// Output 8-bit colour
	 output Hsync,						// Horizontal Sync
	 output Vsync,						// Vertical Sync
	 output reg [9:0] v_counter,	// Screen vertical Counter
	 output reg [10:0] h_counter	// Screen horizontal Counter
	 );
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	reg [2:0] vgaRed;																							// 3-bit register for the red colour
	reg [2:0] vgaGreen;			 																			// 3-bit register for the green colour
	reg [1:0] vgaBlue;																						// 2-bit register for the blue colour
																					
	wire h_fp_blank = (h_counter > `H_FP_BLANK_ON) & (h_counter <=`H_FP_BLANK_OFF);		// it determines if we are in the horizontal front porch
	wire v_fp_blank = (v_counter > `V_FP_BLANK_ON) & (v_counter <=`V_FP_BLANK_OFF);		// it determines if we are in the vertical front porch
	wire h_sync = (h_counter > `H_SYNC_ON) & (h_counter <=`H_SYNC_OFF);						// it determines if we have to activate the horizontal synch pulse
	wire v_sync = (v_counter > `V_SYNC_ON) & (v_counter <=`V_SYNC_OFF);						// it determines if we have to activate the vertical synch pulse
	wire h_bp_blank = (h_counter > `H_BP_BLANK_ON) & (h_counter <=`H_BP_BLANK_OFF);		// it determines if we are in the horizontal back porch
	wire v_bp_blank = (v_counter > `V_BP_BLANK_ON) & (v_counter <=`V_BP_BLANK_OFF);		// it determines if we are in the vertical back porch
	wire h_blank = h_fp_blank | h_sync | h_bp_blank;												// it determines if we are in the horizontal blank pixel region
	wire v_blank = v_fp_blank | v_sync | v_bp_blank;												// it determines if we are in the vertical blank pixel region
	wire blank = v_blank | h_blank;																		// it determines if we are in the blank pixel region
	
	assign RGB = {vgaBlue,vgaGreen,vgaRed};															// assignment for the output RGB colours
	assign Hsync = h_sync;																					// assignment for the horizontal synch pulse
	assign Vsync = v_sync; 																					// assignment for the vertical synch pulse
// ====================================================================================
// 										 Implementation
// ====================================================================================
 	//-----------------------------------------------
	//			   VGA counters: help as to
	// 		 determine which pixel to paint.
	//-----------------------------------------------
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					h_counter <= 0;
					v_counter <= 0;
				end
			else if (h_counter < `H_BP_BLANK_OFF)
				h_counter <= h_counter + 1;
			else
				begin
					h_counter <= 0;
					if (v_counter < `V_BP_BLANK_OFF)
						v_counter <= v_counter + 1;
					else
						begin
							v_counter <= 0;
						end
				end
		end
	//-----------------------------------------------
	//					 Output RGB
	// 		Select data to display on screen
	//-----------------------------------------------
	always @ ( * )
		begin
			// Select black to display (blank region)
			if(blank)
				begin
					vgaRed = 3'b0;
					vgaGreen = 3'b0;
					vgaBlue = 2'b0;
				end
			// Select game score to display
			else if(score_en)
				begin
					vgaRed = score_pixel[7:5];
					vgaGreen = score_pixel[4:2];
					vgaBlue = score_pixel[1:0];
				end
			// Select Pac-Man lifes to display
			else if(live_en)
				begin
					vgaRed = live_pixel[7:5];
					vgaGreen = live_pixel[4:2];
					vgaBlue = live_pixel[1:0];
				end
			// Select blinky to display
			else if(blinky_en)
				begin
					if((blinky_dead == 1)&(pacman_en))
						begin
							// Make dots to be appear until they reach the Pac-Man's mouth
							if(dot_en)
								begin
									vgaRed = board_pixel[7:5];
									vgaGreen = board_pixel[4:2];
									vgaBlue = board_pixel[1:0];
								end
							else
								begin
									vgaRed = pacman_pixel[7:5];
									vgaGreen = pacman_pixel[4:2];
									vgaBlue = pacman_pixel[1:0];
								end
						end
					else
						begin
							vgaRed = blinky_pixel[7:5];
							vgaGreen = blinky_pixel[4:2];
							vgaBlue = blinky_pixel[1:0];
						end
				end
			// Select pinky to display
			else if(pinky_en)
				begin
					if((pinky_dead == 1)&(pacman_en))
						begin
							// Make dots to be appear until they reach the Pac-Man's mouth
							if(dot_en)
								begin
									vgaRed = board_pixel[7:5];
									vgaGreen = board_pixel[4:2];
									vgaBlue = board_pixel[1:0];
								end
							else
								begin
									vgaRed = pacman_pixel[7:5];
									vgaGreen = pacman_pixel[4:2];
									vgaBlue = pacman_pixel[1:0];
								end
						end
					else
						begin
							vgaRed = pinky_pixel[7:5];
							vgaGreen = pinky_pixel[4:2];
							vgaBlue = pinky_pixel[1:0];
						end
				end
			// Select inky to display		
			else if(inky_en)
				begin
					if((inky_dead == 1)&(pacman_en))
						begin
							// Make dots to be appear until they reach the Pac-Man's mouth
							if(dot_en)
								begin
									vgaRed = board_pixel[7:5];
									vgaGreen = board_pixel[4:2];
									vgaBlue = board_pixel[1:0];
								end
							else
								begin
									vgaRed = pacman_pixel[7:5];
									vgaGreen = pacman_pixel[4:2];
									vgaBlue = pacman_pixel[1:0];
								end
						end
					else
						begin
							vgaRed = inky_pixel[7:5];
							vgaGreen = inky_pixel[4:2];
							vgaBlue = inky_pixel[1:0];
						end
				end
			// Select clyde to display
			else if(clyde_en)
				begin
					if((clyde_dead == 1)&(pacman_en))
						begin
							// Make dots to be appear until they reach the Pac-Man's mouth
							if(dot_en)
								begin
									vgaRed = board_pixel[7:5];
									vgaGreen = board_pixel[4:2];
									vgaBlue = board_pixel[1:0];
								end
							else
								begin
									vgaRed = pacman_pixel[7:5];
									vgaGreen = pacman_pixel[4:2];
									vgaBlue = pacman_pixel[1:0];
								end
						end
					else
						begin
							vgaRed = clyde_pixel[7:5];
							vgaGreen = clyde_pixel[4:2];
							vgaBlue = clyde_pixel[1:0];
						end
				end
			// Select pacman to display
			else if(pacman_en)
				begin
					// Make dots to be appear until they reach the Pac-Man's mouth
					if(dot_en)
						begin
							vgaRed = board_pixel[7:5];
							vgaGreen = board_pixel[4:2];
							vgaBlue = board_pixel[1:0];
						end
					else
						begin
							vgaRed = pacman_pixel[7:5];
							vgaGreen = pacman_pixel[4:2];
							vgaBlue = pacman_pixel[1:0];
						end
				end
			// Select bonus items to display
			else if(bonus_en)
				begin
					vgaRed = bonus_pixel[7:5];
					vgaGreen = bonus_pixel[4:2];
					vgaBlue = bonus_pixel[1:0];
				end
			// Select board to display
			else if(board_en)
				begin
					vgaRed = board_pixel[7:5];
					vgaGreen = board_pixel[4:2];
					vgaBlue = board_pixel[1:0];
				end
			// Select black to display
			else
				begin
					vgaRed = 3'b0;
					vgaGreen = 3'b0;
					vgaBlue = 2'b0;
				end
		end
endmodule

