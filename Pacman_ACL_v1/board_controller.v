`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Panagiotis Skrimponis
// 
// Create Date:    20:07:45 07/16/2013 
// Design Name: Pac-Man
// Module Name:    board_controller 
// Project Name: DESIGN OF AN INTERACTIVE GAME IN A RECONFIGURABLE PLATFORM
// Target Devices: Spartan 6 Nexys 3
// Tool versions: 
// Description: This module controls the board, the dots and the super dots
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
module board_controller(
	 input clk,							// VGA CLK 75MHz
	 input reset, 						// System Reset
	 input grid,
	 input pause,						//	User's pause button
	 input stall,						// System pause
	 input hz_enable,					// 1Hz enable synch pulse
	 input [9:0] v_counter,			// Screen vertical counter
	 input [10:0] h_counter,		// Screen horizontal counter
	 input [244:1] eaten,			// 244-bit variable which determines if a dot is eaten
	 output board_en, 				// Board enable signal
	 output dot_en,					// Pill and super Pill enable signal
	 output reg end_of_game,		// it determines if the game is ended
	 output reg [7:0] board_pixel	// 8-bit Board RGB
	 );
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	// If the game ended and pacman is a winner the lines start to blink
	reg blink;
	reg [4:0] blink_counter;
	reg [3:0] blink_max_counter;
	// Counters to read the ROM and display the map on the screen
	reg [17:0] h_addr_1;																								// counter for the left side of the map
	reg [17:0] h_addr_2;																								// counter for the right side of the map
	
	wire h_board_1 = (h_counter > `H_BOARD_ON) & (h_counter < (`H_BOARD_ON+281));					// it determines when the horizontal limits of the left side of the map
	wire h_board_2 = (h_counter > (`H_BOARD_ON+280)) & (h_counter < (`H_BOARD_ON+561));			// it determines when the horizontal limits of the right side of the map
	wire v_board	= (v_counter > `V_BOARD_ON) & (v_counter < `V_BOARD_OFF);						// it determines when the vertical limits of the map
	wire board_1 = h_board_1 & v_board;																			// it determines when the left side of the board is on
	wire board_2 = h_board_2 & v_board;																			// it determines when the right side of the board is on
	wire board = board_1 | board_2;																				// it determines when the board is on
	assign pause_en =(pause | stall);																			// it determines when we have to pause the function of the board
	assign board_en = board | /*(debug & board) |*/ dot;													// it determines when board, dot and grid debug layout are on

	// Dot_i (i=1,2,..244) determines if the dots or super dots are eaten by Pac-Man
	wire dot_1 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[1];
	wire dot_2 = (h_counter == (`H_DEBUG_3_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[2];
	wire dot_3 = (h_counter == (`H_DEBUG_4_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[3];
	wire dot_4 = (h_counter == (`H_DEBUG_5_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[4];
	wire dot_5 = (h_counter == (`H_DEBUG_6_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[5];
	wire dot_6 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[6];
	wire dot_7 = (h_counter == (`H_DEBUG_8_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[7];
	wire dot_8 = (h_counter == (`H_DEBUG_9_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[8];
	wire dot_9 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[9];
	wire dot_10 = (h_counter == (`H_DEBUG_11_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[10];
	wire dot_11 = (h_counter == (`H_DEBUG_12_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[11];
	wire dot_12 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[12];
	wire dot_13 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[13];
	wire dot_14 = (h_counter == (`H_DEBUG_17_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[14];
	wire dot_15 = (h_counter == (`H_DEBUG_18_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[15];
	wire dot_16 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[16];
	wire dot_17 = (h_counter == (`H_DEBUG_20_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[17];
	wire dot_18 = (h_counter == (`H_DEBUG_21_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[18];
	wire dot_19 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[19];
	wire dot_20 = (h_counter == (`H_DEBUG_23_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[20];
	wire dot_21 = (h_counter == (`H_DEBUG_24_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[21];
	wire dot_22 = (h_counter == (`H_DEBUG_25_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[22];
	wire dot_23 = (h_counter == (`H_DEBUG_26_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[23];
	wire dot_24 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `DOT_CENTER)) & eaten[24];
	wire dot_25 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER )) & (v_counter == (`V_DEBUG_3_OFF + `DOT_CENTER)) & eaten[25];
	wire dot_26 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `DOT_CENTER)) & eaten[26];
	wire dot_27 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `DOT_CENTER)) & eaten[27];
	wire dot_28 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `DOT_CENTER)) & eaten[28];
	wire dot_29 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `DOT_CENTER)) & eaten[29];
	wire dot_30 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `DOT_CENTER)) & eaten[30];
	wire dot_31 = (h_counter > (`H_DEBUG_2_OFF + `DOT_CENTER - 5)) & (v_counter > (`V_DEBUG_4_OFF + `DOT_CENTER - 5)) &
					  (h_counter < (`H_DEBUG_2_OFF + `DOT_CENTER + 4)) & (v_counter < (`V_DEBUG_4_OFF + `DOT_CENTER + 4)) & eaten[31] & blink;
	wire dot_32 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_4_OFF + `DOT_CENTER)) & eaten[32];
	wire dot_33 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_4_OFF + `DOT_CENTER)) & eaten[33];
	wire dot_34 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_4_OFF + `DOT_CENTER)) & eaten[34];
	wire dot_35 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_4_OFF + `DOT_CENTER)) & eaten[35];
	wire dot_36 = (h_counter > (`H_DEBUG_27_OFF + `DOT_CENTER - 5)) & (v_counter > (`V_DEBUG_4_OFF + `DOT_CENTER - 5)) &
					  (h_counter < (`H_DEBUG_27_OFF + `DOT_CENTER + 4)) & (v_counter < (`V_DEBUG_4_OFF + `DOT_CENTER + 4)) &	eaten[36] & blink;
	wire dot_37 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `DOT_CENTER)) & eaten[37];
	wire dot_38 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `DOT_CENTER)) & eaten[38];
	wire dot_39 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `DOT_CENTER)) & eaten[39];
	wire dot_40 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `DOT_CENTER)) & eaten[40];
	wire dot_41 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `DOT_CENTER)) & eaten[41];
	wire dot_42 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `DOT_CENTER)) & eaten[42];
	wire dot_43 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[43];
	wire dot_44 = (h_counter == (`H_DEBUG_3_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[44];
	wire dot_45 = (h_counter == (`H_DEBUG_4_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[45];
	wire dot_46 = (h_counter == (`H_DEBUG_5_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[46];
	wire dot_47 = (h_counter == (`H_DEBUG_6_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[47];
	wire dot_48 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[48];
	wire dot_49 = (h_counter == (`H_DEBUG_8_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[49];
	wire dot_50 = (h_counter == (`H_DEBUG_9_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[50];
	wire dot_51 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[51];
	wire dot_52 = (h_counter == (`H_DEBUG_11_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[52];
	wire dot_53 = (h_counter == (`H_DEBUG_12_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[53];
	wire dot_54 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[54];
	wire dot_55 = (h_counter == (`H_DEBUG_14_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[55];
	wire dot_56 = (h_counter == (`H_DEBUG_15_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[56];
	wire dot_57 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[57];
	wire dot_58 = (h_counter == (`H_DEBUG_17_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[58];
	wire dot_59 = (h_counter == (`H_DEBUG_18_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[59];
	wire dot_60 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[60];
	wire dot_61 = (h_counter == (`H_DEBUG_20_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[61];
	wire dot_62 = (h_counter == (`H_DEBUG_21_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[62];
	wire dot_63 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[63];
	wire dot_64 = (h_counter == (`H_DEBUG_23_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[64];
	wire dot_65 = (h_counter == (`H_DEBUG_24_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[65];
	wire dot_66 = (h_counter == (`H_DEBUG_25_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[66];
	wire dot_67 = (h_counter == (`H_DEBUG_26_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[67];
	wire dot_68 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `DOT_CENTER)) & eaten[68];
	wire dot_69 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `DOT_CENTER)) & eaten[69];
	wire dot_70 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `DOT_CENTER)) & eaten[70];
	wire dot_71 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `DOT_CENTER)) & eaten[71];
	wire dot_72 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `DOT_CENTER)) & eaten[72];
	wire dot_73 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `DOT_CENTER)) & eaten[73];
	wire dot_74 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `DOT_CENTER)) & eaten[74];
	wire dot_75 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `DOT_CENTER)) & eaten[75];
	wire dot_76 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `DOT_CENTER)) & eaten[76];
	wire dot_77 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `DOT_CENTER)) & eaten[77];
	wire dot_78 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `DOT_CENTER)) & eaten[78];
	wire dot_79 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `DOT_CENTER)) & eaten[79];
	wire dot_80 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `DOT_CENTER)) & eaten[80];
	wire dot_81 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[81];
	wire dot_82 = (h_counter == (`H_DEBUG_3_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[82];
	wire dot_83 = (h_counter == (`H_DEBUG_4_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[83];
	wire dot_84 = (h_counter == (`H_DEBUG_5_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[84];
	wire dot_85 = (h_counter == (`H_DEBUG_6_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[85];
	wire dot_86 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[86];
	wire dot_87 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[87];
	wire dot_88 = (h_counter == (`H_DEBUG_11_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[88];
	wire dot_89 = (h_counter == (`H_DEBUG_12_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[89];
	wire dot_90 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[90];
	wire dot_91 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[91];
	wire dot_92 = (h_counter == (`H_DEBUG_17_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[92];
	wire dot_93 = (h_counter == (`H_DEBUG_18_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[93];
	wire dot_94 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[94];
	wire dot_95 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[95];
	wire dot_96 = (h_counter == (`H_DEBUG_23_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[96];
	wire dot_97 = (h_counter == (`H_DEBUG_24_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[97];
	wire dot_98 = (h_counter == (`H_DEBUG_25_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[98];
	wire dot_99 = (h_counter == (`H_DEBUG_26_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[99];
	wire dot_100 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `DOT_CENTER)) & eaten[100];
	wire dot_101 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_10_OFF + `DOT_CENTER)) & eaten[101];
	wire dot_102 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_10_OFF + `DOT_CENTER)) & eaten[102];
	wire dot_103 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_11_OFF + `DOT_CENTER)) & eaten[103];
	wire dot_104 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_11_OFF + `DOT_CENTER)) & eaten[104];
	wire dot_105 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `DOT_CENTER)) & eaten[105];
	wire dot_106 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `DOT_CENTER)) & eaten[106];
	wire dot_107 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_13_OFF + `DOT_CENTER)) & eaten[107];
	wire dot_108 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_13_OFF + `DOT_CENTER)) & eaten[108];
	wire dot_109 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_14_OFF + `DOT_CENTER)) & eaten[109];
	wire dot_110 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_14_OFF + `DOT_CENTER)) & eaten[110];
	wire dot_111 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `DOT_CENTER)) & eaten[111];
	wire dot_112 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `DOT_CENTER)) & eaten[112];
	wire dot_113 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_16_OFF + `DOT_CENTER)) & eaten[113];
	wire dot_114 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_16_OFF + `DOT_CENTER)) & eaten[114];
	wire dot_115 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_17_OFF + `DOT_CENTER)) & eaten[115];
	wire dot_116 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_17_OFF + `DOT_CENTER)) & eaten[116];
	wire dot_117 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `DOT_CENTER)) & eaten[117];
	wire dot_118 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `DOT_CENTER)) & eaten[118];
	wire dot_119 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_19_OFF + `DOT_CENTER)) & eaten[119];
	wire dot_120 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_19_OFF + `DOT_CENTER)) & eaten[120];
	wire dot_121 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_20_OFF + `DOT_CENTER)) & eaten[121];
	wire dot_122 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_20_OFF + `DOT_CENTER)) & eaten[122];
	wire dot_123 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[123];
	wire dot_124 = (h_counter == (`H_DEBUG_3_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[124];
	wire dot_125 = (h_counter == (`H_DEBUG_4_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[125];
	wire dot_126 = (h_counter == (`H_DEBUG_5_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[126];
	wire dot_127 = (h_counter == (`H_DEBUG_6_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[127];
	wire dot_128 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[128];
	wire dot_129 = (h_counter == (`H_DEBUG_8_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[129];
	wire dot_130 = (h_counter == (`H_DEBUG_9_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[130];
	wire dot_131 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[131];
	wire dot_132 = (h_counter == (`H_DEBUG_11_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[132];
	wire dot_133 = (h_counter == (`H_DEBUG_12_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[133];
	wire dot_134 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[134];
	wire dot_135 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[135];
	wire dot_136 = (h_counter == (`H_DEBUG_17_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[136];
	wire dot_137 = (h_counter == (`H_DEBUG_18_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[137];
	wire dot_138 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[138];
	wire dot_139 = (h_counter == (`H_DEBUG_20_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[139];
	wire dot_140 = (h_counter == (`H_DEBUG_21_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[140];
	wire dot_141 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[141];
	wire dot_142 = (h_counter == (`H_DEBUG_23_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[142];
	wire dot_143 = (h_counter == (`H_DEBUG_24_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[143];
	wire dot_144 = (h_counter == (`H_DEBUG_25_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[144];
	wire dot_145 = (h_counter == (`H_DEBUG_26_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[145];
	wire dot_146 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `DOT_CENTER)) & eaten[146];
	wire dot_147 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `DOT_CENTER)) & eaten[147];
	wire dot_148 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `DOT_CENTER)) & eaten[148];
	wire dot_149 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `DOT_CENTER)) & eaten[149];
	wire dot_150 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `DOT_CENTER)) & eaten[150];
	wire dot_151 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `DOT_CENTER)) & eaten[151];
	wire dot_152 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `DOT_CENTER)) & eaten[152];
	wire dot_153 = (h_counter > (`H_DEBUG_2_OFF + `DOT_CENTER - 5)) & (v_counter > (`V_DEBUG_23_OFF + `DOT_CENTER - 5)) & 
						(h_counter < (`H_DEBUG_2_OFF + `DOT_CENTER + 4)) & (v_counter < (`V_DEBUG_23_OFF + `DOT_CENTER + 4)) & eaten[153] & blink;
	wire dot_154 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_23_OFF + `DOT_CENTER)) & eaten[154];
	wire dot_155 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_23_OFF + `DOT_CENTER)) & eaten[155];
	wire dot_156 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_23_OFF + `DOT_CENTER)) & eaten[156];
	wire dot_157 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_23_OFF + `DOT_CENTER)) & eaten[157];
	wire dot_158 = (h_counter > (`H_DEBUG_27_OFF + `DOT_CENTER - 5)) & (v_counter > (`V_DEBUG_23_OFF + `DOT_CENTER - 5)) &
						(h_counter < (`H_DEBUG_27_OFF + `DOT_CENTER + 4)) & (v_counter < (`V_DEBUG_23_OFF + `DOT_CENTER + 4)) & eaten[158] & blink;
	wire dot_159 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[159];
	wire dot_160 = (h_counter == (`H_DEBUG_3_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[160];
	wire dot_161 = (h_counter == (`H_DEBUG_4_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[161];
	wire dot_162 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[162];
	wire dot_163 = (h_counter == (`H_DEBUG_8_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[163];
	wire dot_164 = (h_counter == (`H_DEBUG_9_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[164];
	wire dot_165 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[165];
	wire dot_166 = (h_counter == (`H_DEBUG_11_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[166];
	wire dot_167 = (h_counter == (`H_DEBUG_12_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[167];
	wire dot_168 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[168];
	wire dot_169 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[169];
	wire dot_170 = (h_counter == (`H_DEBUG_17_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[170];
	wire dot_171 = (h_counter == (`H_DEBUG_18_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[171];
	wire dot_172 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[172];
	wire dot_173 = (h_counter == (`H_DEBUG_20_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[173];
	wire dot_174 = (h_counter == (`H_DEBUG_21_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[174];
	wire dot_175 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[175];
	wire dot_176 = (h_counter == (`H_DEBUG_25_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[176];
	wire dot_177 = (h_counter == (`H_DEBUG_26_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[177];
	wire dot_178 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `DOT_CENTER)) & eaten[178];
	wire dot_179 = (h_counter == (`H_DEBUG_4_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `DOT_CENTER)) & eaten[179];
	wire dot_180 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `DOT_CENTER)) & eaten[180];
	wire dot_181 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `DOT_CENTER)) & eaten[181];
	wire dot_182 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `DOT_CENTER)) & eaten[182];
	wire dot_183 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `DOT_CENTER)) & eaten[183];
	wire dot_184 = (h_counter == (`H_DEBUG_25_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `DOT_CENTER)) & eaten[184];
	wire dot_185 = (h_counter == (`H_DEBUG_4_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `DOT_CENTER)) & eaten[185];
	wire dot_186 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `DOT_CENTER)) & eaten[186];
	wire dot_187 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `DOT_CENTER)) & eaten[187];
	wire dot_188 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `DOT_CENTER)) & eaten[188];
	wire dot_189 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `DOT_CENTER)) & eaten[189];
	wire dot_190 = (h_counter == (`H_DEBUG_25_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `DOT_CENTER)) & eaten[190];
	wire dot_191 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[191];
	wire dot_192 = (h_counter == (`H_DEBUG_3_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[192];
	wire dot_193 = (h_counter == (`H_DEBUG_4_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[193];
	wire dot_194 = (h_counter == (`H_DEBUG_5_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[194];
	wire dot_195 = (h_counter == (`H_DEBUG_6_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[195];
	wire dot_196 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[196];
	wire dot_197 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[197];
	wire dot_198 = (h_counter == (`H_DEBUG_11_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[198];
	wire dot_199 = (h_counter == (`H_DEBUG_12_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[199];
	wire dot_200 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[200];
	wire dot_201 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[201];
	wire dot_202 = (h_counter == (`H_DEBUG_17_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[202];
	wire dot_203 = (h_counter == (`H_DEBUG_18_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[203];
	wire dot_204 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[204];
	wire dot_205 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[205];
	wire dot_206 = (h_counter == (`H_DEBUG_23_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[206];
	wire dot_207 = (h_counter == (`H_DEBUG_24_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[207];
	wire dot_208 = (h_counter == (`H_DEBUG_25_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[208];
	wire dot_209 = (h_counter == (`H_DEBUG_26_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[209];
	wire dot_210 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `DOT_CENTER)) & eaten[210];
	wire dot_211 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_28_OFF + `DOT_CENTER)) & eaten[211];
	wire dot_212 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_28_OFF + `DOT_CENTER)) & eaten[212];
	wire dot_213 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_28_OFF + `DOT_CENTER)) & eaten[213];
	wire dot_214 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_28_OFF + `DOT_CENTER)) & eaten[214];
	wire dot_215 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_29_OFF + `DOT_CENTER)) & eaten[215];
	wire dot_216 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_29_OFF + `DOT_CENTER)) & eaten[216];
	wire dot_217 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_29_OFF + `DOT_CENTER)) & eaten[217];
	wire dot_218 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_29_OFF + `DOT_CENTER)) & eaten[218];
	wire dot_219 = (h_counter == (`H_DEBUG_2_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[219];
	wire dot_220 = (h_counter == (`H_DEBUG_3_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[220];
	wire dot_221 = (h_counter == (`H_DEBUG_4_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[221];
	wire dot_222 = (h_counter == (`H_DEBUG_5_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[222];
	wire dot_223 = (h_counter == (`H_DEBUG_6_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[223];
	wire dot_224 = (h_counter == (`H_DEBUG_7_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[224];
	wire dot_225 = (h_counter == (`H_DEBUG_8_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[225];
	wire dot_226 = (h_counter == (`H_DEBUG_9_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[226];
	wire dot_227 = (h_counter == (`H_DEBUG_10_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[227];
	wire dot_228 = (h_counter == (`H_DEBUG_11_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[228];
	wire dot_229 = (h_counter == (`H_DEBUG_12_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[229];
	wire dot_230 = (h_counter == (`H_DEBUG_13_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[230];
	wire dot_231 = (h_counter == (`H_DEBUG_14_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[231];
	wire dot_232 = (h_counter == (`H_DEBUG_15_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[232];
	wire dot_233 = (h_counter == (`H_DEBUG_16_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[233];
	wire dot_234 = (h_counter == (`H_DEBUG_17_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[234];
	wire dot_235 = (h_counter == (`H_DEBUG_18_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[235];
	wire dot_236 = (h_counter == (`H_DEBUG_19_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[236];
	wire dot_237 = (h_counter == (`H_DEBUG_20_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[237];
	wire dot_238 = (h_counter == (`H_DEBUG_21_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[238];
	wire dot_239 = (h_counter == (`H_DEBUG_22_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[239];
	wire dot_240 = (h_counter == (`H_DEBUG_23_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[240];
	wire dot_241 = (h_counter == (`H_DEBUG_24_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[241];
	wire dot_242 = (h_counter == (`H_DEBUG_25_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[242];
	wire dot_243 = (h_counter == (`H_DEBUG_26_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[243];
	wire dot_244 = (h_counter == (`H_DEBUG_27_OFF + `DOT_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `DOT_CENTER)) & eaten[244];
	
	wire dot = dot_1 | dot_2 | dot_3 | dot_4 | dot_5 | dot_6 | dot_7 | dot_8 | dot_9 |
	dot_10 | dot_11 | dot_12 | dot_13 | dot_14 |	dot_15 | dot_16 | dot_17 | dot_18 | dot_19 |
	dot_20 | dot_21 |	dot_22 | dot_23 | dot_24 |	dot_25 | dot_26 | dot_27 | dot_28 | dot_29 |
	dot_30 | dot_31 | dot_32 | dot_33 | dot_34 | dot_35 | dot_36 | dot_37 | dot_38 | dot_39 |
	dot_40 | dot_41 |	dot_42 | dot_43 | dot_44 |	dot_45 | dot_46 | dot_47 | dot_48 | dot_49 |
	dot_50 | dot_51 | dot_52 | dot_53 | dot_54 |	dot_55 | dot_56 | dot_57 | dot_58 | dot_59 |
	dot_60 | dot_61 |	dot_62 | dot_63 | dot_64 |	dot_65 | dot_66 | dot_67 | dot_68 | dot_69 |
	dot_70 | dot_71 | dot_72 | dot_73 | dot_74 |	dot_75 | dot_76 | dot_77 | dot_78 | dot_79 |
	dot_80 | dot_81 | dot_82 | dot_83 | dot_84 |	dot_85 | dot_86 | dot_87 | dot_88 | dot_89 |
	dot_90 | dot_91 |	dot_92 | dot_93 | dot_94 |	dot_95 | dot_96 | dot_97 | dot_98 | dot_99 |
	dot_100 | dot_101 | dot_102 | dot_103 | dot_104 | dot_105 | dot_106 | dot_107 | dot_108 | dot_109 |
	dot_110 | dot_111 | dot_112 | dot_113 | dot_114 | dot_115 | dot_116 | dot_117 | dot_118 | dot_119 |
	dot_120 | dot_121 | dot_122 | dot_123 | dot_124 | dot_125 | dot_126 | dot_127 | dot_128 | dot_129 |
	dot_130 | dot_131 | dot_132 | dot_133 | dot_134 | dot_135 | dot_136 | dot_137 | dot_138 | dot_139 |
	dot_140 | dot_141 | dot_142 | dot_143 | dot_144 | dot_145 | dot_146 | dot_147 | dot_148 | dot_149 |
	dot_150 | dot_151 | dot_152 | dot_153 | dot_154 | dot_155 | dot_156 | dot_157 | dot_158 | dot_159 |
	dot_160 | dot_161 | dot_162 | dot_163 | dot_164 | dot_165 | dot_166 | dot_167 | dot_168 | dot_169 |
	dot_170 | dot_171 | dot_172 | dot_173 | dot_174 | dot_175 | dot_176 | dot_177 | dot_178 | dot_179 |
	dot_180 | dot_181 | dot_182 | dot_183 | dot_184 | dot_185 | dot_186 | dot_187 | dot_188 | dot_189 |
	dot_190 | dot_191 | dot_192 | dot_193 | dot_194 | dot_195 | dot_196 | dot_197 | dot_198 | dot_199 |
	dot_200 | dot_201 | dot_202 | dot_203 | dot_204 | dot_205 | dot_206 | dot_207 | dot_208 | dot_209 |
	dot_210 | dot_211 | dot_212 | dot_213 | dot_214 | dot_215 | dot_216 | dot_217 | dot_218 | dot_219 |
	dot_220 | dot_221 | dot_222 | dot_223 | dot_224 | dot_225 | dot_226 | dot_227 | dot_228 | dot_229 |
	dot_230 | dot_231 | dot_232 | dot_233 | dot_234 | dot_235 | dot_236 | dot_237 | dot_238 | dot_239 |
	dot_240 | dot_241 | dot_242 | dot_243 | dot_244 ;
	
	assign dot_en = dot;
// ====================================================================================
// 								DEBUGING GRID LAYOUT
// ====================================================================================
	wire h_debug_1 = (h_counter > `H_DEBUG_1_ON) & (h_counter < `H_DEBUG_1_OFF);
	wire h_debug_2 = (h_counter > `H_DEBUG_2_ON) & (h_counter < `H_DEBUG_2_OFF);
	wire h_debug_3 = (h_counter > `H_DEBUG_3_ON) & (h_counter < `H_DEBUG_3_OFF);
	wire h_debug_4 = (h_counter > `H_DEBUG_4_ON) & (h_counter < `H_DEBUG_4_OFF);
	wire h_debug_5 = (h_counter > `H_DEBUG_5_ON) & (h_counter < `H_DEBUG_5_OFF);
	wire h_debug_6 = (h_counter > `H_DEBUG_6_ON) & (h_counter < `H_DEBUG_6_OFF);
	wire h_debug_7 = (h_counter > `H_DEBUG_7_ON) & (h_counter < `H_DEBUG_7_OFF);
	wire h_debug_8 = (h_counter > `H_DEBUG_8_ON) & (h_counter < `H_DEBUG_8_OFF);
	wire h_debug_9 = (h_counter > `H_DEBUG_9_ON) & (h_counter < `H_DEBUG_9_OFF);
	wire h_debug_10 = (h_counter > `H_DEBUG_10_ON) & (h_counter < `H_DEBUG_10_OFF);
	wire h_debug_11 = (h_counter > `H_DEBUG_11_ON) & (h_counter < `H_DEBUG_11_OFF);
	wire h_debug_12 = (h_counter > `H_DEBUG_12_ON) & (h_counter < `H_DEBUG_12_OFF);
	wire h_debug_13 = (h_counter > `H_DEBUG_13_ON) & (h_counter < `H_DEBUG_13_OFF);
	wire h_debug_14 = (h_counter > `H_DEBUG_14_ON) & (h_counter < `H_DEBUG_14_OFF);
	wire h_debug_15 = (h_counter > `H_DEBUG_15_ON) & (h_counter < `H_DEBUG_15_OFF);
	wire h_debug_16 = (h_counter > `H_DEBUG_16_ON) & (h_counter < `H_DEBUG_16_OFF);
	wire h_debug_17 = (h_counter > `H_DEBUG_17_ON) & (h_counter < `H_DEBUG_17_OFF);
	wire h_debug_18 = (h_counter > `H_DEBUG_18_ON) & (h_counter < `H_DEBUG_18_OFF);
	wire h_debug_19 = (h_counter > `H_DEBUG_19_ON) & (h_counter < `H_DEBUG_19_OFF);
	wire h_debug_20 = (h_counter > `H_DEBUG_20_ON) & (h_counter < `H_DEBUG_20_OFF);
	wire h_debug_21 = (h_counter > `H_DEBUG_21_ON) & (h_counter < `H_DEBUG_21_OFF);
	wire h_debug_22 = (h_counter > `H_DEBUG_22_ON) & (h_counter < `H_DEBUG_22_OFF);
	wire h_debug_23 = (h_counter > `H_DEBUG_23_ON) & (h_counter < `H_DEBUG_23_OFF);
	wire h_debug_24 = (h_counter > `H_DEBUG_24_ON) & (h_counter < `H_DEBUG_24_OFF);
	wire h_debug_25 = (h_counter > `H_DEBUG_25_ON) & (h_counter < `H_DEBUG_25_OFF);
	wire h_debug_26 = (h_counter > `H_DEBUG_26_ON) & (h_counter < `H_DEBUG_26_OFF);
	wire h_debug_27 = (h_counter > `H_DEBUG_27_ON) & (h_counter < `H_DEBUG_27_OFF);
	wire h_debug_28 = (h_counter > `H_DEBUG_28_ON) & (h_counter < `H_DEBUG_28_OFF);
	wire h_debug_29 = (h_counter > `H_DEBUG_29_ON) & (h_counter < `H_DEBUG_29_OFF);
	wire h_debug_30 = (h_counter > `H_DEBUG_30_ON) & (h_counter < `H_DEBUG_30_OFF);
	wire h_debug_31 = (h_counter > `H_DEBUG_31_ON) & (h_counter < `H_DEBUG_31_OFF);
	wire h_debug_32 = (h_counter > `H_DEBUG_32_ON) & (h_counter < `H_DEBUG_32_OFF);
	wire h_debug_33 = (h_counter > `H_DEBUG_33_ON) & (h_counter < `H_DEBUG_33_OFF);
	wire h_debug_34 = (h_counter > `H_DEBUG_34_ON) & (h_counter < `H_DEBUG_34_OFF);
	wire h_debug_35 = (h_counter > `H_DEBUG_35_ON) & (h_counter < `H_DEBUG_35_OFF);
	
	wire v_debug_1 = (v_counter > `V_DEBUG_1_ON) & (v_counter < `V_DEBUG_1_OFF);
	wire v_debug_2 = (v_counter > `V_DEBUG_2_ON) & (v_counter < `V_DEBUG_2_OFF);
	wire v_debug_3 = (v_counter > `V_DEBUG_3_ON) & (v_counter < `V_DEBUG_3_OFF);
	wire v_debug_4 = (v_counter > `V_DEBUG_4_ON) & (v_counter < `V_DEBUG_4_OFF);
	wire v_debug_5 = (v_counter > `V_DEBUG_5_ON) & (v_counter < `V_DEBUG_5_OFF);
	wire v_debug_6 = (v_counter > `V_DEBUG_6_ON) & (v_counter < `V_DEBUG_6_OFF);
	wire v_debug_7 = (v_counter > `V_DEBUG_7_ON) & (v_counter < `V_DEBUG_7_OFF);
	wire v_debug_8 = (v_counter > `V_DEBUG_8_ON) & (v_counter < `V_DEBUG_8_OFF);
	wire v_debug_9 = (v_counter > `V_DEBUG_9_ON) & (v_counter < `V_DEBUG_9_OFF);
	wire v_debug_10 = (v_counter > `V_DEBUG_10_ON) & (v_counter < `V_DEBUG_10_OFF);
	wire v_debug_11 = (v_counter > `V_DEBUG_11_ON) & (v_counter < `V_DEBUG_11_OFF);
	wire v_debug_12 = (v_counter > `V_DEBUG_12_ON) & (v_counter < `V_DEBUG_12_OFF);
	wire v_debug_13 = (v_counter > `V_DEBUG_13_ON) & (v_counter < `V_DEBUG_13_OFF);
	wire v_debug_14 = (v_counter > `V_DEBUG_14_ON) & (v_counter < `V_DEBUG_14_OFF);
	wire v_debug_15 = (v_counter > `V_DEBUG_15_ON) & (v_counter < `V_DEBUG_15_OFF);
	wire v_debug_16 = (v_counter > `V_DEBUG_16_ON) & (v_counter < `V_DEBUG_16_OFF);
	wire v_debug_17 = (v_counter > `V_DEBUG_17_ON) & (v_counter < `V_DEBUG_17_OFF);
	wire v_debug_18 = (v_counter > `V_DEBUG_18_ON) & (v_counter < `V_DEBUG_18_OFF);
	wire v_debug_19 = (v_counter > `V_DEBUG_19_ON) & (v_counter < `V_DEBUG_19_OFF);
	wire v_debug_20 = (v_counter > `V_DEBUG_20_ON) & (v_counter < `V_DEBUG_20_OFF);
	wire v_debug_21 = (v_counter > `V_DEBUG_21_ON) & (v_counter < `V_DEBUG_21_OFF);
	wire v_debug_22 = (v_counter > `V_DEBUG_22_ON) & (v_counter < `V_DEBUG_22_OFF);
	wire v_debug_23 = (v_counter > `V_DEBUG_23_ON) & (v_counter < `V_DEBUG_23_OFF);
	wire v_debug_24 = (v_counter > `V_DEBUG_24_ON) & (v_counter < `V_DEBUG_24_OFF);
	wire v_debug_25 = (v_counter > `V_DEBUG_25_ON) & (v_counter < `V_DEBUG_25_OFF);
	wire v_debug_26 = (v_counter > `V_DEBUG_26_ON) & (v_counter < `V_DEBUG_26_OFF);
	wire v_debug_27 = (v_counter > `V_DEBUG_27_ON) & (v_counter < `V_DEBUG_27_OFF);
	wire v_debug_28 = (v_counter > `V_DEBUG_28_ON) & (v_counter < `V_DEBUG_28_OFF);
	wire v_debug_29 = (v_counter > `V_DEBUG_29_ON) & (v_counter < `V_DEBUG_29_OFF);
	wire v_debug_30 = (v_counter > `V_DEBUG_30_ON) & (v_counter < `V_DEBUG_30_OFF);
	wire v_debug_31 = (v_counter > `V_DEBUG_31_ON) & (v_counter < `V_DEBUG_31_OFF);
	wire v_debug_32 = (v_counter > `V_DEBUG_32_ON) & (v_counter < `V_DEBUG_32_OFF);
	wire v_debug_33 = (v_counter > `V_DEBUG_33_ON) & (v_counter < `V_DEBUG_33_OFF);
	wire v_debug_34 = (v_counter > `V_DEBUG_34_ON) & (v_counter < `V_DEBUG_34_OFF);
	wire v_debug_35 = (v_counter > `V_DEBUG_35_ON) & (v_counter < `V_DEBUG_35_OFF);
	wire v_debug_36 = (v_counter > `V_DEBUG_36_ON) & (v_counter < `V_DEBUG_36_OFF);
	wire v_debug_37 = (v_counter > `V_DEBUG_37_ON) & (v_counter < `V_DEBUG_37_OFF);
	wire v_debug_38 = (v_counter > `V_DEBUG_38_ON) & (v_counter < `V_DEBUG_38_OFF);
	wire v_debug_39 = (v_counter > `V_DEBUG_39_ON) & (v_counter < `V_DEBUG_39_OFF);
	
	
	wire debug = (h_debug_1 | h_debug_2 | h_debug_3 | h_debug_4 | h_debug_5 | h_debug_6 | h_debug_7 |
	h_debug_8 | h_debug_9 | h_debug_10 | h_debug_11 | h_debug_12 | h_debug_13 | h_debug_14 |
	h_debug_15 | h_debug_16 | h_debug_17 | h_debug_18 | h_debug_19 | h_debug_20 | h_debug_21 |
	h_debug_22 | h_debug_23 | h_debug_24 |	h_debug_25 | h_debug_26 | h_debug_27 | h_debug_28 | h_debug_29 |
	h_debug_30 | h_debug_31 | h_debug_32 | h_debug_33 | h_debug_34 | h_debug_35 |
	v_debug_1 |	v_debug_2 | v_debug_3 |	v_debug_4 | v_debug_5 | v_debug_6 | v_debug_7 | v_debug_8 |
	v_debug_9 |	v_debug_10 | v_debug_11 | v_debug_12 | v_debug_13 | v_debug_14 | v_debug_15 | v_debug_16 |
	v_debug_17 | v_debug_18 | v_debug_19 | v_debug_20 | v_debug_21 |
	v_debug_22 | v_debug_23 | v_debug_24 |	v_debug_25 | v_debug_26 | v_debug_27 | v_debug_28 | v_debug_29 |
	v_debug_30 | v_debug_31 | v_debug_32 | v_debug_33 | v_debug_34 | v_debug_35 | v_debug_36 | v_debug_37 |
	v_debug_38 | v_debug_39);
// ====================================================================================
// 										 Implementation
// ====================================================================================
	
	//-----------------------------------------------
	//					Read the ROM
	// 		display the map on the screen 
	//-----------------------------------------------	
	always @ (posedge clk or posedge reset)	
		begin
			if (reset)
				begin
					h_addr_1 <= 1;
					h_addr_2 <= 1;
				end
			// Select the left side of the board to display
			else if (board_1)
				h_addr_1 <= h_addr_1 + 1'b1;
			else if((h_counter == (`H_BOARD_ON+281))&(v_board))
				h_addr_2 <= h_addr_1 - 4;
			// Select the right side of the board to display
			else if (board_2)
				h_addr_2 <= h_addr_2 - 1'b1;
			else if (!v_board)
				begin
					h_addr_1 <= 1;
					h_addr_2 <= 1;
				end
			else
				begin
					h_addr_1 <= h_addr_1;
					h_addr_1 <= h_addr_1;
				end
		end
	//-----------------------------------------------
	//	Selects the final value of the RGB
	//-----------------------------------------------	
	always @ ( * )
		begin
			if(dot)
				board_pixel = 8'b11110110;
			// Select the debug grid layout to display 
			else if(debug & board & grid)
				board_pixel = 8'b11100000;
			//Select the left side of the board to display
			else if (board_1)
				begin
					if(map_pixel_1 == 0)
						board_pixel = 8'b0;
					else
						begin
							if(end_of_game & (blink_max_counter < 15))
								begin
									if(blink)
										board_pixel = 8'b11;
									else
										board_pixel = 8'hff;
								end
							else
								board_pixel = 8'b11;
						end
				end
			// Select the right side of the board to display
			else if (board_2)
				begin
					if(map_pixel_2 == 0)
						board_pixel = 8'b0;
					else
						begin
							if(end_of_game & (blink_max_counter < 15))
								begin
									if(blink)
										board_pixel = 8'b11;
									else
										board_pixel = 8'hff;
								end
							else
								board_pixel = 8'b11;
						end
				end
			else
				begin
					board_pixel = 8'hff;
				end
		end
	//-----------------------------------------------
	//	Half-Map ROM : We need only the half of the map
	// to present the hole map.
	//-----------------------------------------------
	half_map_mem map(
		 clk,
		 h_addr_1,
		 map_pixel_1,
		 clk,
		 h_addr_2,
		 map_pixel_2
		 );
	//-----------------------------------------------
	//	Makes The Lines to Blink
	//-----------------------------------------------
	always @ ( posedge clk or posedge reset)
		begin
			if(reset)
				begin
					blink <= 1;
					blink_counter <= 0;
					blink_max_counter <= 0;
				end
			else if((blink_counter == 5'h2e) & (!pause_en))
				begin
					blink <= blink + 1;
					blink_counter <= 0;
					if(end_of_game & (blink_max_counter < 4'd15))
						blink_max_counter <= blink_max_counter + 1;
				end
			else if((!pause_en) & (hz_enable))
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
	//	Determines Whether The Game has Ended
	//-----------------------------------------------
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				end_of_game <= 0;
			else if(eaten == 0)
				end_of_game <= 1;
			else if(eaten >0)
				end_of_game <= 0;
			else
				end_of_game <= end_of_game;
		end
endmodule
