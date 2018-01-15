`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:34 08/08/2013 
// Design Name: 
// Module Name:    movement_tile 
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
module movement_tile(input clk, input reset, input [10:0] h_counter, 
input [9:0] v_counter, input up, input down, input left, input right,
output reg up_limit, output reg down_limit, output reg left_limit, output reg right_limit,
output reg [4:0] h_next_tile, output reg [4:0] v_next_tile);
	reg [9:0] up_addr;
	reg [9:0] down_addr;
	reg [9:0] left_addr;
	reg [9:0] right_addr;
	reg [4:0] h_nxt_tile;
	reg [4:0] v_nxt_tile;
	wire tile_2_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_3 = ((h_counter == (`H_DEBUG_3_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_4 = ((h_counter == (`H_DEBUG_4_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_5 = ((h_counter == (`H_DEBUG_5_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_6 = ((h_counter == (`H_DEBUG_6_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_8 = ((h_counter == (`H_DEBUG_8_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_9 = ((h_counter == (`H_DEBUG_9_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_11 = ((h_counter == (`H_DEBUG_11_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_12 = ((h_counter == (`H_DEBUG_12_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_17 = ((h_counter == (`H_DEBUG_17_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_18 = ((h_counter == (`H_DEBUG_18_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_20 = ((h_counter == (`H_DEBUG_20_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_21 = ((h_counter == (`H_DEBUG_21_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_23 = ((h_counter == (`H_DEBUG_23_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_24 = ((h_counter == (`H_DEBUG_24_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_25 = ((h_counter == (`H_DEBUG_25_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_26 = ((h_counter == (`H_DEBUG_26_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_2_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_2_OFF + `TILE_CENTER)));
	wire tile_3_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `TILE_CENTER)));
	wire tile_3_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `TILE_CENTER)));
	wire tile_3_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `TILE_CENTER)));
	wire tile_3_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `TILE_CENTER)));
	wire tile_3_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `TILE_CENTER)));
	wire tile_3_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_3_OFF + `TILE_CENTER)));
	wire tile_4_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_4_OFF + `TILE_CENTER)));
	wire tile_4_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_4_OFF + `TILE_CENTER)));
	wire tile_4_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_4_OFF + `TILE_CENTER)));
	wire tile_4_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_4_OFF + `TILE_CENTER)));
	wire tile_4_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_4_OFF + `TILE_CENTER)));
	wire tile_4_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_4_OFF + `TILE_CENTER)));
	wire tile_5_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `TILE_CENTER)));
	wire tile_5_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `TILE_CENTER)));
	wire tile_5_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `TILE_CENTER)));
	wire tile_5_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `TILE_CENTER)));
	wire tile_5_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `TILE_CENTER)));
	wire tile_5_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_5_OFF + `TILE_CENTER)));
	wire tile_6_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_3 = ((h_counter == (`H_DEBUG_3_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_4 = ((h_counter == (`H_DEBUG_4_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_5 = ((h_counter == (`H_DEBUG_5_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_6 = ((h_counter == (`H_DEBUG_6_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_8 = ((h_counter == (`H_DEBUG_8_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_9 = ((h_counter == (`H_DEBUG_9_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_11 = ((h_counter == (`H_DEBUG_11_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_12 = ((h_counter == (`H_DEBUG_12_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_14 = ((h_counter == (`H_DEBUG_14_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_15 = ((h_counter == (`H_DEBUG_15_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_17 = ((h_counter == (`H_DEBUG_17_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_18 = ((h_counter == (`H_DEBUG_18_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_20 = ((h_counter == (`H_DEBUG_20_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_21 = ((h_counter == (`H_DEBUG_21_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_23 = ((h_counter == (`H_DEBUG_23_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_24 = ((h_counter == (`H_DEBUG_24_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_25 = ((h_counter == (`H_DEBUG_25_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_26 = ((h_counter == (`H_DEBUG_26_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_6_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_6_OFF + `TILE_CENTER)));
	wire tile_7_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `TILE_CENTER)));
	wire tile_7_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `TILE_CENTER)));
	wire tile_7_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `TILE_CENTER)));
	wire tile_7_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `TILE_CENTER)));
	wire tile_7_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `TILE_CENTER)));
	wire tile_7_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_7_OFF + `TILE_CENTER)));
	wire tile_8_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `TILE_CENTER)));
	wire tile_8_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `TILE_CENTER)));
	wire tile_8_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `TILE_CENTER)));
	wire tile_8_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `TILE_CENTER)));
	wire tile_8_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `TILE_CENTER)));
	wire tile_8_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_8_OFF + `TILE_CENTER)));
	wire tile_9_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_3 = ((h_counter == (`H_DEBUG_3_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_4 = ((h_counter == (`H_DEBUG_4_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_5 = ((h_counter == (`H_DEBUG_5_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_6 = ((h_counter == (`H_DEBUG_6_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_11 = ((h_counter == (`H_DEBUG_11_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_12 = ((h_counter == (`H_DEBUG_12_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_17 = ((h_counter == (`H_DEBUG_17_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_18 = ((h_counter == (`H_DEBUG_18_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_23 = ((h_counter == (`H_DEBUG_23_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_24 = ((h_counter == (`H_DEBUG_24_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_25 = ((h_counter == (`H_DEBUG_25_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_26 = ((h_counter == (`H_DEBUG_26_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_9_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_9_OFF + `TILE_CENTER)));
	wire tile_10_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_10_OFF + `TILE_CENTER)));
	wire tile_10_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_10_OFF + `TILE_CENTER)));
	wire tile_10_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_10_OFF + `TILE_CENTER)));
	wire tile_10_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_10_OFF + `TILE_CENTER)));
	wire tile_11_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_11_OFF + `TILE_CENTER)));
	wire tile_11_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_11_OFF + `TILE_CENTER)));
	wire tile_11_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_11_OFF + `TILE_CENTER)));
	wire tile_11_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_11_OFF + `TILE_CENTER)));
	wire tile_12_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_11 = ((h_counter == (`H_DEBUG_11_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_12 = ((h_counter == (`H_DEBUG_12_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_14 = ((h_counter == (`H_DEBUG_14_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_15 = ((h_counter == (`H_DEBUG_15_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_17 = ((h_counter == (`H_DEBUG_17_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_18 = ((h_counter == (`H_DEBUG_18_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_12_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_12_OFF + `TILE_CENTER)));
	wire tile_13_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_13_OFF + `TILE_CENTER)));
	wire tile_13_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_13_OFF + `TILE_CENTER)));
	wire tile_13_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_13_OFF + `TILE_CENTER)));
	wire tile_13_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_13_OFF + `TILE_CENTER)));
	wire tile_14_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_14_OFF + `TILE_CENTER)));
	wire tile_14_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_14_OFF + `TILE_CENTER)));
	wire tile_14_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_14_OFF + `TILE_CENTER)));
	wire tile_14_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_14_OFF + `TILE_CENTER)));
	wire tile_15_1 = ((h_counter == (`H_DEBUG_1_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_3 = ((h_counter == (`H_DEBUG_3_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_4 = ((h_counter == (`H_DEBUG_4_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_5 = ((h_counter == (`H_DEBUG_5_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_6 = ((h_counter == (`H_DEBUG_6_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_8 = ((h_counter == (`H_DEBUG_8_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_9 = ((h_counter == (`H_DEBUG_9_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_20 = ((h_counter == (`H_DEBUG_20_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_21 = ((h_counter == (`H_DEBUG_21_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_23 = ((h_counter == (`H_DEBUG_23_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_24 = ((h_counter == (`H_DEBUG_24_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_25 = ((h_counter == (`H_DEBUG_25_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_26 = ((h_counter == (`H_DEBUG_26_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_15_28 = ((h_counter == (`H_DEBUG_28_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_15_OFF + `TILE_CENTER)));
	wire tile_16_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_16_OFF + `TILE_CENTER)));
	wire tile_16_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_16_OFF + `TILE_CENTER)));
	wire tile_16_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_16_OFF + `TILE_CENTER)));
	wire tile_16_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_16_OFF + `TILE_CENTER)));
	wire tile_17_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_17_OFF + `TILE_CENTER)));
	wire tile_17_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_17_OFF + `TILE_CENTER)));
	wire tile_17_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_17_OFF + `TILE_CENTER)));
	wire tile_17_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_17_OFF + `TILE_CENTER)));
	wire tile_18_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_11 = ((h_counter == (`H_DEBUG_11_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_12 = ((h_counter == (`H_DEBUG_12_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_14 = ((h_counter == (`H_DEBUG_14_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_15 = ((h_counter == (`H_DEBUG_15_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_17 = ((h_counter == (`H_DEBUG_17_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_18 = ((h_counter == (`H_DEBUG_18_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_18_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_18_OFF + `TILE_CENTER)));
	wire tile_19_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_19_OFF + `TILE_CENTER)));
	wire tile_19_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_19_OFF + `TILE_CENTER)));
	wire tile_19_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_19_OFF + `TILE_CENTER)));
	wire tile_19_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_19_OFF + `TILE_CENTER)));
	wire tile_20_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_20_OFF + `TILE_CENTER)));
	wire tile_20_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_20_OFF + `TILE_CENTER)));
	wire tile_20_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_20_OFF + `TILE_CENTER)));
	wire tile_20_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_20_OFF + `TILE_CENTER)));
	wire tile_21_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_3 = ((h_counter == (`H_DEBUG_3_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_4 = ((h_counter == (`H_DEBUG_4_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_5 = ((h_counter == (`H_DEBUG_5_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_6 = ((h_counter == (`H_DEBUG_6_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_8 = ((h_counter == (`H_DEBUG_8_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_9 = ((h_counter == (`H_DEBUG_9_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_11 = ((h_counter == (`H_DEBUG_11_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_12 = ((h_counter == (`H_DEBUG_12_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_17 = ((h_counter == (`H_DEBUG_17_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_18 = ((h_counter == (`H_DEBUG_18_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_20 = ((h_counter == (`H_DEBUG_20_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_21 = ((h_counter == (`H_DEBUG_21_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_23 = ((h_counter == (`H_DEBUG_23_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_24 = ((h_counter == (`H_DEBUG_24_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_25 = ((h_counter == (`H_DEBUG_25_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_26 = ((h_counter == (`H_DEBUG_26_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_21_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_21_OFF + `TILE_CENTER)));
	wire tile_22_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `TILE_CENTER)));
	wire tile_22_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `TILE_CENTER)));
	wire tile_22_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `TILE_CENTER)));
	wire tile_22_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `TILE_CENTER)));
	wire tile_22_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `TILE_CENTER)));
	wire tile_22_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_22_OFF + `TILE_CENTER)));
	wire tile_23_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_23_OFF + `TILE_CENTER)));
	wire tile_23_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_23_OFF + `TILE_CENTER)));
	wire tile_23_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_23_OFF + `TILE_CENTER)));
	wire tile_23_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_23_OFF + `TILE_CENTER)));
	wire tile_23_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_23_OFF + `TILE_CENTER)));
	wire tile_23_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_23_OFF + `TILE_CENTER)));
	wire tile_24_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_3 = ((h_counter == (`H_DEBUG_3_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_4 = ((h_counter == (`H_DEBUG_4_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_8 = ((h_counter == (`H_DEBUG_8_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_9 = ((h_counter == (`H_DEBUG_9_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_11 = ((h_counter == (`H_DEBUG_11_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_12 = ((h_counter == (`H_DEBUG_12_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_14 = ((h_counter == (`H_DEBUG_14_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_15 = ((h_counter == (`H_DEBUG_15_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_17 = ((h_counter == (`H_DEBUG_17_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_18 = ((h_counter == (`H_DEBUG_18_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_20 = ((h_counter == (`H_DEBUG_20_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_21 = ((h_counter == (`H_DEBUG_21_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_25 = ((h_counter == (`H_DEBUG_25_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_26 = ((h_counter == (`H_DEBUG_26_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_24_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_24_OFF + `TILE_CENTER)));
	wire tile_25_4 = ((h_counter == (`H_DEBUG_4_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `TILE_CENTER)));
	wire tile_25_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `TILE_CENTER)));
	wire tile_25_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `TILE_CENTER)));
	wire tile_25_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `TILE_CENTER)));
	wire tile_25_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `TILE_CENTER)));
	wire tile_25_25 = ((h_counter == (`H_DEBUG_25_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_25_OFF + `TILE_CENTER)));
	wire tile_26_4 = ((h_counter == (`H_DEBUG_4_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `TILE_CENTER)));
	wire tile_26_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `TILE_CENTER)));
	wire tile_26_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `TILE_CENTER)));
	wire tile_26_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `TILE_CENTER)));
	wire tile_26_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `TILE_CENTER)));
	wire tile_26_25 = ((h_counter == (`H_DEBUG_25_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_26_OFF + `TILE_CENTER)));
	wire tile_27_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_3 = ((h_counter == (`H_DEBUG_3_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_4 = ((h_counter == (`H_DEBUG_4_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_5 = ((h_counter == (`H_DEBUG_5_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_6 = ((h_counter == (`H_DEBUG_6_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_11 = ((h_counter == (`H_DEBUG_11_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_12 = ((h_counter == (`H_DEBUG_12_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_17 = ((h_counter == (`H_DEBUG_17_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_18 = ((h_counter == (`H_DEBUG_18_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_23 = ((h_counter == (`H_DEBUG_23_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_24 = ((h_counter == (`H_DEBUG_24_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_25 = ((h_counter == (`H_DEBUG_25_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_26 = ((h_counter == (`H_DEBUG_26_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_27_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_27_OFF + `TILE_CENTER)));
	wire tile_28_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_28_OFF + `TILE_CENTER)));
	wire tile_28_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_28_OFF + `TILE_CENTER)));
	wire tile_28_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_28_OFF + `TILE_CENTER)));
	wire tile_28_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_28_OFF + `TILE_CENTER)));
	wire tile_29_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_29_OFF + `TILE_CENTER)));
	wire tile_29_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_29_OFF + `TILE_CENTER)));
	wire tile_29_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_29_OFF + `TILE_CENTER)));
	wire tile_29_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_29_OFF + `TILE_CENTER)));
	wire tile_30_2 = ((h_counter == (`H_DEBUG_2_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_3 = ((h_counter == (`H_DEBUG_3_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_4 = ((h_counter == (`H_DEBUG_4_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_5 = ((h_counter == (`H_DEBUG_5_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_6 = ((h_counter == (`H_DEBUG_6_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_7 = ((h_counter == (`H_DEBUG_7_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_8 = ((h_counter == (`H_DEBUG_8_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_9 = ((h_counter == (`H_DEBUG_9_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_10 = ((h_counter == (`H_DEBUG_10_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_11 = ((h_counter == (`H_DEBUG_11_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_12 = ((h_counter == (`H_DEBUG_12_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_13 = ((h_counter == (`H_DEBUG_13_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_14 = ((h_counter == (`H_DEBUG_14_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_15 = ((h_counter == (`H_DEBUG_15_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_16 = ((h_counter == (`H_DEBUG_16_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_17 = ((h_counter == (`H_DEBUG_17_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_18 = ((h_counter == (`H_DEBUG_18_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_19 = ((h_counter == (`H_DEBUG_19_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_20 = ((h_counter == (`H_DEBUG_20_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_21 = ((h_counter == (`H_DEBUG_21_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_22 = ((h_counter == (`H_DEBUG_22_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_23 = ((h_counter == (`H_DEBUG_23_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_24 = ((h_counter == (`H_DEBUG_24_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_25 = ((h_counter == (`H_DEBUG_25_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_26 = ((h_counter == (`H_DEBUG_26_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
	wire tile_30_27 = ((h_counter == (`H_DEBUG_27_OFF + `TILE_CENTER)) & (v_counter == (`V_DEBUG_30_OFF + `TILE_CENTER)));
 	
	always @ (posedge clk or posedge reset)
		begin
			if(reset)
				begin
					h_nxt_tile <= 0;
					v_nxt_tile <= 0;
				end
			else
				begin
					h_nxt_tile <= h_next_tile;
					v_nxt_tile <= v_next_tile;
				end
				
		end
	
	always @ ( * )
		begin
			h_next_tile = h_nxt_tile;
			v_next_tile = v_nxt_tile;
			if(tile_2_2)
				begin
					h_next_tile = 2;
					v_next_tile = 2;
				end
			if(tile_2_3)
				begin
					h_next_tile = 3;
					v_next_tile = 2;
				end
			if(tile_2_4)
				begin
					h_next_tile = 4;
					v_next_tile = 2;
				end
			if(tile_2_5)
				begin
					h_next_tile = 5;
					v_next_tile = 2;
				end
			if(tile_2_6)
				begin
					h_next_tile = 6;
					v_next_tile = 2;
				end
			if(tile_2_7)
				begin
					h_next_tile = 7;
					v_next_tile = 2;
				end
			if(tile_2_8)
				begin
					h_next_tile = 8;
					v_next_tile = 2;
				end
			if(tile_2_9)
				begin
					h_next_tile = 9;
					v_next_tile = 2;
				end
			if(tile_2_10)
				begin
					h_next_tile = 10;
					v_next_tile = 2;
				end
			if(tile_2_11)
				begin
					h_next_tile = 11;
					v_next_tile = 2;
				end
			if(tile_2_12)
				begin
					h_next_tile = 12;
					v_next_tile = 2;
				end
			if(tile_2_13)
				begin
					h_next_tile = 13;
					v_next_tile = 2;
				end
			if(tile_2_16)
				begin
					h_next_tile = 16;
					v_next_tile = 2;
				end
			if(tile_2_17)
				begin
					h_next_tile = 17;
					v_next_tile = 2;
				end
			if(tile_2_18)
				begin
					h_next_tile = 18;
					v_next_tile = 2;
				end
			if(tile_2_19)
				begin
					h_next_tile = 19;
					v_next_tile = 2;
				end
			if(tile_2_20)
				begin
					h_next_tile = 20;
					v_next_tile = 2;
				end
			if(tile_2_21)
				begin
					h_next_tile = 21;
					v_next_tile = 2;
				end
			if(tile_2_22)
				begin
					h_next_tile = 22;
					v_next_tile = 2;
				end
			if(tile_2_23)
				begin
					h_next_tile = 23;
					v_next_tile = 2;
				end
			if(tile_2_24)
				begin
					h_next_tile = 24;
					v_next_tile = 2;
				end
			if(tile_2_25)
				begin
					h_next_tile = 25;
					v_next_tile = 2;
				end
			if(tile_2_26)
				begin
					h_next_tile = 26;
					v_next_tile = 2;
				end
			if(tile_2_27)
				begin
					h_next_tile = 27;
					v_next_tile = 2;
				end
			if(tile_3_2)
				begin
					h_next_tile = 2;
					v_next_tile = 3;
				end
			if(tile_3_7)
				begin
					h_next_tile = 7;
					v_next_tile = 3;
				end
			if(tile_3_13)
				begin
					h_next_tile = 13;
					v_next_tile = 3;
				end
			if(tile_3_16)
				begin
					h_next_tile = 16;
					v_next_tile = 3;
				end
			if(tile_3_22)
				begin
					h_next_tile = 22;
					v_next_tile = 3;
				end
			if(tile_3_27)
				begin
					h_next_tile = 27;
					v_next_tile = 3;
				end
			if(tile_4_2)
				begin
					h_next_tile = 2;
					v_next_tile = 4;
				end
			if(tile_4_7)
				begin
					h_next_tile = 7;
					v_next_tile = 4;
				end
			if(tile_4_13)
				begin
					h_next_tile = 13;
					v_next_tile = 4;
				end
			if(tile_4_16)
				begin
					h_next_tile = 16;
					v_next_tile = 4;
				end
			if(tile_4_22)
				begin
					h_next_tile = 22;
					v_next_tile = 4;
				end
			if(tile_4_27)
				begin
					h_next_tile = 27;
					v_next_tile = 4;
				end
			if(tile_5_2)
				begin
					h_next_tile = 2;
					v_next_tile = 5;
				end
			if(tile_5_7)
				begin
					h_next_tile = 7;
					v_next_tile = 5;
				end
			if(tile_5_13)
				begin
					h_next_tile = 13;
					v_next_tile = 5;
				end
			if(tile_5_16)
				begin
					h_next_tile = 16;
					v_next_tile = 5;
				end
			if(tile_5_22)
				begin
					h_next_tile = 22;
					v_next_tile = 5;
				end
			if(tile_5_27)
				begin
					h_next_tile = 27;
					v_next_tile = 5;
				end
			if(tile_6_2)
				begin
					h_next_tile = 2;
					v_next_tile = 6;
				end
			if(tile_6_3)
				begin
					h_next_tile = 3;
					v_next_tile = 6;
				end
			if(tile_6_4)
				begin
					h_next_tile = 4;
					v_next_tile = 6;
				end
			if(tile_6_5)
				begin
					h_next_tile = 5;
					v_next_tile = 6;
				end
			if(tile_6_6)
				begin
					h_next_tile = 6;
					v_next_tile = 6;
				end
			if(tile_6_7)
				begin
					h_next_tile = 7;
					v_next_tile = 6;
				end
			if(tile_6_8)
				begin
					h_next_tile = 8;
					v_next_tile = 6;
				end
			if(tile_6_9)
				begin
					h_next_tile = 9;
					v_next_tile = 6;
				end
			if(tile_6_10)
				begin
					h_next_tile = 10;
					v_next_tile = 6;
				end
			if(tile_6_11)
				begin
					h_next_tile = 11;
					v_next_tile = 6;
				end
			if(tile_6_12)
				begin
					h_next_tile = 12;
					v_next_tile = 6;
				end
			if(tile_6_13)
				begin
					h_next_tile = 13;
					v_next_tile = 6;
				end
			if(tile_6_14)
				begin
					h_next_tile = 14;
					v_next_tile = 6;
				end
			if(tile_6_15)
				begin
					h_next_tile = 15;
					v_next_tile = 6;
				end
			if(tile_6_16)
				begin
					h_next_tile = 16;
					v_next_tile = 6;
				end
			if(tile_6_17)
				begin
					h_next_tile = 17;
					v_next_tile = 6;
				end
			if(tile_6_18)
				begin
					h_next_tile = 18;
					v_next_tile = 6;
				end
			if(tile_6_19)
				begin
					h_next_tile = 19;
					v_next_tile = 6;
				end
			if(tile_6_20)
				begin
					h_next_tile = 20;
					v_next_tile = 6;
				end
			if(tile_6_21)
				begin
					h_next_tile = 21;
					v_next_tile = 6;
				end
			if(tile_6_22)
				begin
					h_next_tile = 22;
					v_next_tile = 6;
				end
			if(tile_6_23)
				begin
					h_next_tile = 23;
					v_next_tile = 6;
				end
			if(tile_6_24)
				begin
					h_next_tile = 24;
					v_next_tile = 6;
				end
			if(tile_6_25)
				begin
					h_next_tile = 25;
					v_next_tile = 6;
				end
			if(tile_6_26)
				begin
					h_next_tile = 26;
					v_next_tile = 6;
				end
			if(tile_6_27)
				begin
					h_next_tile = 27;
					v_next_tile = 6;
				end
			if(tile_7_2)
				begin
					h_next_tile = 2;
					v_next_tile = 7;
				end
			if(tile_7_7)
				begin
					h_next_tile = 7;
					v_next_tile = 7;
				end
			if(tile_7_10)
				begin
					h_next_tile = 10;
					v_next_tile = 7;
				end
			if(tile_7_19)
				begin
					h_next_tile = 19;
					v_next_tile = 7;
				end
			if(tile_7_22)
				begin
					h_next_tile = 22;
					v_next_tile = 7;
				end
			if(tile_7_27)
				begin
					h_next_tile = 27;
					v_next_tile = 7;
				end
			if(tile_8_2)
				begin
					h_next_tile = 2;
					v_next_tile = 8;
				end
			if(tile_8_7)
				begin
					h_next_tile = 7;
					v_next_tile = 8;
				end
			if(tile_8_10)
				begin
					h_next_tile = 10;
					v_next_tile = 8;
				end
			if(tile_8_19)
				begin
					h_next_tile = 19;
					v_next_tile = 8;
				end
			if(tile_8_22)
				begin
					h_next_tile = 22;
					v_next_tile = 8;
				end
			if(tile_8_27)
				begin
					h_next_tile = 27;
					v_next_tile = 8;
				end
			if(tile_9_2)
				begin
					h_next_tile = 2;
					v_next_tile = 9;
				end
			if(tile_9_3)
				begin
					h_next_tile = 3;
					v_next_tile = 9;
				end
			if(tile_9_4)
				begin
					h_next_tile = 4;
					v_next_tile = 9;
				end
			if(tile_9_5)
				begin
					h_next_tile = 5;
					v_next_tile = 9;
				end
			if(tile_9_6)
				begin
					h_next_tile = 6;
					v_next_tile = 9;
				end
			if(tile_9_7)
				begin
					h_next_tile = 7;
					v_next_tile = 9;
				end
			if(tile_9_10)
				begin
					h_next_tile = 10;
					v_next_tile = 9;
				end
			if(tile_9_11)
				begin
					h_next_tile = 11;
					v_next_tile = 9;
				end
			if(tile_9_12)
				begin
					h_next_tile = 12;
					v_next_tile = 9;
				end
			if(tile_9_13)
				begin
					h_next_tile = 13;
					v_next_tile = 9;
				end
			if(tile_9_16)
				begin
					h_next_tile = 16;
					v_next_tile = 9;
				end
			if(tile_9_17)
				begin
					h_next_tile = 17;
					v_next_tile = 9;
				end
			if(tile_9_18)
				begin
					h_next_tile = 18;
					v_next_tile = 9;
				end
			if(tile_9_19)
				begin
					h_next_tile = 19;
					v_next_tile = 9;
				end
			if(tile_9_22)
				begin
					h_next_tile = 22;
					v_next_tile = 9;
				end
			if(tile_9_23)
				begin
					h_next_tile = 23;
					v_next_tile = 9;
				end
			if(tile_9_24)
				begin
					h_next_tile = 24;
					v_next_tile = 9;
				end
			if(tile_9_25)
				begin
					h_next_tile = 25;
					v_next_tile = 9;
				end
			if(tile_9_26)
				begin
					h_next_tile = 26;
					v_next_tile = 9;
				end
			if(tile_9_27)
				begin
					h_next_tile = 27;
					v_next_tile = 9;
				end
			if(tile_10_7)
				begin
					h_next_tile = 7;
					v_next_tile = 10;
				end
			if(tile_10_13)
				begin
					h_next_tile = 13;
					v_next_tile = 10;
				end
			if(tile_10_16)
				begin
					h_next_tile = 16;
					v_next_tile = 10;
				end
			if(tile_10_22)
				begin
					h_next_tile = 22;
					v_next_tile = 10;
				end
			if(tile_11_7)
				begin
					h_next_tile = 7;
					v_next_tile = 11;
				end
			if(tile_11_13)
				begin
					h_next_tile = 13;
					v_next_tile = 11;
				end
			if(tile_11_16)
				begin
					h_next_tile = 16;
					v_next_tile = 11;
				end
			if(tile_11_22)
				begin
					h_next_tile = 22;
					v_next_tile = 11;
				end
			if(tile_12_7)
				begin
					h_next_tile = 7;
					v_next_tile = 12;
				end
			if(tile_12_10)
				begin
					h_next_tile = 10;
					v_next_tile = 12;
				end
			if(tile_12_11)
				begin
					h_next_tile = 11;
					v_next_tile = 12;
				end
			if(tile_12_12)
				begin
					h_next_tile = 12;
					v_next_tile = 12;
				end
			if(tile_12_13)
				begin
					h_next_tile = 13;
					v_next_tile = 12;
				end
			if(tile_12_14)
				begin
					h_next_tile = 14;
					v_next_tile = 12;
				end
			if(tile_12_15)
				begin
					h_next_tile = 15;
					v_next_tile = 12;
				end
			if(tile_12_16)
				begin
					h_next_tile = 16;
					v_next_tile = 12;
				end
			if(tile_12_17)
				begin
					h_next_tile = 17;
					v_next_tile = 12;
				end
			if(tile_12_18)
				begin
					h_next_tile = 18;
					v_next_tile = 12;
				end
			if(tile_12_19)
				begin
					h_next_tile = 19;
					v_next_tile = 12;
				end
			if(tile_12_22)
				begin
					h_next_tile = 22;
					v_next_tile = 12;
				end
			if(tile_13_7)
				begin
					h_next_tile = 7;
					v_next_tile = 13;
				end
			if(tile_13_10)
				begin
					h_next_tile = 10;
					v_next_tile = 13;
				end
			if(tile_13_19)
				begin
					h_next_tile = 19;
					v_next_tile = 13;
				end
			if(tile_13_22)
				begin
					h_next_tile = 22;
					v_next_tile = 13;
				end
			if(tile_14_7)
				begin
					h_next_tile = 7;
					v_next_tile = 14;
				end
			if(tile_14_10)
				begin
					h_next_tile = 10;
					v_next_tile = 14;
				end
			if(tile_14_19)
				begin
					h_next_tile = 19;
					v_next_tile = 14;
				end
			if(tile_14_22)
				begin
					h_next_tile = 22;
					v_next_tile = 14;
				end
			if(tile_15_1)
				begin
					h_next_tile = 2;
					v_next_tile = 15;
				end
			if(tile_15_2)
				begin
					h_next_tile = 2;
					v_next_tile = 15;
				end
			if(tile_15_3)
				begin
					h_next_tile = 3;
					v_next_tile = 15;
				end
			if(tile_15_4)
				begin
					h_next_tile = 4;
					v_next_tile = 15;
				end
			if(tile_15_5)
				begin
					h_next_tile = 5;
					v_next_tile = 15;
				end
			if(tile_15_6)
				begin
					h_next_tile = 6;
					v_next_tile = 15;
				end
			if(tile_15_7)
				begin
					h_next_tile = 7;
					v_next_tile = 15;
				end
			if(tile_15_8)
				begin
					h_next_tile = 8;
					v_next_tile = 15;
				end
			if(tile_15_9)
				begin
					h_next_tile = 9;
					v_next_tile = 15;
				end
			if(tile_15_10)
				begin
					h_next_tile = 10;
					v_next_tile = 15;
				end
			if(tile_15_19)
				begin
					h_next_tile = 19;
					v_next_tile = 15;
				end
			if(tile_15_20)
				begin
					h_next_tile = 20;
					v_next_tile = 15;
				end
			if(tile_15_21)
				begin
					h_next_tile = 21;
					v_next_tile = 15;
				end
			if(tile_15_22)
				begin
					h_next_tile = 22;
					v_next_tile = 15;
				end
			if(tile_15_23)
				begin
					h_next_tile = 23;
					v_next_tile = 15;
				end
			if(tile_15_24)
				begin
					h_next_tile = 24;
					v_next_tile = 15;
				end
			if(tile_15_25)
				begin
					h_next_tile = 25;
					v_next_tile = 15;
				end
			if(tile_15_26)
				begin
					h_next_tile = 26;
					v_next_tile = 15;
				end
			if(tile_15_27)
				begin
					h_next_tile = 27;
					v_next_tile = 15;
				end
			if(tile_15_28)
				begin
					h_next_tile = 27;
					v_next_tile = 15;
				end
			if(tile_16_7)
				begin
					h_next_tile = 7;
					v_next_tile = 16;
				end
			if(tile_16_10)
				begin
					h_next_tile = 10;
					v_next_tile = 16;
				end
			if(tile_16_19)
				begin
					h_next_tile = 16;
					v_next_tile = 16;
				end
			if(tile_16_22)
				begin
					h_next_tile = 22;
					v_next_tile = 16;
				end
			if(tile_17_7)
				begin
					h_next_tile = 7;
					v_next_tile = 17;
				end
			if(tile_17_10)
				begin
					h_next_tile = 10;
					v_next_tile = 17;
				end
			if(tile_17_19)
				begin
					h_next_tile = 19;
					v_next_tile = 17;
				end
			if(tile_17_22)
				begin
					h_next_tile = 22;
					v_next_tile = 17;
				end
			if(tile_18_7)
				begin
					h_next_tile = 7;
					v_next_tile = 18;
				end
			if(tile_18_10)
				begin
					h_next_tile = 10;
					v_next_tile = 18;
				end
			if(tile_18_11)
				begin
					h_next_tile = 11;
					v_next_tile = 18;
				end
			if(tile_18_12)
				begin
					h_next_tile = 12;
					v_next_tile = 18;
				end
			if(tile_18_13)
				begin
					h_next_tile = 13;
					v_next_tile = 18;
				end
			if(tile_18_14)
				begin
					h_next_tile = 14;
					v_next_tile = 18;
				end
			if(tile_18_15)
				begin
					h_next_tile = 15;
					v_next_tile = 18;
				end
			if(tile_18_16)
				begin
					h_next_tile = 16;
					v_next_tile = 18;
				end
			if(tile_18_17)
				begin
					h_next_tile = 17;
					v_next_tile = 18;
				end
			if(tile_18_18)
				begin
					h_next_tile = 18;
					v_next_tile = 18;
				end
			if(tile_18_19)
				begin
					h_next_tile = 19;
					v_next_tile = 18;
				end
			if(tile_18_22)
				begin
					h_next_tile = 22;
					v_next_tile = 18;
				end
			if(tile_19_7)
				begin
					h_next_tile = 7;
					v_next_tile = 19;
				end
			if(tile_19_10)
				begin
					h_next_tile = 10;
					v_next_tile = 19;
				end
			if(tile_19_19)
				begin
					h_next_tile = 19;
					v_next_tile = 19;
				end
			if(tile_19_22)
				begin
					h_next_tile = 22;
					v_next_tile = 19;
				end
			if(tile_20_7)
				begin
					h_next_tile = 7;
					v_next_tile = 20;
				end
			if(tile_20_10)
				begin
					h_next_tile = 10;
					v_next_tile = 20;
				end
			if(tile_20_19)
				begin
					h_next_tile = 19;
					v_next_tile = 20;
				end
			if(tile_20_22)
				begin
					h_next_tile = 22;
					v_next_tile = 20;
				end
			if(tile_21_2)
				begin
					h_next_tile = 2;
					v_next_tile = 21;
				end
			if(tile_21_3)
				begin
					h_next_tile = 3;
					v_next_tile = 21;
				end
			if(tile_21_4)
				begin
					h_next_tile = 4;
					v_next_tile = 21;
				end
			if(tile_21_5)
				begin
					h_next_tile = 5;
					v_next_tile = 21;
				end
			if(tile_21_6)
				begin
					h_next_tile = 6;
					v_next_tile = 21;
				end
			if(tile_21_7)
				begin
					h_next_tile = 7;
					v_next_tile = 21;
				end
			if(tile_21_8)
				begin
					h_next_tile = 8;
					v_next_tile = 21;
				end
			if(tile_21_9)
				begin
					h_next_tile = 9;
					v_next_tile = 21;
				end
			if(tile_21_10)
				begin
					h_next_tile = 10;
					v_next_tile = 21;
				end
			if(tile_21_11)
				begin
					h_next_tile = 11;
					v_next_tile = 21;
				end
			if(tile_21_12)
				begin
					h_next_tile = 12;
					v_next_tile = 21;
				end
			if(tile_21_13)
				begin
					h_next_tile = 13;
					v_next_tile = 21;
				end
			if(tile_21_16)
				begin
					h_next_tile = 16;
					v_next_tile = 21;
				end
			if(tile_21_17)
				begin
					h_next_tile = 17;
					v_next_tile = 21;
				end
			if(tile_21_18)
				begin
					h_next_tile = 18;
					v_next_tile = 21;
				end
			if(tile_21_19)
				begin
					h_next_tile = 19;
					v_next_tile = 21;
				end
			if(tile_21_20)
				begin
					h_next_tile = 20;
					v_next_tile = 21;
				end
			if(tile_21_21)
				begin
					h_next_tile = 21;
					v_next_tile = 21;
				end
			if(tile_21_22)
				begin
					h_next_tile = 22;
					v_next_tile = 21;
				end
			if(tile_21_23)
				begin
					h_next_tile = 23;
					v_next_tile = 21;
				end
			if(tile_21_24)
				begin
					h_next_tile = 24;
					v_next_tile = 21;
				end
			if(tile_21_25)
				begin
					h_next_tile = 25;
					v_next_tile = 21;
				end
			if(tile_21_26)
				begin
					h_next_tile = 26;
					v_next_tile = 21;
				end
			if(tile_21_27)
				begin
					h_next_tile = 27;
					v_next_tile = 21;
				end
			if(tile_22_2)
				begin
					h_next_tile = 2;
					v_next_tile = 22;
				end
			if(tile_22_7)
				begin
					h_next_tile = 7;
					v_next_tile = 22;
				end
			if(tile_22_13)
				begin
					h_next_tile = 13;
					v_next_tile = 22;
				end
			if(tile_22_16)
				begin
					h_next_tile = 16;
					v_next_tile = 22;
				end
			if(tile_22_22)
				begin
					h_next_tile = 22;
					v_next_tile = 22;
				end
			if(tile_22_27)
				begin
					h_next_tile = 27;
					v_next_tile = 22;
				end
			if(tile_23_2)
				begin
					h_next_tile = 2;
					v_next_tile = 23;
				end
			if(tile_23_7)
				begin
					h_next_tile = 7;
					v_next_tile = 23;
				end
			if(tile_23_13)
				begin
					h_next_tile = 13;
					v_next_tile = 23;
				end
			if(tile_23_16)
				begin
					h_next_tile = 16;
					v_next_tile = 23;
				end
			if(tile_23_22)
				begin
					h_next_tile = 22;
					v_next_tile = 23;
				end
			if(tile_23_27)
				begin
					h_next_tile = 27;
					v_next_tile = 23;
				end
			if(tile_24_2)
				begin
					h_next_tile = 2;
					v_next_tile = 24;
				end
			if(tile_24_3)
				begin
					h_next_tile = 3;
					v_next_tile = 24;
				end
			if(tile_24_4)
				begin
					h_next_tile = 4;
					v_next_tile = 24;
				end
			if(tile_24_7)
				begin
					h_next_tile = 7;
					v_next_tile = 24;
				end
			if(tile_24_8)
				begin
					h_next_tile = 8;
					v_next_tile = 24;
				end
			if(tile_24_9)
				begin
					h_next_tile = 9;
					v_next_tile = 24;
				end
			if(tile_24_10)
				begin
					h_next_tile = 10;
					v_next_tile = 24;
				end
			if(tile_24_11)
				begin
					h_next_tile = 11;
					v_next_tile = 24;
				end
			if(tile_24_12)
				begin
					h_next_tile = 12;
					v_next_tile = 24;
				end
			if(tile_24_13)
				begin
					h_next_tile = 13;
					v_next_tile = 24;
				end
			if(tile_24_14)
				begin
					h_next_tile = 14;
					v_next_tile = 24;
				end
			if(tile_24_15)
				begin
					h_next_tile = 15;
					v_next_tile = 24;
				end
			if(tile_24_16)
				begin
					h_next_tile = 16;
					v_next_tile = 24;
				end
			if(tile_24_17)
				begin
					h_next_tile = 17;
					v_next_tile = 24;
				end
			if(tile_24_18)
				begin
					h_next_tile = 18;
					v_next_tile = 24;
				end
			if(tile_24_19)
				begin
					h_next_tile = 19;
					v_next_tile = 24;
				end
			if(tile_24_20)
				begin
					h_next_tile = 20;
					v_next_tile = 24;
				end
			if(tile_24_21)
				begin
					h_next_tile = 21;
					v_next_tile = 24;
				end
			if(tile_24_22)
				begin
					h_next_tile = 22;
					v_next_tile = 24;
				end
			if(tile_24_25)
				begin
					h_next_tile = 25;
					v_next_tile = 24;
				end
			if(tile_24_26)
				begin
					h_next_tile = 26;
					v_next_tile = 24;
				end
			if(tile_24_27)
				begin
					h_next_tile = 27;
					v_next_tile = 24;
				end
			if(tile_25_4)
				begin
					h_next_tile = 4;
					v_next_tile = 25;
				end
			if(tile_25_7)
				begin
					h_next_tile = 7;
					v_next_tile = 25;
				end
			if(tile_25_10)
				begin
					h_next_tile = 10;
					v_next_tile = 25;
				end
			if(tile_25_19)
				begin
					h_next_tile = 19;
					v_next_tile = 25;
				end
			if(tile_25_22)
				begin
					h_next_tile = 22;
					v_next_tile = 25;
				end
			if(tile_25_25)
				begin
					h_next_tile = 25;
					v_next_tile = 25;
				end
			if(tile_26_4)
				begin
					h_next_tile = 4;
					v_next_tile = 26;
				end
			if(tile_26_7)
				begin
					h_next_tile = 7;
					v_next_tile = 26;
				end
			if(tile_26_10)
				begin
					h_next_tile = 10;
					v_next_tile = 26;
				end
			if(tile_26_19)
				begin
					h_next_tile = 19;
					v_next_tile = 26;
				end
			if(tile_26_22)
				begin
					h_next_tile = 22;
					v_next_tile = 26;
				end
			if(tile_26_25)
				begin
					h_next_tile = 25;
					v_next_tile = 26;
				end
			if(tile_27_2)
				begin
					h_next_tile = 2;
					v_next_tile = 27;
				end
			if(tile_27_3)
				begin
					h_next_tile = 3;
					v_next_tile = 27;
				end
			if(tile_27_4)
				begin
					h_next_tile = 4;
					v_next_tile = 27;
				end
			if(tile_27_5)
				begin
					h_next_tile = 5;
					v_next_tile = 27;
				end
			if(tile_27_6)
				begin
					h_next_tile = 6;
					v_next_tile = 27;
				end
			if(tile_27_7)
				begin
					h_next_tile = 7;
					v_next_tile = 27;
				end
			if(tile_27_10)
				begin
					h_next_tile = 10;
					v_next_tile = 27;
				end
			if(tile_27_11)
				begin
					h_next_tile = 11;
					v_next_tile = 27;
				end
			if(tile_27_12)
				begin
					h_next_tile = 12;
					v_next_tile = 27;
				end
			if(tile_27_13)
				begin
					h_next_tile = 13;
					v_next_tile = 27;
				end
			if(tile_27_16)
				begin
					h_next_tile = 16;
					v_next_tile = 27;
				end
			if(tile_27_17)
				begin
					h_next_tile = 17;
					v_next_tile = 27;
				end
			if(tile_27_18)
				begin
					h_next_tile = 18;
					v_next_tile = 27;
				end
			if(tile_27_19)
				begin
					h_next_tile = 19;
					v_next_tile = 27;
				end
			if(tile_27_22)
				begin
					h_next_tile = 22;
					v_next_tile = 27;
				end
			if(tile_27_23)
				begin
					h_next_tile = 23;
					v_next_tile = 27;
				end
			if(tile_27_24)
				begin
					h_next_tile = 24;
					v_next_tile = 27;
				end
			if(tile_27_25)
				begin
					h_next_tile = 25;
					v_next_tile = 27;
				end
			if(tile_27_26)
				begin
					h_next_tile = 26;
					v_next_tile = 27;
				end
			if(tile_27_27)
				begin
					h_next_tile = 27;
					v_next_tile = 27;
				end
			if(tile_28_2)
				begin
					h_next_tile = 2;
					v_next_tile = 28;
				end
			if(tile_28_13)
				begin
					h_next_tile = 13;
					v_next_tile = 28;
				end
			if(tile_28_16)
				begin
					h_next_tile = 16;
					v_next_tile = 28;
				end
			if(tile_28_27)
				begin
					h_next_tile = 27;
					v_next_tile = 28;
				end
			if(tile_29_2)
				begin
					h_next_tile = 2;
					v_next_tile = 29;
				end
			if(tile_29_13)
				begin
					h_next_tile = 13;
					v_next_tile = 29;
				end
			if(tile_29_16)
				begin
					h_next_tile = 16;
					v_next_tile = 29;
				end
			if(tile_29_27)
				begin
					h_next_tile = 27;
					v_next_tile = 29;
				end
			if(tile_30_2)
				begin
					h_next_tile = 2;
					v_next_tile = 30;
				end
			if(tile_30_3)
				begin
					h_next_tile = 3;
					v_next_tile = 30;
				end
			if(tile_30_4)
				begin
					h_next_tile = 4;
					v_next_tile = 30;
				end
			if(tile_30_5)
				begin
					h_next_tile = 5;
					v_next_tile = 30;
				end
			if(tile_30_6)
				begin
					h_next_tile = 6;
					v_next_tile = 30;
				end
			if(tile_30_7)
				begin
					h_next_tile = 7;
					v_next_tile = 30;
				end
			if(tile_30_8)
				begin
					h_next_tile = 8;
					v_next_tile = 30;
				end
			if(tile_30_9)
				begin
					h_next_tile = 9;
					v_next_tile = 30;
				end
			if(tile_30_10)
				begin
					h_next_tile = 10;
					v_next_tile = 30;
				end
			if(tile_30_11)
				begin
					h_next_tile = 11;
					v_next_tile = 30;
				end
			if(tile_30_12)
				begin
					h_next_tile = 12;
					v_next_tile = 30;
				end
			if(tile_30_13)
				begin
					h_next_tile = 13;
					v_next_tile = 30;
				end
			if(tile_30_14)
				begin
					h_next_tile = 14;
					v_next_tile = 30;
				end
			if(tile_30_15)
				begin
					h_next_tile = 15;
					v_next_tile = 30;
				end
			if(tile_30_16)
				begin
					h_next_tile = 16;
					v_next_tile = 30;
				end
			if(tile_30_17)
				begin
					h_next_tile = 17;
					v_next_tile = 30;
				end
			if(tile_30_18)
				begin
					h_next_tile = 18;
					v_next_tile = 30;
				end
			if(tile_30_19)
				begin
					h_next_tile = 19;
					v_next_tile = 30;
				end
			if(tile_30_20)
				begin
					h_next_tile = 20;
					v_next_tile = 30;
				end
			if(tile_30_21)
				begin
					h_next_tile = 21;
					v_next_tile = 30;
				end
			if(tile_30_22)
				begin
					h_next_tile = 22;
					v_next_tile = 30;
				end
			if(tile_30_23)
				begin
					h_next_tile = 23;
					v_next_tile = 30;
				end
			if(tile_30_24)
				begin
					h_next_tile = 24;
					v_next_tile = 30;
				end
			if(tile_30_25)
				begin
					h_next_tile = 25;
					v_next_tile = 30;
				end
			if(tile_30_26)
				begin
					h_next_tile = 26;
					v_next_tile = 30;
				end
			if(tile_30_27)
				begin
					h_next_tile = 27;
					v_next_tile = 30;
				end
		end
	always @ ( * )
		begin
			up_limit = 1;
			down_limit = 1;
			left_limit = 1;
			right_limit = 1;
			up_limit = (left|right)?0:up_limit;
			down_limit = (left|right)?0:down_limit;
			left_limit = (up|down)?0:left_limit;
			right_limit = (up|down)?0:right_limit;
			if(tile_2_2 | tile_2_16 |  tile_9_16 |  tile_12_10 | tile_21_2 | tile_21_16 | tile_24_25 | 
			tile_27_2 | tile_27_16)
				begin
					up_limit = 0;
					down_limit = 1;
					left_limit = 0;
					right_limit = 1;
				end
			if(tile_2_13 | tile_2_27 | tile_9_13 | tile_12_19 | tile_21_27 | tile_21_13 | tile_24_4 |
			 tile_27_13 | tile_27_27)
				begin
					up_limit = 0;
					down_limit = 1;
					left_limit = 1;
					right_limit = 0;
				end
			if(tile_9_2 | tile_9_10 | tile_24_2 | tile_27_10 | tile_27_22 | tile_30_2)
				begin
					up_limit = 1;
					down_limit = 0;
					left_limit = 0;
					right_limit = 1;
				end
			if(tile_9_19 | tile_9_27 | tile_24_27 | tile_27_7 | tile_27_19 | tile_30_27)
				begin
					up_limit = 1;
					down_limit = 0;
					left_limit = 1;
					right_limit = 0;
				end
			if(tile_6_7 | tile_6_22 | tile_15_7 | tile_15_22 | tile_21_7 | tile_21_22)
				begin
					up_limit = 1;
					down_limit = 1;
					left_limit = 1;
					right_limit = 1;
				end
			if(tile_6_27 | tile_9_7 | tile_15_10 | tile_18_19 | tile_24_22)
				begin
					up_limit = 1;
					down_limit = 1;
					left_limit = 1;
					right_limit = 0;
				end
			if(tile_6_2 | tile_9_22 | tile_15_19 | tile_18_10 | tile_24_7)
				begin
					up_limit = 1;
					down_limit = 1;
					left_limit = 0;
					right_limit = 1;
				end
			if(tile_2_7 | tile_2_22 | tile_6_10 | tile_6_19 | tile_24_10 | tile_24_19)
				begin
					up_limit = 0;
					down_limit = 1;
					left_limit = 1;
					right_limit = 1;
				end					
			if(tile_6_13 | tile_6_16 | tile_12_13 | tile_12_16 |
			tile_21_10 | tile_21_19 | tile_24_13 | tile_24_16 | tile_27_4 | tile_27_25 |
			tile_30_13 | tile_30_16)
				begin
					up_limit = 1;
					down_limit = 0;
					left_limit = 1;
					right_limit = 1;
				end
			if(tile_2_3 | tile_2_4 | tile_2_5 | tile_2_6 | tile_2_8 | tile_2_9 | tile_2_10 | tile_2_11 |
			tile_2_12 | tile_2_17 | tile_2_18 | tile_2_19 | tile_2_20 | tile_2_21 | tile_2_23 |
			tile_2_24 | tile_2_25 | tile_2_26 |
			tile_6_3 | tile_6_4 | tile_6_5 | tile_6_6 | tile_6_8 | tile_6_9 | tile_6_11 | tile_6_12 |
			tile_6_14 | tile_6_15 | tile_6_17 | tile_6_18 | tile_6_20 | tile_6_21 | tile_6_23 |
			tile_6_24 | tile_6_25 | tile_6_26 |
			tile_9_3 | tile_9_4 | tile_9_5 | tile_9_6 | tile_9_11 | tile_9_12 | tile_9_17 | tile_9_18 |
			tile_9_23 | tile_9_24 | tile_9_25 | tile_9_26 |
			tile_12_11 | tile_12_12 | tile_12_14 | tile_12_15 | tile_12_17 | tile_12_18 |	
			tile_15_1 | tile_15_2 | tile_15_3 | tile_15_4 | tile_15_5 | tile_15_6 | tile_15_8 | tile_15_9 |
			tile_15_20 | tile_15_21 | tile_15_23 | tile_15_24 | tile_15_25 | tile_15_26 | tile_15_27 | 
			tile_15_28 |
			tile_18_11 | tile_18_12 | tile_18_13 | tile_18_14 | tile_18_15 | tile_18_16 | 
			tile_18_17 | tile_18_18 | 
			tile_21_3 | tile_21_4 | tile_21_5 | tile_21_6 | tile_21_8 | tile_21_9 | tile_21_11 |
			tile_21_12 | tile_21_17 | tile_21_18 | tile_21_20 | tile_21_21 | tile_21_23 | tile_21_24 |
			tile_21_25 | tile_21_26 |
			tile_24_3 | tile_24_8 | tile_24_9 | tile_24_11 | tile_24_12 | tile_24_14 | tile_24_15 |
			tile_24_17 | tile_24_18 | tile_24_20 | tile_24_21 | tile_24_26 |
			tile_27_3 | tile_27_5 | tile_27_6 | tile_27_11 | tile_27_12 | tile_27_17 | tile_27_18 | 
			tile_27_23 | tile_27_24 | tile_27_26 |
			tile_30_3 | tile_30_4 | tile_30_5 | tile_30_6 | tile_30_7 | tile_30_8 | tile_30_9 | 
			tile_30_10 | tile_30_11 | tile_30_12 | tile_30_14 | tile_30_15 | tile_30_17 | tile_30_18 | 
			tile_30_19 | tile_30_20 | tile_30_21 | tile_30_22 | tile_30_23 | tile_30_24 | tile_30_25 |
			tile_30_26)
				begin
					up_limit = 0;
					down_limit = 0;
					left_limit = 1;
					right_limit = 1;
				end
			if (tile_3_2 | tile_3_7 | tile_3_13 | tile_3_16 | tile_3_22 | tile_3_27 | 
			tile_4_2 | tile_4_7 | tile_4_13 | tile_4_16 | tile_4_22 | tile_4_27 | 
			tile_5_2 | tile_5_7 | tile_5_13 | tile_5_16 | tile_5_22 | tile_5_27 | 
			tile_7_2 | tile_7_7 | tile_7_10 | tile_7_19 | tile_7_22 | tile_7_27 | 
			tile_8_2 | tile_8_7 | tile_8_10 | tile_8_19 | tile_8_22 | tile_8_27 | 
			tile_10_7 | tile_10_13 | tile_10_16 | tile_10_22 | 
			tile_11_7 | tile_11_13 | tile_11_16 | tile_11_22 | 
			tile_12_7 | tile_12_22 | 
			tile_13_7 | tile_13_10 | tile_13_19 | tile_13_22 | 
			tile_14_7 | tile_14_10 | tile_14_19 | tile_14_22 | 
			tile_16_7 | tile_16_10 | tile_16_19 | tile_16_22 | 
			tile_17_7 | tile_17_10 | tile_17_19 | tile_17_22 | 
			tile_18_7 | tile_18_22 | 
			tile_19_7 | tile_19_10 | tile_19_19 | tile_19_22 | 
			tile_20_7 | tile_20_10 | tile_20_19 | tile_20_22 | 
			tile_22_2 | tile_22_7 | tile_22_13 | tile_22_16 | tile_22_22 | tile_22_27 |
			tile_23_2 | tile_23_7 | tile_23_13 | tile_23_16 | tile_23_22 | tile_23_27 |
			tile_25_4 | tile_25_7 | tile_25_10 | tile_25_19 | tile_25_22 | tile_25_25 |
			tile_26_4 | tile_26_7 | tile_26_10 | tile_26_19 | tile_26_22 | tile_26_25 |
			tile_28_2 | tile_28_13 | tile_28_16 | tile_28_27 | 
			tile_29_2 | tile_29_13 | tile_29_16 | tile_29_27)
				begin
					up_limit = 1;
					down_limit = 1;
					left_limit = 0;
					right_limit = 0;
				end	
		end
endmodule
