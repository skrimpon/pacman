module pacman_death6(in, out, clk); //ok
 input [9:0] in;
 input clk;
 output reg [8:0] out;
 
 reg  [8:0] mem [0:739];
 always @(posedge clk) out  =  mem[ in ];
 
 initial begin
	mem[  0] = 9'd27;
	mem[  1] = 9'd30;
	mem[  2] = 9'd31;
	mem[  3] = 9'd15;
	mem[  4] = 9'd15;
	mem[  5] = 9'd30;
	mem[  6] = 9'd30;
	mem[  7] = 9'd30;
	mem[  8] = 9'd31;
	mem[  9] = 9'd30;
	mem[ 10] = 9'd30;
	mem[ 11] = 9'd31;
	mem[ 12] = 9'd30;
	mem[ 13] = 9'd31;
	mem[ 14] = 9'd31;
	mem[ 15] = 9'd32;
	mem[ 16] = 9'd31;
	mem[ 17] = 9'd32;
	mem[ 18] = 9'd31;
	mem[ 19] = 9'd31;
	mem[ 20] = 9'd32;
	mem[ 21] = 9'd31;
	mem[ 22] = 9'd32;
	mem[ 23] = 9'd31;
	mem[ 24] = 9'd32;
	mem[ 25] = 9'd32;
	mem[ 26] = 9'd33;
	mem[ 27] = 9'd32;
	mem[ 28] = 9'd33;
	mem[ 29] = 9'd32;
	mem[ 30] = 9'd33;
	mem[ 31] = 9'd32;
	mem[ 32] = 9'd32;
	mem[ 33] = 9'd33;
	mem[ 34] = 9'd33;
	mem[ 35] = 9'd32;
	mem[ 36] = 9'd33;
	mem[ 37] = 9'd34;
	mem[ 38] = 9'd34;
	mem[ 39] = 9'd33;
	mem[ 40] = 9'd34;
	mem[ 41] = 9'd34;
	mem[ 42] = 9'd33;
	mem[ 43] = 9'd34;
	mem[ 44] = 9'd33;
	mem[ 45] = 9'd34;
	mem[ 46] = 9'd34;
	mem[ 47] = 9'd35;
	mem[ 48] = 9'd35;
	mem[ 49] = 9'd34;
	mem[ 50] = 9'd35;
	mem[ 51] = 9'd35;
	mem[ 52] = 9'd35;
	mem[ 53] = 9'd35;
	mem[ 54] = 9'd35;
	mem[ 55] = 9'd35;
	mem[ 56] = 9'd35;
	mem[ 57] = 9'd34;
	mem[ 58] = 9'd33;
	mem[ 59] = 9'd34;
	mem[ 60] = 9'd34;
	mem[ 61] = 9'd33;
	mem[ 62] = 9'd34;
	mem[ 63] = 9'd34;
	mem[ 64] = 9'd34;
	mem[ 65] = 9'd33;
	mem[ 66] = 9'd34;
	mem[ 67] = 9'd33;
	mem[ 68] = 9'd33;
	mem[ 69] = 9'd33;
	mem[ 70] = 9'd32;
	mem[ 71] = 9'd32;
	mem[ 72] = 9'd33;
	mem[ 73] = 9'd33;
	mem[ 74] = 9'd32;
	mem[ 75] = 9'd33;
	mem[ 76] = 9'd32;
	mem[ 77] = 9'd33;
	mem[ 78] = 9'd32;
	mem[ 79] = 9'd32;
	mem[ 80] = 9'd31;
	mem[ 81] = 9'd32;
	mem[ 82] = 9'd31;
	mem[ 83] = 9'd32;
	mem[ 84] = 9'd31;
	mem[ 85] = 9'd32;
	mem[ 86] = 9'd31;
	mem[ 87] = 9'd31;
	mem[ 88] = 9'd31;
	mem[ 89] = 9'd32;
	mem[ 90] = 9'd31;
	mem[ 91] = 9'd31;
	mem[ 92] = 9'd30;
	mem[ 93] = 9'd31;
	mem[ 94] = 9'd30;
	mem[ 95] = 9'd31;
	mem[ 96] = 9'd30;
	mem[ 97] = 9'd30;
	mem[ 98] = 9'd31;
	mem[ 99] = 9'd30;
	mem[   100] = 9'd30;
	mem[   101] = 9'd31;
	mem[   102] = 9'd30;
	mem[   103] = 9'd30;
	mem[   104] = 9'd29;
	mem[   105] = 9'd30;
	mem[   106] = 9'd29;
	mem[   107] = 9'd29;
	mem[   108] = 9'd30;
	mem[   109] = 9'd29;
	mem[   110] = 9'd30;
	mem[   111] = 9'd29;
	mem[   112] = 9'd30;
	mem[   113] = 9'd29;
	mem[   114] = 9'd30;
	mem[   115] = 9'd29;
	mem[   116] = 9'd28;
	mem[   117] = 9'd29;
	mem[   118] = 9'd28;
	mem[   119] = 9'd29;
	mem[   120] = 9'd28;
	mem[   121] = 9'd29;
	mem[   122] = 9'd28;
	mem[   123] = 9'd29;
	mem[   124] = 9'd29;
	mem[   125] = 9'd28;
	mem[   126] = 9'd29;
	mem[   127] = 9'd28;
	mem[   128] = 9'd32;
	mem[   129] = 9'd32;
	mem[   130] = 9'd33;
	mem[   131] = 9'd32;
	mem[   132] = 9'd33;
	mem[   133] = 9'd32;
	mem[   134] = 9'd33;
	mem[   135] = 9'd32;
	mem[   136] = 9'd33;
	mem[   137] = 9'd32;
	mem[   138] = 9'd32;
	mem[   139] = 9'd34;
	mem[   140] = 9'd33;
	mem[   141] = 9'd34;
	mem[   142] = 9'd34;
	mem[   143] = 9'd33;
	mem[   144] = 9'd34;
	mem[   145] = 9'd33;
	mem[   146] = 9'd34;
	mem[   147] = 9'd34;
	mem[   148] = 9'd33;
	mem[   149] = 9'd34;
	mem[   150] = 9'd35;
	mem[   151] = 9'd34;
	mem[   152] = 9'd35;
	mem[   153] = 9'd35;
	mem[   154] = 9'd35;
	mem[   155] = 9'd35;
	mem[   156] = 9'd35;
	mem[   157] = 9'd35;
	mem[   158] = 9'd35;
	mem[   159] = 9'd35;
	mem[   160] = 9'd35;
	mem[   161] = 9'd36;
	mem[   162] = 9'd36;
	mem[   163] = 9'd37;
	mem[   164] = 9'd36;
	mem[   165] = 9'd36;
	mem[   166] = 9'd36;
	mem[   167] = 9'd36;
	mem[   168] = 9'd37;
	mem[   169] = 9'd36;
	mem[   170] = 9'd36;
	mem[   171] = 9'd38;
	mem[   172] = 9'd38;
	mem[   173] = 9'd37;
	mem[   174] = 9'd38;
	mem[   175] = 9'd38;
	mem[   176] = 9'd38;
	mem[   177] = 9'd37;
	mem[   178] = 9'd38;
	mem[   179] = 9'd38;
	mem[   180] = 9'd38;
	mem[   181] = 9'd39;
	mem[   182] = 9'd40;
	mem[   183] = 9'd39;
	mem[   184] = 9'd39;
	mem[   185] = 9'd39;
	mem[   186] = 9'd40;
	mem[   187] = 9'd39;
	mem[   188] = 9'd39;
	mem[   189] = 9'd39;
	mem[   190] = 9'd38;
	mem[   191] = 9'd37;
	mem[   192] = 9'd38;
	mem[   193] = 9'd38;
	mem[   194] = 9'd37;
	mem[   195] = 9'd38;
	mem[   196] = 9'd38;
	mem[   197] = 9'd37;
	mem[   198] = 9'd38;
	mem[   199] = 9'd37;
	mem[   200] = 9'd36;
	mem[   201] = 9'd36;
	mem[   202] = 9'd37;
	mem[   203] = 9'd36;
	mem[   204] = 9'd36;
	mem[   205] = 9'd36;
	mem[   206] = 9'd37;
	mem[   207] = 9'd36;
	mem[   208] = 9'd36;
	mem[   209] = 9'd35;
	mem[   210] = 9'd35;
	mem[   211] = 9'd35;
	mem[   212] = 9'd35;
	mem[   213] = 9'd35;
	mem[   214] = 9'd35;
	mem[   215] = 9'd35;
	mem[   216] = 9'd35;
	mem[   217] = 9'd35;
	mem[   218] = 9'd34;
	mem[   219] = 9'd35;
	mem[   220] = 9'd34;
	mem[   221] = 9'd34;
	mem[   222] = 9'd33;
	mem[   223] = 9'd34;
	mem[   224] = 9'd33;
	mem[   225] = 9'd34;
	mem[   226] = 9'd34;
	mem[   227] = 9'd33;
	mem[   228] = 9'd34;
	mem[   229] = 9'd34;
	mem[   230] = 9'd33;
	mem[   231] = 9'd32;
	mem[   232] = 9'd33;
	mem[   233] = 9'd32;
	mem[   234] = 9'd33;
	mem[   235] = 9'd32;
	mem[   236] = 9'd33;
	mem[   237] = 9'd32;
	mem[   238] = 9'd33;
	mem[   239] = 9'd32;
	mem[   240] = 9'd33;
	mem[   241] = 9'd32;
	mem[   242] = 9'd32;
	mem[   243] = 9'd31;
	mem[   244] = 9'd31;
	mem[   245] = 9'd32;
	mem[   246] = 9'd31;
	mem[   247] = 9'd32;
	mem[   248] = 9'd31;
	mem[   249] = 9'd31;
	mem[   250] = 9'd32;
	mem[   251] = 9'd31;
	mem[   252] = 9'd32;
	mem[   253] = 9'd33;
	mem[   254] = 9'd34;
	mem[   255] = 9'd35;
	mem[   256] = 9'd35;
	mem[   257] = 9'd35;
	mem[   258] = 9'd35;
	mem[   259] = 9'd35;
	mem[   260] = 9'd35;
	mem[   261] = 9'd35;
	mem[   262] = 9'd35;
	mem[   263] = 9'd34;
	mem[   264] = 9'd37;
	mem[   265] = 9'd36;
	mem[   266] = 9'd36;
	mem[   267] = 9'd37;
	mem[   268] = 9'd36;
	mem[   269] = 9'd36;
	mem[   270] = 9'd36;
	mem[   271] = 9'd37;
	mem[   272] = 9'd36;
	mem[   273] = 9'd36;
	mem[   274] = 9'd37;
	mem[   275] = 9'd38;
	mem[   276] = 9'd38;
	mem[   277] = 9'd38;
	mem[   278] = 9'd37;
	mem[   279] = 9'd38;
	mem[   280] = 9'd38;
	mem[   281] = 9'd37;
	mem[   282] = 9'd38;
	mem[   283] = 9'd38;
	mem[   284] = 9'd39;
	mem[   285] = 9'd40;
	mem[   286] = 9'd39;
	mem[   287] = 9'd39;
	mem[   288] = 9'd39;
	mem[   289] = 9'd40;
	mem[   290] = 9'd39;
	mem[   291] = 9'd39;
	mem[   292] = 9'd39;
	mem[   293] = 9'd41;
	mem[   294] = 9'd41;
	mem[   295] = 9'd41;
	mem[   296] = 9'd41;
	mem[   297] = 9'd41;
	mem[   298] = 9'd41;
	mem[   299] = 9'd41;
	mem[   300] = 9'd41;
	mem[   301] = 9'd41;
	mem[   302] = 9'd43;
	mem[   303] = 9'd43;
	mem[   304] = 9'd43;
	mem[   305] = 9'd42;
	mem[   306] = 9'd43;
	mem[   307] = 9'd43;
	mem[   308] = 9'd43;
	mem[   309] = 9'd43;
	mem[   310] = 9'd42;
	mem[   311] = 9'd40;
	mem[   312] = 9'd41;
	mem[   313] = 9'd41;
	mem[   314] = 9'd41;
	mem[   315] = 9'd41;
	mem[   316] = 9'd41;
	mem[   317] = 9'd41;
	mem[   318] = 9'd41;
	mem[   319] = 9'd40;
	mem[   320] = 9'd39;
	mem[   321] = 9'd39;
	mem[   322] = 9'd40;
	mem[   323] = 9'd39;
	mem[   324] = 9'd39;
	mem[   325] = 9'd39;
	mem[   326] = 9'd40;
	mem[   327] = 9'd39;
	mem[   328] = 9'd38;
	mem[   329] = 9'd38;
	mem[   330] = 9'd38;
	mem[   331] = 9'd37;
	mem[   332] = 9'd38;
	mem[   333] = 9'd38;
	mem[   334] = 9'd37;
	mem[   335] = 9'd38;
	mem[   336] = 9'd38;
	mem[   337] = 9'd37;
	mem[   338] = 9'd37;
	mem[   339] = 9'd36;
	mem[   340] = 9'd37;
	mem[   341] = 9'd36;
	mem[   342] = 9'd36;
	mem[   343] = 9'd36;
	mem[   344] = 9'd37;
	mem[   345] = 9'd36;
	mem[   346] = 9'd36;
	mem[   347] = 9'd36;
	mem[   348] = 9'd35;
	mem[   349] = 9'd35;
	mem[   350] = 9'd35;
	mem[   351] = 9'd35;
	mem[   352] = 9'd35;
	mem[   353] = 9'd35;
	mem[   354] = 9'd35;
	mem[   355] = 9'd35;
	mem[   356] = 9'd35;
	mem[   357] = 9'd34;
	mem[   358] = 9'd35;
	mem[   359] = 9'd34;
	mem[   360] = 9'd33;
	mem[   361] = 9'd34;
	mem[   362] = 9'd34;
	mem[   363] = 9'd33;
	mem[   364] = 9'd34;
	mem[   365] = 9'd33;
	mem[   366] = 9'd34;
	mem[   367] = 9'd34;
	mem[   368] = 9'd33;
	mem[   369] = 9'd36;
	mem[   370] = 9'd38;
	mem[   371] = 9'd37;
	mem[   372] = 9'd38;
	mem[   373] = 9'd38;
	mem[   374] = 9'd37;
	mem[   375] = 9'd38;
	mem[   376] = 9'd38;
	mem[   377] = 9'd37;
	mem[   378] = 9'd38;
	mem[   379] = 9'd39;
	mem[   380] = 9'd39;
	mem[   381] = 9'd39;
	mem[   382] = 9'd40;
	mem[   383] = 9'd39;
	mem[   384] = 9'd39;
	mem[   385] = 9'd39;
	mem[   386] = 9'd40;
	mem[   387] = 9'd39;
	mem[   388] = 9'd40;
	mem[   389] = 9'd41;
	mem[   390] = 9'd41;
	mem[   391] = 9'd41;
	mem[   392] = 9'd41;
	mem[   393] = 9'd41;
	mem[   394] = 9'd41;
	mem[   395] = 9'd41;
	mem[   396] = 9'd40;
	mem[   397] = 9'd43;
	mem[   398] = 9'd43;
	mem[   399] = 9'd42;
	mem[   400] = 9'd43;
	mem[   401] = 9'd43;
	mem[   402] = 9'd43;
	mem[   403] = 9'd43;
	mem[   404] = 9'd43;
	mem[   405] = 9'd42;
	mem[   406] = 9'd45;
	mem[   407] = 9'd45;
	mem[   408] = 9'd45;
	mem[   409] = 9'd45;
	mem[   410] = 9'd45;
	mem[   411] = 9'd45;
	mem[   412] = 9'd44;
	mem[   413] = 9'd45;
	mem[   414] = 9'd47;
	mem[   415] = 9'd47;
	mem[   416] = 9'd47;
	mem[   417] = 9'd48;
	mem[   418] = 9'd47;
	mem[   419] = 9'd47;
	mem[   420] = 9'd47;
	mem[   421] = 9'd46;
	mem[   422] = 9'd45;
	mem[   423] = 9'd45;
	mem[   424] = 9'd45;
	mem[   425] = 9'd45;
	mem[   426] = 9'd45;
	mem[   427] = 9'd45;
	mem[   428] = 9'd44;
	mem[   429] = 9'd45;
	mem[   430] = 9'd43;
	mem[   431] = 9'd43;
	mem[   432] = 9'd43;
	mem[   433] = 9'd42;
	mem[   434] = 9'd43;
	mem[   435] = 9'd43;
	mem[   436] = 9'd43;
	mem[   437] = 9'd43;
	mem[   438] = 9'd41;
	mem[   439] = 9'd41;
	mem[   440] = 9'd41;
	mem[   441] = 9'd41;
	mem[   442] = 9'd41;
	mem[   443] = 9'd41;
	mem[   444] = 9'd41;
	mem[   445] = 9'd41;
	mem[   446] = 9'd41;
	mem[   447] = 9'd40;
	mem[   448] = 9'd39;
	mem[   449] = 9'd39;
	mem[   450] = 9'd40;
	mem[   451] = 9'd39;
	mem[   452] = 9'd39;
	mem[   453] = 9'd39;
	mem[   454] = 9'd40;
	mem[   455] = 9'd39;
	mem[   456] = 9'd38;
	mem[   457] = 9'd38;
	mem[   458] = 9'd38;
	mem[   459] = 9'd37;
	mem[   460] = 9'd38;
	mem[   461] = 9'd38;
	mem[   462] = 9'd37;
	mem[   463] = 9'd38;
	mem[   464] = 9'd38;
	mem[   465] = 9'd37;
	mem[   466] = 9'd37;
	mem[   467] = 9'd36;
	mem[   468] = 9'd37;
	mem[   469] = 9'd36;
	mem[   470] = 9'd36;
	mem[   471] = 9'd36;
	mem[   472] = 9'd36;
	mem[   473] = 9'd37;
	mem[   474] = 9'd36;
	mem[   475] = 9'd36;
	mem[   476] = 9'd40;
	mem[   477] = 9'd41;
	mem[   478] = 9'd41;
	mem[   479] = 9'd41;
	mem[   480] = 9'd40;
	mem[   481] = 9'd42;
	mem[   482] = 9'd40;
	mem[   483] = 9'd41;
	mem[   484] = 9'd41;
	mem[   485] = 9'd43;
	mem[   486] = 9'd43;
	mem[   487] = 9'd43;
	mem[   488] = 9'd42;
	mem[   489] = 9'd43;
	mem[   490] = 9'd43;
	mem[   491] = 9'd43;
	mem[   492] = 9'd43;
	mem[   493] = 9'd43;
	mem[   494] = 9'd45;
	mem[   495] = 9'd45;
	mem[   496] = 9'd45;
	mem[   497] = 9'd44;
	mem[   498] = 9'd45;
	mem[   499] = 9'd45;
	mem[   500] = 9'd45;
	mem[   501] = 9'd45;
	mem[   502] = 9'd47;
	mem[   503] = 9'd47;
	mem[   504] = 9'd48;
	mem[   505] = 9'd47;
	mem[   506] = 9'd47;
	mem[   507] = 9'd47;
	mem[   508] = 9'd47;
	mem[   509] = 9'd48;
	mem[   510] = 9'd50;
	mem[   511] = 9'd49;
	mem[   512] = 9'd50;
	mem[   513] = 9'd49;
	mem[   514] = 9'd50;
	mem[   515] = 9'd50;
	mem[   516] = 9'd50;
	mem[   517] = 9'd52;
	mem[   518] = 9'd52;
	mem[   519] = 9'd52;
	mem[   520] = 9'd53;
	mem[   521] = 9'd52;
	mem[   522] = 9'd52;
	mem[   523] = 9'd52;
	mem[   524] = 9'd50;
	mem[   525] = 9'd50;
	mem[   526] = 9'd49;
	mem[   527] = 9'd50;
	mem[   528] = 9'd49;
	mem[   529] = 9'd50;
	mem[   530] = 9'd50;
	mem[   531] = 9'd47;
	mem[   532] = 9'd47;
	mem[   533] = 9'd47;
	mem[   534] = 9'd47;
	mem[   535] = 9'd48;
	mem[   536] = 9'd46;
	mem[   537] = 9'd48;
	mem[   538] = 9'd47;
	mem[   539] = 9'd45;
	mem[   540] = 9'd44;
	mem[   541] = 9'd45;
	mem[   542] = 9'd45;
	mem[   543] = 9'd45;
	mem[   544] = 9'd45;
	mem[   545] = 9'd45;
	mem[   546] = 9'd45;
	mem[   547] = 9'd42;
	mem[   548] = 9'd43;
	mem[   549] = 9'd43;
	mem[   550] = 9'd43;
	mem[   551] = 9'd43;
	mem[   552] = 9'd43;
	mem[   553] = 9'd42;
	mem[   554] = 9'd43;
	mem[   555] = 9'd42;
	mem[   556] = 9'd41;
	mem[   557] = 9'd41;
	mem[   558] = 9'd41;
	mem[   559] = 9'd41;
	mem[   560] = 9'd41;
	mem[   561] = 9'd41;
	mem[   562] = 9'd41;
	mem[   563] = 9'd41;
	mem[   564] = 9'd40;
	mem[   565] = 9'd39;
	mem[   566] = 9'd39;
	mem[   567] = 9'd40;
	mem[   568] = 9'd39;
	mem[   569] = 9'd39;
	mem[   570] = 9'd40;
	mem[   571] = 9'd39;
	mem[   572] = 9'd39;
	mem[   573] = 9'd41;
	mem[   574] = 9'd44;
	mem[   575] = 9'd45;
	mem[   576] = 9'd45;
	mem[   577] = 9'd45;
	mem[   578] = 9'd45;
	mem[   579] = 9'd45;
	mem[   580] = 9'd45;
	mem[   581] = 9'd45;
	mem[   582] = 9'd47;
	mem[   583] = 9'd47;
	mem[   584] = 9'd47;
	mem[   585] = 9'd47;
	mem[   586] = 9'd47;
	mem[   587] = 9'd47;
	mem[   588] = 9'd48;
	mem[   589] = 9'd48;
	mem[   590] = 9'd49;
	mem[   591] = 9'd50;
	mem[   592] = 9'd49;
	mem[   593] = 9'd50;
	mem[   594] = 9'd49;
	mem[   595] = 9'd50;
	mem[   596] = 9'd50;
	mem[   597] = 9'd52;
	mem[   598] = 9'd52;
	mem[   599] = 9'd53;
	mem[   600] = 9'd52;
	mem[   601] = 9'd53;
	mem[   602] = 9'd52;
	mem[   603] = 9'd52;
	mem[   604] = 9'd56;
	mem[   605] = 9'd55;
	mem[   606] = 9'd56;
	mem[   607] = 9'd55;
	mem[   608] = 9'd55;
	mem[   609] = 9'd56;
	mem[   610] = 9'd57;
	mem[   611] = 9'd59;
	mem[   612] = 9'd59;
	mem[   613] = 9'd59;
	mem[   614] = 9'd59;
	mem[   615] = 9'd58;
	mem[   616] = 9'd58;
	mem[   617] = 9'd56;
	mem[   618] = 9'd55;
	mem[   619] = 9'd55;
	mem[   620] = 9'd56;
	mem[   621] = 9'd55;
	mem[   622] = 9'd56;
	mem[   623] = 9'd53;
	mem[   624] = 9'd52;
	mem[   625] = 9'd52;
	mem[   626] = 9'd53;
	mem[   627] = 9'd52;
	mem[   628] = 9'd52;
	mem[   629] = 9'd53;
	mem[   630] = 9'd413;
	mem[   631] = 9'd63;
	mem[   632] = 9'd56;
	mem[   633] = 9'd61;
	mem[   634] = 9'd57;
	mem[   635] = 9'd110;
	mem[   636] = 9'd78;
	mem[   637] = 9'd39;
	mem[   638] = 9'd38;
	mem[   639] = 9'd40;
	mem[   640] = 9'd40;
	mem[   641] = 9'd38;
	mem[   642] = 9'd40;
	mem[   643] = 9'd37;
	mem[   644] = 9'd30;
	mem[   645] = 9'd29;
	mem[   646] = 9'd59;
	mem[   647] = 9'd29;
	mem[   648] = 9'd29;
	mem[   649] = 9'd30;
	mem[   650] = 9'd30;
	mem[   651] = 9'd29;
	mem[   652] = 9'd29;
	mem[   653] = 9'd30;
	mem[   654] = 9'd29;
	mem[   655] = 9'd25;
	mem[   656] = 9'd23;
	mem[   657] = 9'd24;
	mem[   658] = 9'd23;
	mem[   659] = 9'd24;
	mem[   660] = 9'd24;
	mem[   661] = 9'd23;
	mem[   662] = 9'd24;
	mem[   663] = 9'd23;
	mem[   664] = 9'd24;
	mem[   665] = 9'd23;
	mem[   666] = 9'd24;
	mem[   667] = 9'd23;
	mem[   668] = 9'd24;
	mem[   669] = 9'd24;
	mem[   670] = 9'd22;
	mem[   671] = 9'd19;
	mem[   672] = 9'd20;
	mem[   673] = 9'd20;
	mem[   674] = 9'd58;
	mem[   675] = 9'd20;
	mem[   676] = 9'd39;
	mem[   677] = 9'd20;
	mem[   678] = 9'd20;
	mem[   679] = 9'd19;
	mem[   680] = 9'd20;
	mem[   681] = 9'd19;
	mem[   682] = 9'd20;
	mem[   683] = 9'd59;
	mem[   684] = 9'd186;
	mem[   685] = 9'd511;// 9'd2076;
	mem[   686] = 9'd383;
	mem[   687] = 9'd116;
	mem[   688] = 9'd55;
	mem[   689] = 9'd62;
	mem[   690] = 9'd51;
	mem[   691] = 9'd80;
	mem[   692] = 9'd38;
	mem[   693] = 9'd80;
	mem[   694] = 9'd38;
	mem[   695] = 9'd39;
	mem[   696] = 9'd40;
	mem[   697] = 9'd39;
	mem[   698] = 9'd29;
	mem[   699] = 9'd30;
	mem[   700] = 9'd30;
	mem[   701] = 9'd29;
	mem[   702] = 9'd29;
	mem[   703] = 9'd29;
	mem[   704] = 9'd30;
	mem[   705] = 9'd30;
	mem[   706] = 9'd29;
	mem[   707] = 9'd29;
	mem[   708] = 9'd30;
	mem[   709] = 9'd29;
	mem[   710] = 9'd26;
	mem[   711] = 9'd23;
	mem[   712] = 9'd24;
	mem[   713] = 9'd23;
	mem[   714] = 9'd24;
	mem[   715] = 9'd24;
	mem[   716] = 9'd23;
	mem[   717] = 9'd24;
	mem[   718] = 9'd23;
	mem[   719] = 9'd24;
	mem[   720] = 9'd23;
	mem[   721] = 9'd24;
	mem[   722] = 9'd23;
	mem[   723] = 9'd24;
	mem[   724] = 9'd24;
	mem[   725] = 9'd22;
	mem[   726] = 9'd20;
	mem[   727] = 9'd59;
	mem[   728] = 9'd20;
	mem[   729] = 9'd117;
	mem[   730] = 9'd20;
	mem[   731] = 9'd20;
	mem[   732] = 9'd19;
	mem[   733] = 9'd20;
	mem[   734] = 9'd19;
	mem[   735] = 9'd20;
	mem[   736] = 9'd20;
	mem[   737] = 9'd287;
	mem[   738] = 9'd511;
	mem[   739] = 9'd511;
	end
	
endmodule


