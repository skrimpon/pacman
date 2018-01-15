module pacman_wakka_converted(in, out, clk); //ok
	 input [8:0] in;
	 input clk;
	 output reg [9:0] out;
	 
	 reg  [9:0] mem [0:418];
	 always @(posedge clk) out  =  mem[ in ];
	 
	 initial begin
		mem[     0] = 10'd1023;// 10'd1170;    
		mem[     1] = 10'd26;    
		mem[     2] = 10'd32;    
		mem[     3] = 10'd45;    
		mem[     4] = 10'd26;    
		mem[     5] = 10'd32;    
		mem[     6] = 10'd45;    
		mem[     7] = 10'd26;    
		mem[     8] = 10'd32;    
		mem[     9] = 10'd45;    
		mem[    10] = 10'd24;    
		mem[    11] = 10'd25;    
		mem[    12] = 10'd36;    
		mem[    13] = 10'd21;    
		mem[    14] = 10'd24;    
		mem[    15] = 10'd36;    
		mem[    16] = 10'd22;    
		mem[    17] = 10'd24;    
		mem[    18] = 10'd36;    
		mem[    19] = 10'd21;    
		mem[    20] = 10'd25;    
		mem[    21] = 10'd36;    
		mem[    22] = 10'd20;    
		mem[    23] = 10'd26;    
		mem[    24] = 10'd31;    
		mem[    25] = 10'd18;    
		mem[    26] = 10'd20;    
		mem[    27] = 10'd31;    
		mem[    28] = 10'd18;    
		mem[    29] = 10'd20;    
		mem[    30] = 10'd31;    
		mem[    31] = 10'd18;    
		mem[    32] = 10'd20;    
		mem[    33] = 10'd31;    
		mem[    34] = 10'd17;    
		mem[    35] = 10'd21;    
		mem[    36] = 10'd30;    
		mem[    37] = 10'd18;    
		mem[    38] = 10'd20;    
		mem[    39] = 10'd30;    
		mem[    40] = 10'd15;    
		mem[    41] = 10'd19;    
		mem[    42] = 10'd24;    
		mem[    43] = 10'd16;    
		mem[    44] = 10'd18;    
		mem[    45] = 10'd25;    
		mem[    46] = 10'd14;    
		mem[    47] = 10'd17;    
		mem[    48] = 10'd27;    
		mem[    49] = 10'd14;    
		mem[    50] = 10'd17;    
		mem[    51] = 10'd26;    
		mem[    52] = 10'd15;    
		mem[    53] = 10'd18;    
		mem[    54] = 10'd25;    
		mem[    55] = 10'd14;    
		mem[    56] = 10'd19;    
		mem[    57] = 10'd25;    
		mem[    58] = 10'd14;    
		mem[    59] = 10'd17;    
		mem[    60] = 10'd23;    
		mem[    61] = 10'd12;    
		mem[    62] = 10'd17;    
		mem[    63] = 10'd21;    
		mem[    64] = 10'd14;    
		mem[    65] = 10'd16;    
		mem[    66] = 10'd22;    
		mem[    67] = 10'd13;    
		mem[    68] = 10'd16;    
		mem[    69] = 10'd22;    
		mem[    70] = 10'd14;    
		mem[    71] = 10'd16;    
		mem[    72] = 10'd22;    
		mem[    73] = 10'd13;    
		mem[    74] = 10'd17;    
		mem[    75] = 10'd22;    
		mem[    76] = 10'd13;    
		mem[    77] = 10'd16;    
		mem[    78] = 10'd22;    
		mem[    79] = 10'd13;    
		mem[    80] = 10'd15;    
		mem[    81] = 10'd20;    
		mem[    82] = 10'd13;    
		mem[    83] = 10'd13;    
		mem[    84] = 10'd20;    
		mem[    85] = 10'd12;    
		mem[    86] = 10'd14;    
		mem[    87] = 10'd21;    
		mem[    88] = 10'd11;    
		mem[    89] = 10'd14;    
		mem[    90] = 10'd21;    
		mem[    91] = 10'd11;    
		mem[    92] = 10'd14;    
		mem[    93] = 10'd21;    
		mem[    94] = 10'd11;    
		mem[    95] = 10'd14;    
		mem[    96] = 10'd21;    
		mem[    97] = 10'd11;    
		mem[    98] = 10'd14;    
		mem[    99] = 10'd20;    
		mem[   100] = 10'd12;    
		mem[   101] = 10'd14;    
		mem[   102] = 10'd20;    
		mem[   103] = 10'd12;    
		mem[   104] = 10'd7;    
		mem[   105] = 10'd747;    
		mem[   106] = 10'd19;    
		mem[   107] = 10'd12;    
		mem[   108] = 10'd13;    
		mem[   109] = 10'd21;    
		mem[   110] = 10'd12;    
		mem[   111] = 10'd13;    
		mem[   112] = 10'd20;    
		mem[   113] = 10'd13;    
		mem[   114] = 10'd13;    
		mem[   115] = 10'd20;    
		mem[   116] = 10'd13;    
		mem[   117] = 10'd13;    
		mem[   118] = 10'd20;    
		mem[   119] = 10'd13;    
		mem[   120] = 10'd13;    
		mem[   121] = 10'd20;    
		mem[   122] = 10'd12;    
		mem[   123] = 10'd14;    
		mem[   124] = 10'd21;    
		mem[   125] = 10'd11;    
		mem[   126] = 10'd14;    
		mem[   127] = 10'd21;    
		mem[   128] = 10'd11;    
		mem[   129] = 10'd15;    
		mem[   130] = 10'd22;    
		mem[   131] = 10'd13;    
		mem[   132] = 10'd16;    
		mem[   133] = 10'd22;    
		mem[   134] = 10'd14;    
		mem[   135] = 10'd16;    
		mem[   136] = 10'd22;    
		mem[   137] = 10'd13;    
		mem[   138] = 10'd16;    
		mem[   139] = 10'd22;    
		mem[   140] = 10'd14;    
		mem[   141] = 10'd16;    
		mem[   142] = 10'd22;    
		mem[   143] = 10'd13;    
		mem[   144] = 10'd16;    
		mem[   145] = 10'd23;    
		mem[   146] = 10'd12;    
		mem[   147] = 10'd17;    
		mem[   148] = 10'd22;    
		mem[   149] = 10'd14;    
		mem[   150] = 10'd15;    
		mem[   151] = 10'd25;    
		mem[   152] = 10'd15;    
		mem[   153] = 10'd18;    
		mem[   154] = 10'd25;    
		mem[   155] = 10'd15;    
		mem[   156] = 10'd18;    
		mem[   157] = 10'd25;    
		mem[   158] = 10'd15;    
		mem[   159] = 10'd18;    
		mem[   160] = 10'd24;    
		mem[   161] = 10'd16;    
		mem[   162] = 10'd18;    
		mem[   163] = 10'd25;    
		mem[   164] = 10'd15;    
		mem[   165] = 10'd16;    
		mem[   166] = 10'd27;    
		mem[   167] = 10'd14;    
		mem[   168] = 10'd17;    
		mem[   169] = 10'd27;    
		mem[   170] = 10'd17;    
		mem[   171] = 10'd22;    
		mem[   172] = 10'd29;    
		mem[   173] = 10'd18;    
		mem[   174] = 10'd21;    
		mem[   175] = 10'd30;    
		mem[   176] = 10'd18;    
		mem[   177] = 10'd20;    
		mem[   178] = 10'd31;    
		mem[   179] = 10'd18;    
		mem[   180] = 10'd20;    
		mem[   181] = 10'd31;    
		mem[   182] = 10'd17;    
		mem[   183] = 10'd21;    
		mem[   184] = 10'd31;    
		mem[   185] = 10'd17;    
		mem[   186] = 10'd25;    
		mem[   187] = 10'd36;    
		mem[   188] = 10'd20;    
		mem[   189] = 10'd26;    
		mem[   190] = 10'd35;    
		mem[   191] = 10'd21;    
		mem[   192] = 10'd25;    
		mem[   193] = 10'd36;    
		mem[   194] = 10'd21;    
		mem[   195] = 10'd24;    
		mem[   196] = 10'd36;    
		mem[   197] = 10'd22;    
		mem[   198] = 10'd24;    
		mem[   199] = 10'd40;    
		mem[   200] = 10'd28;    
		mem[   201] = 10'd31;    
		mem[   202] = 10'd46;    
		mem[   203] = 10'd25;    
		mem[   204] = 10'd32;    
		mem[   205] = 10'd45;    
		mem[   206] = 10'd26;    
		mem[   207] = 10'd32;    
		mem[   208] = 10'd45;    
		mem[   209] = 10'd26;    
		mem[   210] = 10'd404;    
		mem[   211] = 10'd45;    
		mem[   212] = 10'd26;    
		mem[   213] = 10'd32;    
		mem[   214] = 10'd45;    
		mem[   215] = 10'd26;    
		mem[   216] = 10'd32;    
		mem[   217] = 10'd45;    
		mem[   218] = 10'd26;    
		mem[   219] = 10'd32;    
		mem[   220] = 10'd42;    
		mem[   221] = 10'd21;    
		mem[   222] = 10'd25;    
		mem[   223] = 10'd36;    
		mem[   224] = 10'd20;    
		mem[   225] = 10'd26;    
		mem[   226] = 10'd36;    
		mem[   227] = 10'd20;    
		mem[   228] = 10'd25;    
		mem[   229] = 10'd37;    
		mem[   230] = 10'd20;    
		mem[   231] = 10'd25;    
		mem[   232] = 10'd36;    
		mem[   233] = 10'd21;    
		mem[   234] = 10'd22;    
		mem[   235] = 10'd31;    
		mem[   236] = 10'd17;    
		mem[   237] = 10'd21;    
		mem[   238] = 10'd30;    
		mem[   239] = 10'd18;    
		mem[   240] = 10'd21;    
		mem[   241] = 10'd30;    
		mem[   242] = 10'd17;    
		mem[   243] = 10'd21;    
		mem[   244] = 10'd30;    
		mem[   245] = 10'd18;    
		mem[   246] = 10'd21;    
		mem[   247] = 10'd30;    
		mem[   248] = 10'd18;    
		mem[   249] = 10'd21;    
		mem[   250] = 10'd27;    
		mem[   251] = 10'd15;    
		mem[   252] = 10'd18;    
		mem[   253] = 10'd24;    
		mem[   254] = 10'd16;    
		mem[   255] = 10'd17;    
		mem[   256] = 10'd26;    
		mem[   257] = 10'd14;    
		mem[   258] = 10'd17;    
		mem[   259] = 10'd27;    
		mem[   260] = 10'd14;    
		mem[   261] = 10'd17;    
		mem[   262] = 10'd27;    
		mem[   263] = 10'd14;    
		mem[   264] = 10'd17;    
		mem[   265] = 10'd26;    
		mem[   266] = 10'd15;    
		mem[   267] = 10'd18;    
		mem[   268] = 10'd25;    
		mem[   269] = 10'd13;    
		mem[   270] = 10'd16;    
		mem[   271] = 10'd23;    
		mem[   272] = 10'd13;    
		mem[   273] = 10'd16;    
		mem[   274] = 10'd22;    
		mem[   275] = 10'd13;    
		mem[   276] = 10'd16;    
		mem[   277] = 10'd23;    
		mem[   278] = 10'd13;    
		mem[   279] = 10'd16;    
		mem[   280] = 10'd22;    
		mem[   281] = 10'd13;    
		mem[   282] = 10'd16;    
		mem[   283] = 10'd23;    
		mem[   284] = 10'd12;    
		mem[   285] = 10'd16;    
		mem[   286] = 10'd23;    
		mem[   287] = 10'd13;    
		mem[   288] = 10'd16;    
		mem[   289] = 10'd22;    
		mem[   290] = 10'd13;    
		mem[   291] = 10'd15;    
		mem[   292] = 10'd19;    
		mem[   293] = 10'd12;    
		mem[   294] = 10'd15;    
		mem[   295] = 10'd19;    
		mem[   296] = 10'd12;    
		mem[   297] = 10'd13;    
		mem[   298] = 10'd21;    
		mem[   299] = 10'd12;    
		mem[   300] = 10'd13;    
		mem[   301] = 10'd21;    
		mem[   302] = 10'd12;    
		mem[   303] = 10'd13;    
		mem[   304] = 10'd21;    
		mem[   305] = 10'd12;    
		mem[   306] = 10'd13;    
		mem[   307] = 10'd21;    
		mem[   308] = 10'd11;    
		mem[   309] = 10'd14;    
		mem[   310] = 10'd21;    
		mem[   311] = 10'd25;    
		mem[   312] = 10'd21;    
		mem[   313] = 10'd751;    
		mem[   314] = 10'd14;    
		mem[   315] = 10'd20;    
		mem[   316] = 10'd12;    
		mem[   317] = 10'd14;    
		mem[   318] = 10'd20;    
		mem[   319] = 10'd11;    
		mem[   320] = 10'd15;    
		mem[   321] = 10'd20;    
		mem[   322] = 10'd11;    
		mem[   323] = 10'd15;    
		mem[   324] = 10'd20;    
		mem[   325] = 10'd11;    
		mem[   326] = 10'd15;    
		mem[   327] = 10'd19;    
		mem[   328] = 10'd12;    
		mem[   329] = 10'd13;    
		mem[   330] = 10'd21;    
		mem[   331] = 10'd12;    
		mem[   332] = 10'd13;    
		mem[   333] = 10'd21;    
		mem[   334] = 10'd12;    
		mem[   335] = 10'd13;    
		mem[   336] = 10'd21;    
		mem[   337] = 10'd28;    
		mem[   338] = 10'd23;    
		mem[   339] = 10'd12;    
		mem[   340] = 10'd16;    
		mem[   341] = 10'd23;    
		mem[   342] = 10'd13;    
		mem[   343] = 10'd16;    
		mem[   344] = 10'd22;    
		mem[   345] = 10'd13;    
		mem[   346] = 10'd16;    
		mem[   347] = 10'd24;    
		mem[   348] = 10'd13;    
		mem[   349] = 10'd15;    
		mem[   350] = 10'd23;    
		mem[   351] = 10'd13;    
		mem[   352] = 10'd15;    
		mem[   353] = 10'd24;    
		mem[   354] = 10'd13;    
		mem[   355] = 10'd15;    
		mem[   356] = 10'd23;    
		mem[   357] = 10'd13;    
		mem[   358] = 10'd18;    
		mem[   359] = 10'd25;    
		mem[   360] = 10'd14;    
		mem[   361] = 10'd18;    
		mem[   362] = 10'd25;    
		mem[   363] = 10'd15;    
		mem[   364] = 10'd18;    
		mem[   365] = 10'd25;    
		mem[   366] = 10'd15;    
		mem[   367] = 10'd18;    
		mem[   368] = 10'd24;    
		mem[   369] = 10'd16;    
		mem[   370] = 10'd18;    
		mem[   371] = 10'd24;    
		mem[   372] = 10'd16;    
		mem[   373] = 10'd17;    
		mem[   374] = 10'd26;    
		mem[   375] = 10'd14;    
		mem[   376] = 10'd17;    
		mem[   377] = 10'd30;    
		mem[   378] = 10'd18;    
		mem[   379] = 10'd20;    
		mem[   380] = 10'd31;    
		mem[   381] = 10'd18;    
		mem[   382] = 10'd20;    
		mem[   383] = 10'd31;    
		mem[   384] = 10'd17;    
		mem[   385] = 10'd21;    
		mem[   386] = 10'd30;    
		mem[   387] = 10'd18;    
		mem[   388] = 10'd21;    
		mem[   389] = 10'd30;    
		mem[   390] = 10'd17;    
		mem[   391] = 10'd21;    
		mem[   392] = 10'd31;    
		mem[   393] = 10'd20;    
		mem[   394] = 10'd25;    
		mem[   395] = 10'd36;    
		mem[   396] = 10'd21;    
		mem[   397] = 10'd25;    
		mem[   398] = 10'd36;    
		mem[   399] = 10'd21;    
		mem[   400] = 10'd25;    
		mem[   401] = 10'd36;    
		mem[   402] = 10'd20;    
		mem[   403] = 10'd26;    
		mem[   404] = 10'd36;    
		mem[   405] = 10'd20;    
		mem[   406] = 10'd27;    
		mem[   407] = 10'd46;    
		mem[   408] = 10'd25;    
		mem[   409] = 10'd32;    
		mem[   410] = 10'd45;    
		mem[   411] = 10'd26;    
		mem[   412] = 10'd32;    
		mem[   413] = 10'd45;    
		mem[   414] = 10'd26;    
		mem[   415] = 10'd32;    
		mem[   416] = 10'd1023; 
		mem[   418] = 10'd0; 
	end
	
endmodule

