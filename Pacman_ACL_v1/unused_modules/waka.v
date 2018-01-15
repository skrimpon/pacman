module waka(clk, reset,Sw_waka  ,Sw_eatghost,Sw_death,Sw_intermission,Sw_extrapac,Sw_eatfruit,Sw_wakka,Sw_intro,extrapac6_btnr,Sw_intermission2,speaker,soundEnded,anySwitch,soundStarts );	
	input clk, reset, Sw_waka ,Sw_intro ,Sw_eatghost,Sw_death,Sw_intermission,Sw_extrapac,Sw_eatfruit,Sw_wakka,extrapac6_btnr,Sw_intermission2;						
	output reg speaker,soundEnded,anySwitch,soundStarts;
	
	parameter sampeRatePeriod22kHz 			= 4535-1; // 4535*10ns=45.35 us  (=1/22050 samplerate hz)
//	parameter sampeRatePeriod44kHz 			= 2268-1;
	
	parameter memSize_waka				  		= 419-1; 	//173 theseis stin mem
	parameter memSize_intro						= 2154-1; 	//29897 theseis stin mem
	parameter memSize_eatghost			 		= 388-1; 	//386 theseis stin mem
	parameter memSize_death						= 740-1;
	parameter memSize_intermission			= 2839-1;
	parameter memSize_extrapac					= 1395-1;
	parameter memSize_eatfruit					= 123-1;
	parameter memSize_wakka 					= 2834-1;
	parameter memSize_extrapac6				= 1097-1;
	parameter memSize_intermission2			= 2182-1;	

	reg  [11:0] counter_in;				//shows which frequency is curently heared
	reg [12:0] counter;					//counts to sampeRatePeriod
	reg [11:0] counterForEachFreq;	//creates each frequence
	
	reg sampleRatePeriod;				//shows that period has beed counted
	reg [8:0] smouth;
	
//	reg anySwitch;						//catches pulses for itro , eatfruit, pacmanDeath and ghostDeath
//reg soundStarts;
	
	reg Sw_waka_flag, Sw_intro_flag, Sw_eatghost_flag, Sw_death_flag, Sw_intermission_flag,
		Sw_extrapac_flag, Sw_eatfruit_flag, Sw_wakka_flag, extrapac6_btnr_flag, Sw_intermission2_flag;						

	reg [1:0] intermissionTimes;
	
	wire [11:0] out_waka,out_intro,out_eatghost,out_death,out_intermission,out_intermission2,out_extrapac,out_eatfruit,out_wakka,out_extrapac6;
	wire [11:0] out;
	wire [11:0] memSize;
	
/*	
	assign out=
			Sw_waka						? out_waka :
			Sw_eatfruit					? out_eatfruit :
			Sw_extrapac					? out_extrapac :
			Sw_death						? out_death :
			Sw_eatghost 				? out_eatghost :
			Sw_intermission			? out_intermission :
			Sw_intro						? out_intro :
			
			Sw_wakka 					? out_wakka :
			extrapac6_btnr 			? out_extrapac6 :
			Sw_intermission2			? out_intermission2 :
			0;
			
	assign memSize=
			Sw_waka						? memSize_waka :
			Sw_eatfruit					? memSize_eatfruit :
			Sw_extrapac					? memSize_extrapac :
			Sw_death						? memSize_death :
			Sw_eatghost 				? memSize_eatghost :
			Sw_intermission			? memSize_intermission :
			Sw_intro						? memSize_intro :
			
			Sw_wakka 					? memSize_wakka :
			extrapac6_btnr 			? memSize_extrapac6 :
			Sw_intermission2			? memSize_intermission2 :
			0;
*/			
			
								/*instantiating modules*/
	pacman_death6 death (.in(counter_in[9:0]),.out(out_death),.clk(clk));
	pacman_wakka_converted wakka_converted (.in(counter_in[8:0]),.out(out_waka),.clk(clk));						
	pacman_eatghost6 eatghost (.in(counter_in[9:0]),.out(out_eatghost),.clk(clk));
	pacman_eatfruit6 eatfruit (.in(counter_in[6:0]),.out(out_eatfruit),.clk(clk));
//	pacman_intermission_converted intermission (.in(counter_in[11:0]),.out(out_intermission),.clk(clk));
//	pacman_extrapac_converted extrapac (.in(counter_in[10:0]),.out(out_extrapac),.clk(clk));
	pacman_beginning_converted intro (.in(counter_in[11:0]),.out(out_intro),.clk(clk));
	
	pacman_extrapac6 extrapac6(.in(counter_in[10:0]),.out(out_extrapac6),.clk(clk));
//	pacman_wakka wakka (.in(counter_in[11:0]),.out(out_wakka),.clk(clk));	
//	pacman_intermission_converted2 intermission2 (.in(counter_in[11:0]),.out(out_intermission2),.clk(clk));
	
	
		
	assign out=
			Sw_eatfruit_flag				? out_eatfruit :
			Sw_extrapac_flag				? out_extrapac :
			Sw_death_flag					? out_death :
			Sw_eatghost_flag 				? out_eatghost :
			Sw_intermission_flag			? out_intermission :
			Sw_intro_flag					? out_intro :
			
			Sw_wakka_flag 					? out_wakka :
			extrapac6_btnr_flag 			? out_extrapac6 :
			Sw_intermission2_flag		? out_intermission2 :
			Sw_waka_flag					? out_waka :
			0;
			
	assign memSize=
			Sw_eatfruit_flag				? memSize_eatfruit :
			Sw_extrapac_flag				? memSize_extrapac :
			Sw_death_flag					? memSize_death :
			Sw_eatghost_flag 				? memSize_eatghost :
			Sw_intermission_flag			? memSize_intermission :
			Sw_intro_flag					? memSize_intro :
			
			Sw_wakka_flag 					? memSize_wakka :
			extrapac6_btnr_flag 			? memSize_extrapac6 :
			Sw_intermission2_flag		? memSize_intermission2 :
			Sw_waka_flag					? memSize_waka :
			0;
		
	


	reg [11:0] out2;
	always @(posedge clk) begin
		if (reset) 
			out2=12'd0;
		else	if(Sw_wakka) begin//intermission
			if (out2>out) begin
				if(smouth[3])
					out2 = out2 - 12'b1;
			end
			else if (out2<out) begin
				if(smouth[3])
					out2 = out2 + 12'b1;
			end
		end
		else if (Sw_intermission2_flag ) begin//intro
			if (out2>out) begin
				if(smouth[1])
					out2 = out2 - 12'b1;
			end
			else if (out2<out) begin
				if(smouth[1])
					out2 = out2 + 12'b1;
			end
		end
		else out2=out;
	end	

	
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
			anySwitch <= 0;
			soundStarts <= 0;
		end
		else if (Sw_intermission | Sw_wakka)
			anySwitch <= 1;
		else if (Sw_intro | Sw_eatghost | Sw_death  | Sw_extrapac | Sw_eatfruit | extrapac6_btnr | Sw_intermission2 ) begin
			soundStarts <= 1;
			anySwitch <= 1;
		end
		else if(soundEnded) begin
			anySwitch  <= 0;
		end
		else soundStarts <= 0; 
	end

	always @(posedge clk) begin
		if (reset) begin
			Sw_waka_flag				<=0;			
			Sw_eatfruit_flag			<=0;		
			Sw_extrapac_flag			<=0;	
			Sw_death_flag				<=0;	
			Sw_eatghost_flag 			<=0;	
			Sw_intermission_flag		<=0;	
			Sw_intro_flag				<=0;
			Sw_wakka_flag 				<=0;	
			extrapac6_btnr_flag 		<=0;	
			Sw_intermission2_flag	<=0;	
		end
		else if(Sw_eatfruit		)begin	
			Sw_waka_flag				<=0;			
			Sw_eatfruit_flag			<=1;		
			Sw_extrapac_flag			<=0;	
			Sw_death_flag				<=0;	
			Sw_eatghost_flag 			<=0;	
			Sw_intermission_flag		<=0;	
			Sw_intro_flag				<=0;
			Sw_wakka_flag 				<=0;	
			extrapac6_btnr_flag 		<=0;	
			Sw_intermission2_flag	<=0;
		end
		else if(Sw_extrapac		)begin
			Sw_waka_flag				<=0;			
			Sw_eatfruit_flag			<=0;		
			Sw_extrapac_flag			<=1;	
			Sw_death_flag				<=0;	
			Sw_eatghost_flag 			<=0;	
			Sw_intermission_flag		<=0;	
			Sw_intro_flag				<=0;
			Sw_wakka_flag 				<=0;	
			extrapac6_btnr_flag 		<=0;	
			Sw_intermission2_flag	<=0;
		end
		else if(Sw_death			)begin
			Sw_waka_flag				<=0;			
			Sw_eatfruit_flag			<=0;		
			Sw_extrapac_flag			<=0;	
			Sw_death_flag				<=1;	
			Sw_eatghost_flag 			<=0;	
			Sw_intermission_flag		<=0;	
			Sw_intro_flag				<=0;
			Sw_wakka_flag 				<=0;	
			extrapac6_btnr_flag 		<=0;	
			Sw_intermission2_flag	<=0;
		end
		else if(Sw_eatghost 	)	begin
			Sw_waka_flag				<=0;			
			Sw_eatfruit_flag			<=0;		
			Sw_extrapac_flag			<=0;	
			Sw_death_flag				<=0;	
			Sw_eatghost_flag 			<=1;	
			Sw_intermission_flag		<=0;	
			Sw_intro_flag				<=0;
			Sw_wakka_flag 				<=0;	
			extrapac6_btnr_flag 		<=0;	
			Sw_intermission2_flag	<=0;
		end
		else if(Sw_intermission)begin
			Sw_waka_flag				<=0;			
			Sw_eatfruit_flag			<=0;		
			Sw_extrapac_flag			<=0;	
			Sw_death_flag				<=0;	
			Sw_eatghost_flag 			<=0;	
			Sw_intermission_flag		<=1;	
			Sw_intro_flag				<=0;
			Sw_wakka_flag 				<=0;	
			extrapac6_btnr_flag 		<=0;	
			Sw_intermission2_flag	<=0;
		end
		else if(Sw_intro			)begin
			Sw_waka_flag				<=0;			
			Sw_eatfruit_flag			<=0;		
			Sw_extrapac_flag			<=0;	
			Sw_death_flag				<=0;	
			Sw_eatghost_flag 			<=0;	
			Sw_intermission_flag		<=0;	
			Sw_intro_flag				<=1;
			Sw_wakka_flag 				<=0;	
			extrapac6_btnr_flag 		<=0;	
			Sw_intermission2_flag	<=0;
		end
		else if(Sw_wakka 		)	begin
			Sw_waka_flag				<=0;			
			Sw_eatfruit_flag			<=0;		
			Sw_extrapac_flag			<=0;	
			Sw_death_flag				<=0;	
			Sw_eatghost_flag 			<=0;	
			Sw_intermission_flag		<=0;	
			Sw_intro_flag				<=0;
			Sw_wakka_flag 				<=1;	
			extrapac6_btnr_flag 		<=0;	
			Sw_intermission2_flag	<=0;
		end
		else if(extrapac6_btnr )begin
			Sw_waka_flag				<=0;			
			Sw_eatfruit_flag			<=0;		
			Sw_extrapac_flag			<=0;	
			Sw_death_flag				<=0;	
			Sw_eatghost_flag 			<=0;	
			Sw_intermission_flag		<=0;	
			Sw_intro_flag				<=0;
			Sw_wakka_flag 				<=0;	
			extrapac6_btnr_flag 		<=1;	
			Sw_intermission2_flag	<=0;
		end
		else if(Sw_intermission2)begin
			Sw_waka_flag				<=0;			
			Sw_eatfruit_flag			<=0;		
			Sw_extrapac_flag			<=0;	
			Sw_death_flag				<=0;	
			Sw_eatghost_flag 			<=0;	
			Sw_intermission_flag		<=0;	
			Sw_intro_flag				<=0;
			Sw_wakka_flag 				<=0;	
			extrapac6_btnr_flag 		<=0;	
			Sw_intermission2_flag	<=1;
		end
		else if(Sw_waka			)	begin		
			Sw_waka_flag				<=1;			
			Sw_eatfruit_flag			<=0;		
			Sw_extrapac_flag			<=0;	
			Sw_death_flag				<=0;	
			Sw_eatghost_flag 			<=0;	
			Sw_intermission_flag		<=0;	
			Sw_intro_flag				<=0;
			Sw_wakka_flag 				<=0;	
			extrapac6_btnr_flag 		<=0;	
			Sw_intermission2_flag	<=0;
		end
	end		



	always @(posedge clk) begin
		if (reset) begin
			speaker = 0;
			counterForEachFreq = 0;
			counter_in = 0;
			soundEnded=0;
			intermissionTimes=0;
		end
		else if (soundStarts) begin
			counter_in = 0;
			soundEnded = 0;
			counterForEachFreq = 0;
			intermissionTimes=0;
		end
		else if(sampleRatePeriod) begin
			if (counterForEachFreq >= out2) begin	
				if (((Sw_intermission | Sw_wakka) && anySwitch)  | Sw_waka) begin		//intermission, Sw_waka
					if (counter_in >= memSize) begin
						counter_in = 0;
						counterForEachFreq = 0;
						if(Sw_intermission | Sw_wakka) begin
							if(intermissionTimes==2'd3)
								soundEnded=1;
							else 
								soundEnded=0;
							intermissionTimes=intermissionTimes+1;
						end
						else 
							intermissionTimes=0;
					end	
					else begin
						soundEnded=0;
						counterForEachFreq = 0;
						counter_in = counter_in + 1'b1;
						if(Sw_intermission_flag | Sw_wakka_flag) begin
							if(out2 > 19  && out2 <63  )
								speaker = ~speaker;
						end
						else if (out2 != 0 && out2 <511 && Sw_waka_flag)  
							speaker = ~speaker;
					end
				end
				else if (anySwitch) begin
					if (counter_in >= memSize) begin
						soundEnded=1;
						counter_in = 0;
						counterForEachFreq = 0;
					end
					else begin
						soundEnded=0;
						counterForEachFreq = 0;
						counter_in = counter_in + 1'b1;
						if (Sw_intermission2_flag || Sw_intro_flag) begin
							if(out2 > 10  && out2 <38)
								speaker = ~speaker;
						end
						else if (out2 != 0 && out2 <511)  
							speaker = ~speaker;
					end
				end
			end
			else counterForEachFreq = counterForEachFreq + 1'b1;
		end
	end

endmodule
