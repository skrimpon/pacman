module waka_2(clk, reset,Sw_waka  ,Sw_eatghost,Sw_death,Sw_intermission,Sw_extrapac,Sw_eatfruit,Sw_wakka,Sw_intro,extrapac6_btnr,Sw_intermission2,speaker,soundEnded,anySwitch,soundStarts );	
	input clk, reset, Sw_waka ,Sw_intro ,Sw_eatghost,Sw_death,Sw_intermission,Sw_extrapac,Sw_eatfruit,Sw_wakka,extrapac6_btnr,Sw_intermission2;						
	output reg speaker,soundEnded,anySwitch,soundStarts;
	
	
	parameter sampeRatePeriod22kHz 			= 4535-1; // 4535*10ns=45.35 us  (=1/22050 samplerate hz)
	
	parameter memSize_waka				  		= 419-1; 	//173 theseis stin mem
	parameter memSize_intro						= 2154-1; 	//29897 theseis stin mem
	parameter memSize_eatghost			 		= 388-1; 	//386 theseis stin mem
	parameter memSize_death						= 740-1;
//	parameter memSize_intermission			= 2839-1;
//	parameter memSize_extrapac					= 1395-1;
	parameter memSize_eatfruit					= 123-1;
//	parameter memSize_wakka 					= 2834-1;
	parameter memSize_extrapac6				= 1097-1;
//	parameter memSize_intermission2			= 2182-1;	

	reg  [11:0] counter_in;				//shows which frequency is curently heared
	reg [12:0] counter;					//counts to sampeRatePeriod
	reg [11:0] counterForEachFreq;	//creates each frequence
	
	reg sampleRatePeriod;				//shows that period has beed counted
	reg [8:0] smouth;
	reg flag;
	
	//reg anySwitch;						//catches pulses for itro , eatfruit, pacmanDeath and ghostDeath
	//reg soundStarts;
	
	wire [11:0] out_waka,out_intro,out_eatghost,out_death,out_intermission,out_intermission2,out_extrapac,out_eatfruit,out_wakka,out_extrapac6;
	wire [11:0] out;
	wire [11:0] memSize;
	
	
	assign out=
			Sw_eatfruit					? out_eatfruit :
//			Sw_extrapac					? out_extrapac :
			Sw_death						? out_death :
			Sw_eatghost 				? out_eatghost :
//			Sw_intermission			? out_intermission :
			Sw_intro						? out_intro :
//			Sw_wakka 					? out_wakka :
			extrapac6_btnr 			? out_extrapac6 :
//			Sw_intermission2			? out_intermission2 :
			Sw_waka						? out_waka :
			0;
			
	assign memSize=
			Sw_eatfruit					? memSize_eatfruit :
//			Sw_extrapac					? memSize_extrapac :
			Sw_death						? memSize_death :
			Sw_eatghost 				? memSize_eatghost :
//			Sw_intermission			? memSize_intermission :
			Sw_intro						? memSize_intro :		
//			Sw_wakka 					? memSize_wakka :
			extrapac6_btnr 			? memSize_extrapac6 :
//			Sw_intermission2			? memSize_intermission2 :
			Sw_waka						? memSize_waka :
			0;
		
			
								/*instantiating modules*/
	pacman_death6 death (.in(counter_in[9:0]),.out(out_death),.clk(clk));
	pacman_wakka_converted wakka_converted (.in(counter_in[8:0]),.out(out_waka),.clk(clk));						
	pacman_eatghost6 eatghost (.in(counter_in[9:0]),.out(out_eatghost),.clk(clk));
	pacman_eatfruit6 eatfruit (.in(counter_in[6:0]),.out(out_eatfruit),.clk(clk));
	pacman_beginning_converted intro (.in(counter_in[11:0]),.out(out_intro),.clk(clk));
	pacman_extrapac6 extrapac6(.in(counter_in[10:0]),.out(out_extrapac6),.clk(clk));
	
//	pacman_intermission_converted intermission (.in(counter_in[11:0]),.out(out_intermission),.clk(clk));
//	pacman_extrapac_converted extrapac (.in(counter_in[10:0]),.out(out_extrapac),.clk(clk));
//	pacman_wakka wakka (.in(counter_in[11:0]),.out(out_wakka),.clk(clk));	
//	pacman_intermission_converted2 intermission2 (.in(counter_in[11:0]),.out(out_intermission2),.clk(clk));
	
	always @(posedge clk) begin
		if (reset) begin
			counter = 0;
			sampleRatePeriod=0;
			smouth=0;
		end
		else if(counter >= sampeRatePeriod22kHz )  begin
			counter = 0;
			sampleRatePeriod=1;
			smouth = smouth + 1;
		end
		else begin
			counter = counter + 1;
			sampleRatePeriod=0;
		end
	end


	always @(posedge clk) begin
		if (reset) begin
			anySwitch = 0;
			flag=1;
			soundStarts=0;
		end
		else if (Sw_intro | Sw_eatghost | Sw_death  | Sw_eatfruit | extrapac6_btnr ) begin //Sw_intermission | Sw_wakka | Sw_intermission2 | Sw_extrapac
			anySwitch = 1;
			if (flag) begin
				soundStarts=1;
				flag=0;
			end	
			else begin
				soundStarts=0;
			end
		end
		else if (soundEnded) begin
			flag = 1;
			anySwitch = 0;
		end

	end


	always @(posedge clk) begin
		if (reset) begin
			speaker = 0;
			counterForEachFreq = 0;
			counter_in = 0;
			soundEnded=0;
		end
		else if (soundStarts) begin
			counter_in = 0;
			soundEnded = 0;
			counterForEachFreq = 0;
		end
		else if(sampleRatePeriod) begin
			if (counterForEachFreq >= out) begin	
				if ( anySwitch  | Sw_waka) begin		//intermission, Sw_waka
					if (counter_in >= memSize) begin
						counter_in = 0;
						counterForEachFreq = 0;
						soundEnded = 1;
					end
					else begin
						soundEnded=0;
						counterForEachFreq = 0;
						counter_in = counter_in + 1'b1;
						if (Sw_intermission2 || Sw_intro) begin
							if(out > 10  && out <38)
								speaker = ~speaker;
						end
						else if (out != 0 && out <511)  
							speaker = ~speaker;
					end
				end
			end
			else counterForEachFreq = counterForEachFreq + 1'b1;
		end
	end	

endmodule
