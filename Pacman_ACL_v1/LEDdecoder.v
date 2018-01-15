`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:09:15 11/07/2013 
// Design Name: 
// Module Name:    LEDdecoder 
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
module LEDdecoder(
    input [3:0] char,
    output reg [6:0] LED
    );
	always @ ( * )
		begin
			case( char )
				4'h0: LED = 7'b0000001;
				4'h1: LED = 7'b1001111;
				4'h2: LED = 7'b0010010;
				4'h3: LED = 7'b0000110;
				4'h4: LED = 7'b1001100;
				4'h5: LED = 7'b0100100;
				4'h6: LED = 7'b0100000;
				4'h7: LED = 7'b0001111;
				4'h8: LED = 7'b0000000;
				4'h9: LED = 7'b0000100;
				4'ha: LED = 7'b0001000;
				4'hb: LED = 7'b1100000;
				4'hc: LED = 7'b0110001;
				4'hd: LED = 7'b1000010;
				4'he: LED = 7'b0110000;
				4'hf: LED = 7'b0111000;
			endcase
		end

endmodule
