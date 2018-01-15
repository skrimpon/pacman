`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:21:58 11/07/2013 
// Design Name: 
// Module Name:    FourDigitLEDdriver 
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
module FourDigitLEDdriver(
    input CLK,
    input RST,
	 input [4:0] h_pacman_tile,
	 input [4:0] v_pacman_tile,
    output an3,
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
    output dp
    );
	reg [3:0] digit_1;
	reg [3:0] digit [3:0];
	reg [3:0] counter;
	reg [3:0] an;
	assign dp = 1;
	assign an3 = an[3];
	assign an2 = an[2];
	assign an1 = an[1];
	assign an0 = an[0];
	
	LEDdecoder SSDdecoder(
		.char(digit_1),
		.LED({a,b,c,d,e,f,g})
		);
	
	always @ (posedge CLK or posedge RST)
		begin
			if(RST)
				begin
					counter <= 4'hf;
					digit_1 <= 0;
					an <= 4'hf;
				end
			else
				begin
					case(counter)
						4'hf:
							begin
								an <= 4'hf;
								counter <= counter - 1;
							end
						4'he:
							begin
								an <= 4'h7;
								counter <= counter - 1;
							end
						4'hd:
							begin
								an <= 4'hf;
								counter <= counter - 1;
							end
						4'hc:
							begin
								an <= 4'hf;
								counter <= counter - 1;
								digit_1 <= digit[1];
							end
						4'hb:
							begin
								an <= 4'hf;
								counter <= counter - 1;
							end
						4'ha:
							begin
								an <= 4'hb;
								counter <= counter - 1;
							end
						4'h9:
							begin
								an <= 4'hf;
								counter <= counter - 1;
							end
						4'h8:
							begin
								an <= 4'hf;
								counter <= counter - 1;
								digit_1 <= digit[2];
							end
						4'h7:
							begin
								an <= 4'hf;
								counter <= counter - 1;
							end
						4'h6:
							begin
								an <= 4'hd;
								counter <= counter - 1;
							end
						4'h5:
							begin
								an <= 4'hf;
								counter <= counter - 1;
							end
						4'h4:
							begin
								an <= 4'hf;
								counter <= counter - 1;
								digit_1 <= digit[3];
							end
						4'h3:
							begin
								an <= 4'hf;
								counter <= counter - 1;
							end
						4'h2:
							begin
								an <= 4'he;
								counter <= counter - 1;
							end
						4'h1:
							begin
								an <= 4'hf;
								counter <= counter - 1;
							end
						4'h0:
							begin
								an <= 4'hf;
								digit_1 <= digit[0];
								counter <= counter - 1;
							end
					endcase
				end
			
		end
	always @ ( * )
		begin
			if(h_pacman_tile > 29)
				begin
					digit[0] = 3;
					digit[1] = h_pacman_tile - 30;
				end
			else if(h_pacman_tile > 19)
				begin
					digit[0] = 2;
					digit[1] = h_pacman_tile - 20;
				end
			else if(h_pacman_tile > 9)
				begin
					digit[0] = 1;
					digit[1] = h_pacman_tile - 10;
				end
			else
				begin
					digit[0] = 0;
					digit[1] = h_pacman_tile;
				end
		end
	always @ ( * )
		begin
			if(v_pacman_tile > 29)
				begin
					digit[2] = 3;
					digit[3] = v_pacman_tile - 30;
				end
			else if(v_pacman_tile > 19)
				begin
					digit[2] = 2;
					digit[3] = v_pacman_tile - 20;
				end
			else if(v_pacman_tile > 9)
				begin
					digit[2] = 1;
					digit[3] = v_pacman_tile - 10;
				end
			else
				begin
					digit[2] = 0;
					digit[3] = v_pacman_tile;
				end
		end
endmodule
