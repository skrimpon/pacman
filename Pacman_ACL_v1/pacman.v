`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:52:37 07/16/2013 
// Design Name: 
// Module Name:    pacman 
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
module pacman(
	 input clk,					//	100 MHz CLK
	 input reset,				//	System Reset
	 input pause,				//	User's Pause
	 input SDI,					//	Serial Data In
	 input grid,
/*    output an3,
    output an2,
    output an1,
    output an0,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
	 output g,
    output dp,*/
	 output SS, 				//	Slave Select
	 output SDO,				//	Serial Data Out
	 output SCLK, 				// Serial CLK
	 output Hsync,				// VGA - Horizontal Synch
	 output Vsync,				// VGA - Vertical Synch
	 output speaker,			// Pac-Man's sounds
	 output siren_pin,
	 output [7:0] RGB			// VGA - 8-bit Colour
	 );
// ====================================================================================
// 								Parameters, Register, and Wires
// =====================================================================================
	assign speaker = speaker_1 & ~end_of_game;	
	assign siren_pin = siren_pin_1 & ~end_of_game;
	wire speaker_1;	
	wire siren_pin_1;

	reg pacman_dead_en;
	wire 			 VGA_CLK;						//
	wire [1:0] 	 blinky_dead;					//
	wire [1:0] 	 pinky_dead;					//	
	wire [1:0] 	 inky_dead;						//
	wire [1:0] 	 clyde_dead;					//
	wire [1:0] 	 blinky_pixel_sel;			//
	wire [1:0] 	 pinky_pixel_sel;				//
	wire [1:0]   inky_pixel_sel;				//
	wire [1:0]   clyde_pixel_sel;				//
	wire [3:0]   digit_1;						//
	wire [3:0]   digit_2;						//
	wire [3:0]   digit_3;						//
	wire [3:0] 	 digit_4;						//
	wire [3:0] 	 scared_mode_timer;
	wire [4:0] 	 h_pacman_tile;				//
	wire [4:0]   h_blinky_tile;				//
	wire [4:0]   h_pinky_tile;					//
	wire [4:0]   h_inky_tile;					//
	wire [4:0]   h_clyde_tile;					//
	wire [4:0]   v_pacman_tile;				//
	wire [4:0]   v_blinky_tile;				//
	wire [4:0]   v_pinky_tile;					//
	wire [4:0]   v_inky_tile;					//
	wire [4:0]   v_clyde_tile;					//
	wire [7:0]   board_pixel;					//
	wire [7:0]   score_pixel;					//
	wire [7:0]   pacman_pixel;					//
	wire [7:0]   blinky_pixel;					//
	wire [7:0]   pinky_pixel;					//
	wire [7:0]   inky_pixel;					//
	wire [7:0]   clyde_pixel;					//
	wire [7:0]   live_pixel;					//
	wire [7:0]   bonus_pixel;					//
   wire [9:0]   xAxis;							// x-axis data from PmodACL
   wire [9:0]   yAxis;							// y-axis data from PmodACL
   wire [9:0]   x_DOUT;							// x-axis data from PmodACL
   wire [9:0]   y_DOUT;							// y-axis data from PmodACL
	wire [9:0]   v_pacman_tile_counter;		//
	wire [9:0]   v_blinky_tile_counter;		//
	wire [9:0]   v_pinky_tile_counter;		//
	wire [9:0]   v_inky_tile_counter;		//
	wire [9:0]   v_clyde_tile_counter;		//
	wire [9:0]   v_counter;						//
	wire [10:0]  h_pacman_tile_counter;		//
	wire [10:0]  h_blinky_tile_counter;		//
	wire [10:0]  h_pinky_tile_counter;		//
	wire [10:0]  h_inky_tile_counter;		//
	wire [10:0]  h_clyde_tile_counter;		//
	wire [10:0]  h_counter;						//
	wire [13:0]  h_blinky_addr;				//
	wire [13:0]  h_pinky_addr;					//
	wire [13:0]  h_inky_addr;					//
	wire [13:0]  h_clyde_addr;					//
	wire [15:0]  x_bcdData;
	wire [15:0]  y_bcdData;
	wire [243:0] eaten;							//

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================
	
		//-----------------------------------------------
		//		 			CLOCK GENERATOR
		//-----------------------------------------------
		pacman_clock pacman_clk(
			 .CLK_IN1(clk),				// FPGA 100MHz Clock
			 .CLK_OUT1(VGA_CLK),			//	VGA Clock 75MHz
			 .CLK_OUT2(FPGA_CLK),		// 100MHz Clock
			 .CLK_OUT3(SOUND_CLK)		// 25MHz Clock
			 );
		//-----------------------------------------------
		//		 			 VGA CONTROLLER
		//-----------------------------------------------
		vga_controller pacman_vga(
			 .clk(VGA_CLK),						//
			 .reset(reset),						//
			 .board_en(board_en),				//
			 .dot_en(dot_en),						//
			 .score_en(score_en),				//
			 .pacman_en(pacman_en),				//
			 .blinky_en(blinky_en),				//
			 .pinky_en(pinky_en),				//
			 .inky_en(inky_en),					//
			 .clyde_en(clyde_en),				//
			 .live_en(live_en),					//
			 .bonus_en(bonus_en),				//
			 .blinky_dead(blinky_dead),
			 .pinky_dead(pinky_dead),
			 .inky_dead(inky_dead),
			 .clyde_dead(clyde_dead),
			 .board_pixel(board_pixel),		//
			 .score_pixel(score_pixel),		//
			 .pacman_pixel(pacman_pixel),		//
			 .blinky_pixel(blinky_pixel),		//
			 .pinky_pixel(pinky_pixel),		//
			 .inky_pixel(inky_pixel),			//
			 .clyde_pixel(clyde_pixel),		//
			 .live_pixel(live_pixel),			//
			 .bonus_pixel(bonus_pixel),		//
			 .RGB(RGB),								//
			 .Hsync(Hsync),						//
			 .Vsync(Vsync), 						//
			 .v_counter(v_counter),				//
			 .h_counter(h_counter)				//
			 );
		//-----------------------------------------------
		//		 			BOARD CONTROLLER
		//-----------------------------------------------
		board_controller pacman_board (
			 .clk(VGA_CLK),					//
			 .reset(reset),					//
			 .grid(grid),
			 .pause(pause),					//
			 .stall(stall),					//
			 .hz_enable(pulse),				//
			 .v_counter(v_counter),			//
			 .h_counter(h_counter),			//
			 .eaten(eaten),					//
			 .board_en(board_en),			//
			 .dot_en(dot_en),					//
			 .end_of_game(end_of_game),	//
			 .board_pixel(board_pixel)		//
			 );
		//-----------------------------------------------
		//		 			PACMAN CONTROLLER
		//-----------------------------------------------
		pacman_controller pacman_control(
			 .clk(VGA_CLK),													//
			 .reset(reset),                                       //
			 .xAxis(x_bcdData),                                   //
			 .yAxis(y_bcdData),                                   //
			 .pause(pause),                                       //
			 .stall(stall),                                       //
			 .hz_enable(pulse),                                   //
			 .pacman_dead(pacman_dead),                           //
			 .end_of_game(end_of_game),                           //
			 .up_pacman_limit(up_pacman_limit),                   //
			 .down_pacman_limit(down_pacman_limit),               //
			 .left_pacman_limit(left_pacman_limit),               //
			 .right_pacman_limit(right_pacman_limit),             //
			 .v_counter(v_counter),                               //
			 .h_counter(h_counter),                               //
			 .pacman_en(pacman_en),                               //
			 .v_pacman_tile_counter(v_pacman_tile_counter),       //
			 .h_pacman_tile_counter(h_pacman_tile_counter),       //
			 .waka(waka),
			 .up_pacman_state(up_pacman_state),                   //
			 .down_pacman_state(down_pacman_state),               //
			 .left_pacman_state(left_pacman_state),               //
			 .right_pacman_state(right_pacman_state),             //
			 .pacman_pixel(pacman_pixel)                          //
			 );    
		//-----------------------------------------------
		//		 			BLINKY CONTROLLER
		//-----------------------------------------------                                    
		blinky_controller blinky_control(
			 .clk(VGA_CLK),												//
			 .reset(reset),                                    //
			 .pause(pause),                                    //
			 .stall(stall),                                    //
			 .chase(chase),                                    //
			 .end_of_game(end_of_game),                        //
			 .pacman_dead(pacman_dead),                        //
			 .scared_mode(scared_mode),                        //
			 .vsync_enable(pulse),                             //
			 .scared_mode_end(scared_mode_end),                //
			 .up_blinky_limit(up_blinky_limit),                //
			 .down_blinky_limit(down_blinky_limit),            //
			 .left_blinky_limit(left_blinky_limit),            //
			 .right_blinky_limit(right_blinky_limit),          //
			 .blinky_dead(blinky_dead),                        //
			 .blinky_pixel_sel(blinky_pixel_sel),              //
			 .h_blinky_tile(h_blinky_tile),                    //
			 .v_blinky_tile(v_blinky_tile),                    //
			 .h_pacman_tile(h_pacman_tile),                    //
			 .v_pacman_tile(v_pacman_tile),                    //
			 .v_counter(v_counter),                            //
			 .h_counter(h_counter),                            //
			 .blinky_en(blinky_en),                            //
			 .v_blinky_tile_counter(v_blinky_tile_counter),    //
			 .h_blinky_tile_counter(h_blinky_tile_counter),    //
			 .up_blinky_state(up_blinky_state),                //
			 .down_blinky_state(down_blinky_state),            //
			 .left_blinky_state(left_blinky_state),            //
			 .right_blinky_state(right_blinky_state),          //
			 .blinky_pixel(blinky_pixel),                      //
			 .h_blinky_addr(h_blinky_addr)                     //
			 );
//PINKY CONTROLLER
	pinky_controller pinky_control(.clk(VGA_CLK),
											 .reset(reset),
											 .vsync_enable(pulse),
											 .chase(chase),
											 .h_counter(h_counter),
											 .v_counter(v_counter),
											 .pause(pause),
											 .stall(stall),
											 .up_pinky_limit(up_pinky_limit),
											 .down_pinky_limit(down_pinky_limit),
											 .left_pinky_limit(left_pinky_limit),
											 .right_pinky_limit(right_pinky_limit),
											 .h_pinky_tile(h_pinky_tile),
											 .v_pinky_tile(v_pinky_tile),
											 .h_pacman_tile(h_pacman_tile),
											 .v_pacman_tile(v_pacman_tile),
											 .scared_mode(scared_mode),
											 .scared_mode_end(scared_mode_end),
											 .end_of_game(end_of_game),
											 .pinky_pixel_sel(pinky_pixel_sel),
											 .up_pacman_state(up_pacman_state),
											 .down_pacman_state(down_pacman_state),
											 .left_pacman_state(left_pacman_state),
											 .right_pacman_state(right_pacman_state),
											 .pinky_dead(pinky_dead),
											 .pacman_dead(pacman_dead),
											 .pinky_en(pinky_en),
											 .pinky_pixel(pinky_pixel),
											 .h_pinky_tile_counter(h_pinky_tile_counter),
											 .v_pinky_tile_counter(v_pinky_tile_counter),
											 .up_pinky_state(up_pinky_state),
	 										 .down_pinky_state(down_pinky_state),
											 .left_pinky_state(left_pinky_state),
											 .right_pinky_state(right_pinky_state),
											 .h_pinky_addr(h_pinky_addr));
///INKY CONTROLLER
	inky_controller inky_control(.clk(VGA_CLK),
										  .reset(reset),
									     .vsync_enable(pulse),
										  .chase(chase),
									  	  .h_counter(h_counter),
										  .v_counter(v_counter),
									     .pause(pause),
										  .stall(stall),
									 	  .up_inky_limit(up_inky_limit),
										  .down_inky_limit(down_inky_limit),
										  .left_inky_limit(left_inky_limit),
										  .right_inky_limit(right_inky_limit),
										  .h_inky_tile(h_inky_tile),
										  .v_inky_tile(v_inky_tile),
										  .h_pacman_tile(h_pacman_tile),
										  .v_pacman_tile(v_pacman_tile),
										  .h_blinky_tile(h_blinky_tile),
										  .v_blinky_tile(v_blinky_tile),
										  .scared_mode(scared_mode),
										  .scared_mode_end(scared_mode_end),
										  .end_of_game(end_of_game),
										  .inky_pixel_sel(inky_pixel_sel),
										  .up_pacman_state(up_pacman_state),
										  .down_pacman_state(down_pacman_state),
									 	  .left_pacman_state(left_pacman_state),
										  .right_pacman_state(right_pacman_state),
										  .inky_dead(inky_dead),
										  .pacman_dead(pacman_dead),
										  .inky_en(inky_en),
										  .inky_pixel(inky_pixel),
										  .h_inky_tile_counter(h_inky_tile_counter),
										  .v_inky_tile_counter(v_inky_tile_counter),
										  .up_inky_state(up_inky_state),
	 									  .down_inky_state(down_inky_state),
										  .left_inky_state(left_inky_state),
										  .right_inky_state(right_inky_state),
										  .h_inky_addr(h_inky_addr));
//CLYDE CONTROLLER
	clyde_controller clyde_control(.clk(VGA_CLK),
											 .reset(reset),
											 .vsync_enable(pulse),
											 .chase(chase),
											 .h_counter(h_counter),
											 .v_counter(v_counter),
											 .pause(pause),
											 .stall(stall),
											 .up_clyde_limit(up_clyde_limit),
											 .down_clyde_limit(down_clyde_limit),
											 .left_clyde_limit(left_clyde_limit),
											 .right_clyde_limit(right_clyde_limit),
											 .h_clyde_tile(h_clyde_tile),
											 .v_clyde_tile(v_clyde_tile),
											 .h_pacman_tile(h_pacman_tile),
											 .v_pacman_tile(v_pacman_tile),
											 .scared_mode(scared_mode),
											 .scared_mode_end(scared_mode_end),
											 .end_of_game(end_of_game),
											 .clyde_pixel_sel(clyde_pixel_sel),
											 .clyde_dead(clyde_dead),
											 .pacman_dead(pacman_dead),
											 .clyde_en(clyde_en),
											 .clyde_pixel(clyde_pixel),
											 .h_clyde_tile_counter(h_clyde_tile_counter),
											 .v_clyde_tile_counter(v_clyde_tile_counter),
											 .up_clyde_state(up_clyde_state),
	 										 .down_clyde_state(down_clyde_state),
											 .left_clyde_state(left_clyde_state),
											 .right_clyde_state(right_clyde_state),
											 .h_clyde_addr(h_clyde_addr));
											 
	ghost_chase pacman_chase(.clk(VGA_CLK),
									 .reset(reset),
									 .one_hz_enable(one_hz_enable),
									 .chase(chase));
// PAC-MAN MOVEMENT TILE
	pacman_movement_tile pacman_tile(.clk(VGA_CLK),
												.reset(reset),
												.h_counter(h_pacman_tile_counter),
												.v_counter(v_pacman_tile_counter),
												.up(up_pacman_state),
												.down(down_pacman_state),
												.left(left_pacman_state),
												.right(right_pacman_state),
												.one_hz_enable(one_hz_enable),
												.pause(pause),
												.pacman_dead_en(pacman_dead_en),
												.up_limit(up_pacman_limit),
												.down_limit(down_pacman_limit),
												.left_limit(left_pacman_limit),
												.right_limit(right_pacman_limit),
												.h_next_tile(h_pacman_tile),
												.v_next_tile(v_pacman_tile),
												.eaten(eaten),
												.scared_mode(scared_mode),
												.scared_mode_end(scared_mode_end),
												.digit_1(digit_1),
												.digit_2(digit_2),
												.digit_3(digit_3),
												.digit_4(digit_4),
												.bonus_eaten(bonus_eaten),
												.bonus_pulse(bonus_pulse),												
												.scared_mode_timer(scared_mode_timer));

// BLINKY MOVEMENT TILE
	movement_tile blinky_tile(.clk(VGA_CLK),
									  .reset(reset),
									  .h_counter(h_blinky_tile_counter),
									  .v_counter(v_blinky_tile_counter),
								  	  .up(up_blinky_state),
									  .down(down_blinky_state),
									  .left(left_blinky_state),
									  .right(right_blinky_state),
									  .up_limit(up_blinky_limit),
									  .down_limit(down_blinky_limit),
									  .left_limit(left_blinky_limit),
									  .right_limit(right_blinky_limit),
									  .h_next_tile(h_blinky_tile),
									  .v_next_tile(v_blinky_tile));
// PINKY MOVEMENT TILE
	movement_tile pinky_tile(.clk(VGA_CLK),
									  .reset(reset),
									  .h_counter(h_pinky_tile_counter),
									  .v_counter(v_pinky_tile_counter),
								  	  .up(up_pinky_state),
									  .down(down_pinky_state),
									  .left(left_pinky_state),
									  .right(right_pinky_state),
									  .up_limit(up_pinky_limit),
									  .down_limit(down_pinky_limit),
									  .left_limit(left_pinky_limit),
									  .right_limit(right_pinky_limit),
									  .h_next_tile(h_pinky_tile),
									  .v_next_tile(v_pinky_tile));
// INKY MOVEMENT TILE
	movement_tile inky_tile(.clk(VGA_CLK),
									  .reset(reset),
									  .h_counter(h_inky_tile_counter),
									  .v_counter(v_inky_tile_counter),
								  	  .up(up_inky_state),
									  .down(down_inky_state),
									  .left(left_inky_state),
									  .right(right_inky_state),
									  .up_limit(up_inky_limit),
									  .down_limit(down_inky_limit),
									  .left_limit(left_inky_limit),
									  .right_limit(right_inky_limit),
									  .h_next_tile(h_inky_tile),
									  .v_next_tile(v_inky_tile));
// CLYDE MOVEMENT TILE
	movement_tile clyde_tile(.clk(VGA_CLK),
									  .reset(reset),
									  .h_counter(h_clyde_tile_counter),
									  .v_counter(v_clyde_tile_counter),
								  	  .up(up_clyde_state),
									  .down(down_clyde_state),
									  .left(left_clyde_state),
									  .right(right_clyde_state),
									  .up_limit(up_clyde_limit),
									  .down_limit(down_clyde_limit),
									  .left_limit(left_clyde_limit),
									  .right_limit(right_clyde_limit),
									  .h_next_tile(h_clyde_tile),
									  .v_next_tile(v_clyde_tile));

// PULSE GENERATOR
	vsync_pulse pacman_pulse(.clk(VGA_CLK),
									 .reset(reset),
									 .Vsync(Vsync),
									 .pulse(pulse));
// PULSE GENERATOR
	one_hz_enable_generator pacman_one_hz(.clk(VGA_CLK),
													  .reset(reset),
													  .one_hz_enable(one_hz_enable));
//BLINKY & PINKY ROM
	blinky_rom Rom(VGA_CLK,h_blinky_addr,blinky_pixel_sel,
						VGA_CLK,h_pinky_addr,pinky_pixel_sel);
	blinky_rom Rom2(VGA_CLK,h_inky_addr,inky_pixel_sel,
						 VGA_CLK,h_clyde_addr,clyde_pixel_sel);								  
// Score controller
	score_controller score_control(.clk(VGA_CLK),
										 .reset(reset),
										 .h_counter(h_counter),
										 .v_counter(v_counter),
										 .zero_pixel(zero_pixel),
										 .one_pixel(one_pixel),
										 .two_pixel(two_pixel),
										 .three_pixel(three_pixel),
										 .four_pixel(four_pixel),
										 .h_digit_zero(h_digit_zero),
										 .h_digit_one(h_digit_one),
										 .h_digit_two(h_digit_two),
										 .h_digit_three(h_digit_three),
										 .h_digit_four(h_digit_four),
										 .v_digit(v_digit), 
										 .score_pixel(score_pixel), 
										 .score_en(score_en));
// First digit
	score_rom first_digit(.clk(VGA_CLK),
								.reset(reset),
								.score_val(4'b0),
								.h_enable(h_digit_zero),
								.v_enable(v_digit),
								.pixel(zero_pixel));
// Second digit
	score_rom second_digit(.clk(VGA_CLK),
							  .reset(reset),
							  .score_val(digit_1),
							  .h_enable(h_digit_one),
							  .v_enable(v_digit),
							  .pixel(one_pixel));
// Third digit
	score_rom third_digit(.clk(VGA_CLK),
								 .reset(reset),
								 .score_val(digit_2),
								 .h_enable(h_digit_two),
								 .v_enable(v_digit),
								 .pixel(two_pixel));
// Forth digit
	score_rom forth_digit(.clk(VGA_CLK),
								 .reset(reset),
								 .score_val(digit_3),
								 .h_enable(h_digit_three),
								 .v_enable(v_digit),
								 .pixel(three_pixel));
// Fifth digit
	score_rom fifth_digit(.clk(VGA_CLK),
								.reset(reset),
								.score_val(digit_4),
								.h_enable(h_digit_four),
								.v_enable(v_digit),
								.pixel(four_pixel));
// LIVE CONTROLLER
	live_controller live_control(.clk(VGA_CLK),
										  .reset(reset),
										  .h_counter(h_counter),
										  .v_counter(v_counter),
										  .h_pacman_tile(h_pacman_tile),
										  .v_pacman_tile(v_pacman_tile),
										  .h_blinky_tile(h_blinky_tile),
										  .v_blinky_tile(v_blinky_tile),
										  .h_pinky_tile(h_pinky_tile),
										  .v_pinky_tile(v_pinky_tile),
										  .h_inky_tile(h_inky_tile),
										  .v_inky_tile(v_inky_tile),
										  .h_clyde_tile(h_clyde_tile),
										  .v_clyde_tile(v_clyde_tile),
										  .scared_mode(scared_mode),
										  .one_hz_enable(one_hz_enable),
										  .scared_mode_timer(scared_mode_timer),
										  .live_pixel(live_pixel),
										  .live_en(live_en),
										  .pacman_dead(pacman_dead),
										  .blinky_dead(blinky_dead),
										  .pinky_dead(pinky_dead),
										  .inky_dead(inky_dead),
										  .clyde_dead(clyde_dead),
										  .new_game(new_game));	
// BONUS CONTROLLER
	bonus_controller bonus_control(.clk(VGA_CLK),
											 .reset(reset),
											 .h_counter(h_counter),
											 .v_counter(v_counter),
											 .one_hz_enable(one_hz_enable),
											 .pause(pause),
										    .pacman_dead(pacman_dead),
											 .bonus_eaten(bonus_eaten),
											 .bonus_pixel(bonus_pixel),
											 .bonus_en(bonus_en),
											 .stall(stall));

		//-----------------------------------------------
		//		 			 Interfaces PmodACL
		//-----------------------------------------------
		SPIcomponent SPI(
			.CLK(VGA_CLK),
			.RST(reset),
			.START(START),
			.SDI(SDI),
			.SDO(SDO),
			.SCLK(SCLK),
			.SS(SS),
			.xAxis(xAxis),
			.yAxis(yAxis)//,
//			.zAxis(zAxis)
		);
		//-----------------------------------------------
		//	 Generates a 5Hz Data Transfer Request Signal
		//-----------------------------------------------
	ClkDiv_5Hz genStart(
		.CLK(FPGA_CLK),
		.RST(reset),
		.CLKOUT(START)
		);
	
	wire Sw_intermission = 1'b0;
	wire Sw_extrapac = 1'b0;
	wire Sw_wakka = 1'b0;
	wire Sw_intermission2 = 1'b0;
	wire anySwitch = 1'b0;
	wire soundStarts = 1'b0;
	wire siren_en= ~scared_mode & ~stall & ~pacman_dead ;
//	wire pacman_dead_en = pacman_dead & ~end_of_game ;																 //allagh
	wire	eatghost = (blinky_dead[0]==1'b1 | pinky_dead[0]==1'b1 | inky_dead[0]==1'b1 | clyde_dead[0]==1'b1); //allagh
//	wire stall_en=  stall  & ~pacman_dead & new_game & flag_death;
	wire stall_en=  stall  & ~pacman_dead & new_game & ~flag_intro_played;	//intro mia fora
	wire waka_en =  waka & ~pacman_dead_en & ~pacman_dead & ~stall;
	
	reg flag_death = 1'b1;
	reg [22:0] counter_168ms;
	reg counter_168ms_init;
	reg counter_168ms_en;
	reg flag_finish = 0;
	reg flag_intro_played;
	
	always @ (posedge SOUND_CLK) begin
		if (reset) begin
			counter_168ms <= 23'b0;
			counter_168ms_en <= 1'b0;
		end	
		else if (counter_168ms==23'd4200000 || counter_168ms_init) begin
			counter_168ms <= 23'b0;
			if (counter_168ms_init)
				counter_168ms_en <= 1'b0;
			else 
				counter_168ms_en <= 1'b1;
		end
		else begin
			counter_168ms <= counter_168ms + 23'b1;
			counter_168ms_en <= 1'b0;
		end
	end

	always @ (posedge SOUND_CLK) begin
		if (reset) begin
			pacman_dead_en <= 0;
			flag_death <= 1;
			counter_168ms_init <= 0;
			 flag_finish <= 0;
			 flag_intro_played <= 0;	//intro mia fora
		end
		else if (pacman_dead && flag_death ) begin //&& soundEnded
			pacman_dead_en <= 1;
			flag_death <= 0;
			counter_168ms_init <= 1;
			flag_intro_played <= 1;		//intro mia fora
		end
		else if (pacman_dead_en && counter_168ms_en) begin
			pacman_dead_en <= 0;
		end		
		else if ((stall  & ~pacman_dead & new_game) | (~new_game & stall & ~flag_finish)) begin
			flag_death <= 1;
			counter_168ms_init <= 0;
			if(~new_game)
				flag_finish <= 1;
		end	
		else
			counter_168ms_init <= 0;
	end
			
			
	siren pacman_siren (
    .clk(SOUND_CLK), 
    .speaker_en(siren_en), 
    .speaker_2(speaker_1), 
    .speaker(siren_pin_1)
    );

	waka_2	pacman_music(
    .clk(FPGA_CLK), 
    .reset(reset), 
    .Sw_waka(waka_en), 
    .Sw_eatghost(eatghost), 
    .Sw_death(pacman_dead_en), 
    .Sw_intermission(Sw_intermission), 
    .Sw_extrapac(Sw_extrapac), 
    .Sw_eatfruit(bonus_pulse), 
    .Sw_wakka(Sw_wakka), 
    .Sw_intro(stall_en), 
    .extrapac6_btnr(scared_mode), 
    .Sw_intermission2(Sw_intermission2), 
    .speaker(speaker_1), 
    .soundEnded(soundEnded), 
    .anySwitch(anySwitch), 
    .soundStarts(soundStarts)
    );

	 ssdCtrl FormatData(
		.CLK(FPGA_CLK), 
		.RST(reset), 
		.x_DIN(x_DOUT), 
		.y_DIN(y_DOUT), 
		.x_bcdData(x_bcdData), 
		.y_bcdData(y_bcdData)
		);
	sel_Data SelectDATA(
		.CLK(FPGA_CLK), 
		.RST(reset), 
		.xAxis(xAxis), 
		.yAxis(yAxis), 
		.x_DOUT(x_DOUT), 
		.y_DOUT(y_DOUT)
		);
		
endmodule
