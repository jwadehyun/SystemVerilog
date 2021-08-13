module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 input logic CLOCK_50;
 input logic [3:0] KEY;
 input logic [9:0] SW;
 output logic [35:0] GPIO_0;
 output logic [9:0] LEDR; 
 
 logic [7:0][7:0] red, green, green2, out;
 logic [31:0] clk;

 led_matrix_driver led (.clock(clk[15]), .red_array(red), .green_array(green), .red_driver(GPIO_0[27:20]), 
 .green_driver(GPIO_0[35:28]), .row_sink(GPIO_0[19:12]));
 
 assign HEX0 = 7'b1000110;
 assign HEX1 = 7'b1110110;
 assign HEX2 = 7'b0000110;
 assign HEX3 = 7'b0001110;
 assign HEX4 = 7'b1001111;
 assign HEX5 = 7'b1000111;
  
 
 
 always_comb begin
	if (SW[8])
		green = green2;
	else begin
		green = out;
		end
	end
	
 clock_divider (.clock(CLOCK_50), .reset(SW[8]), .divided_clocks(clk));

 initialize ini (.clk(CLOCK_50), .reset(SW[9]), .freset(SW[8]), .SW(SW[7:0]), .KEY(KEY[3:0]), .led(green2));
 
 cells cell00 (.clock(clk[23]), .freset(SW[8]), .start(green2[0][0]), .cell0(1'b0), .cell1(1'b0), .cell2(1'b0), .cell3(1'b0), .cell4(green[0][0]), .cell5(green[0][1]), .cell6(1'b0), .cell7(green[1][0]), .cell8(green[1][1]), .next(out[0][0]));
 cells cell01 (.clock(clk[23]), .freset(SW[8]), .start(green2[0][1]), .cell0(1'b0), .cell1(1'b0), .cell2(1'b0), .cell3(green[0][0]), .cell4(green[0][1]), .cell5(green[0][2]), .cell6(green[1][0]), .cell7(green[1][1]), .cell8(green[1][2]), .next(out[0][1]));
 cells cell02 (.clock(clk[23]), .freset(SW[8]), .start(green2[0][2]), .cell0(1'b0), .cell1(1'b0), .cell2(1'b0), .cell3(green[0][1]), .cell4(green[0][2]), .cell5(green[0][3]), .cell6(green[1][1]), .cell7(green[1][2]), .cell8(green[1][3]), .next(out[0][2]));
 cells cell03 (.clock(clk[23]), .freset(SW[8]), .start(green2[0][3]), .cell0(1'b0), .cell1(1'b0), .cell2(1'b0), .cell3(green[0][2]), .cell4(green[0][3]), .cell5(green[0][4]), .cell6(green[1][2]), .cell7(green[1][3]), .cell8(green[1][4]), .next(out[0][3]));
 cells cell04 (.clock(clk[23]), .freset(SW[8]), .start(green2[0][4]), .cell0(1'b0), .cell1(1'b0), .cell2(1'b0), .cell3(green[0][3]), .cell4(green[0][4]), .cell5(green[0][5]), .cell6(green[1][3]), .cell7(green[1][4]), .cell8(green[1][5]), .next(out[0][4]));
 cells cell05 (.clock(clk[23]), .freset(SW[8]), .start(green2[0][5]), .cell0(1'b0), .cell1(1'b0), .cell2(1'b0), .cell3(green[0][4]), .cell4(green[0][5]), .cell5(green[0][6]), .cell6(green[1][4]), .cell7(green[1][5]), .cell8(green[1][6]), .next(out[0][5]));
 cells cell06 (.clock(clk[23]), .freset(SW[8]), .start(green2[0][6]), .cell0(1'b0), .cell1(1'b0), .cell2(1'b0), .cell3(green[0][5]), .cell4(green[0][6]), .cell5(green[0][7]), .cell6(green[1][5]), .cell7(green[1][6]), .cell8(green[1][7]), .next(out[0][6]));
 cells cell07 (.clock(clk[23]), .freset(SW[8]), .start(green2[0][7]), .cell0(1'b0), .cell1(1'b0), .cell2(1'b0), .cell3(green[0][6]), .cell4(green[0][7]), .cell5(1'b0), .cell6(green[1][6]), .cell7(green[1][7]), .cell8(1'b0), .next(out[0][7]));

 cells cell10 (.clock(clk[23]), .freset(SW[8]), .start(green2[1][0]), .cell0(1'b0), .cell1(green[0][0]), .cell2(green[0][1]), .cell3(1'b0), .cell4(green[1][0]), .cell5(green[1][1]), .cell6(1'b0), .cell7(green[2][0]), .cell8(green[2][1]), .next(out[1][0]));
 cells cell11 (.clock(clk[23]), .freset(SW[8]), .start(green2[1][1]), .cell0(green[0][0]), .cell1(green[0][1]), .cell2(green[0][2]), .cell3(green[1][0]), .cell4(green[1][1]), .cell5(green[1][2]), .cell6(green[2][0]), .cell7(green[2][1]), .cell8(green[2][2]), .next(out[1][1]));
 cells cell12 (.clock(clk[23]), .freset(SW[8]), .start(green2[1][2]), .cell0(green[0][1]), .cell1(green[0][2]), .cell2(green[0][3]), .cell3(green[1][1]), .cell4(green[1][2]), .cell5(green[1][3]), .cell6(green[2][1]), .cell7(green[2][2]), .cell8(green[2][3]), .next(out[1][2]));
 cells cell13 (.clock(clk[23]), .freset(SW[8]), .start(green2[1][3]), .cell0(green[0][2]), .cell1(green[0][3]), .cell2(green[0][4]), .cell3(green[1][2]), .cell4(green[1][3]), .cell5(green[1][4]), .cell6(green[2][2]), .cell7(green[2][3]), .cell8(green[2][4]), .next(out[1][3]));
 cells cell14 (.clock(clk[23]), .freset(SW[8]), .start(green2[1][4]), .cell0(green[0][3]), .cell1(green[0][4]), .cell2(green[0][5]), .cell3(green[1][3]), .cell4(green[1][4]), .cell5(green[1][5]), .cell6(green[2][3]), .cell7(green[2][4]), .cell8(green[2][5]), .next(out[1][4]));
 cells cell15 (.clock(clk[23]), .freset(SW[8]), .start(green2[1][5]), .cell0(green[0][4]), .cell1(green[0][5]), .cell2(green[0][6]), .cell3(green[1][4]), .cell4(green[1][5]), .cell5(green[1][6]), .cell6(green[2][4]), .cell7(green[2][5]), .cell8(green[2][6]), .next(out[1][5]));
 cells cell16 (.clock(clk[23]), .freset(SW[8]), .start(green2[1][6]), .cell0(green[0][5]), .cell1(green[0][6]), .cell2(green[0][7]), .cell3(green[1][5]), .cell4(green[1][6]), .cell5(green[1][7]), .cell6(green[2][5]), .cell7(green[2][6]), .cell8(green[2][7]), .next(out[1][6]));
 cells cell17 (.clock(clk[23]), .freset(SW[8]), .start(green2[1][7]), .cell0(green[0][6]), .cell1(green[0][7]), .cell2(1'b0), .cell3(green[1][6]), .cell4(green[1][7]), .cell5(1'b0), .cell6(green[2][6]), .cell7(green[2][7]), .cell8(1'b0), .next(out[1][7]));

 cells cell20 (.clock(clk[23]), .freset(SW[8]), .start(green2[2][0]), .cell0(1'b0), .cell1(green[1][0]), .cell2(green[1][1]), .cell3(1'b0), .cell4(green[2][0]), .cell5(green[2][1]), .cell6(1'b0), .cell7(green[3][0]), .cell8(green[3][1]), .next(out[2][0]));
 cells cell21 (.clock(clk[23]), .freset(SW[8]), .start(green2[2][1]), .cell0(green[1][0]), .cell1(green[1][1]), .cell2(green[1][2]), .cell3(green[2][0]), .cell4(green[2][1]), .cell5(green[2][2]), .cell6(green[3][0]), .cell7(green[3][1]), .cell8(green[3][2]), .next(out[2][1]));
 cells cell22 (.clock(clk[23]), .freset(SW[8]), .start(green2[2][2]), .cell0(green[1][1]), .cell1(green[1][2]), .cell2(green[1][3]), .cell3(green[2][1]), .cell4(green[2][2]), .cell5(green[2][3]), .cell6(green[3][1]), .cell7(green[3][2]), .cell8(green[3][3]), .next(out[2][2]));
 cells cell23 (.clock(clk[23]), .freset(SW[8]), .start(green2[2][3]), .cell0(green[1][2]), .cell1(green[1][3]), .cell2(green[1][4]), .cell3(green[2][2]), .cell4(green[2][3]), .cell5(green[2][4]), .cell6(green[3][2]), .cell7(green[3][3]), .cell8(green[3][4]), .next(out[2][3]));
 cells cell24 (.clock(clk[23]), .freset(SW[8]), .start(green2[2][4]), .cell0(green[1][3]), .cell1(green[1][4]), .cell2(green[1][5]), .cell3(green[2][3]), .cell4(green[2][4]), .cell5(green[2][5]), .cell6(green[3][3]), .cell7(green[3][4]), .cell8(green[3][5]), .next(out[2][4]));
 cells cell25 (.clock(clk[23]), .freset(SW[8]), .start(green2[2][5]), .cell0(green[1][4]), .cell1(green[1][5]), .cell2(green[1][6]), .cell3(green[2][4]), .cell4(green[2][5]), .cell5(green[2][6]), .cell6(green[3][4]), .cell7(green[3][5]), .cell8(green[3][6]), .next(out[2][5]));
 cells cell26 (.clock(clk[23]), .freset(SW[8]), .start(green2[2][6]), .cell0(green[1][5]), .cell1(green[1][6]), .cell2(green[1][7]), .cell3(green[2][5]), .cell4(green[2][6]), .cell5(green[2][7]), .cell6(green[3][5]), .cell7(green[3][6]), .cell8(green[3][7]), .next(out[2][6]));
 cells cell27 (.clock(clk[23]), .freset(SW[8]), .start(green2[2][7]), .cell0(green[1][6]), .cell1(green[1][7]), .cell2(1'b0), .cell3(green[2][6]), .cell4(green[2][7]), .cell5(1'b0), .cell6(green[3][6]), .cell7(green[3][7]), .cell8(1'b0), .next(out[2][7]));
 
 cells cell30 (.clock(clk[23]), .freset(SW[8]), .start(green2[3][0]), .cell0(1'b0), .cell1(green[2][0]), .cell2(green[2][1]), .cell3(1'b0), .cell4(green[3][0]), .cell5(green[3][1]), .cell6(1'b0), .cell7(green[4][0]), .cell8(green[4][1]), .next(out[3][0]));
 cells cell31 (.clock(clk[23]), .freset(SW[8]), .start(green2[3][1]), .cell0(green[2][0]), .cell1(green[2][1]), .cell2(green[2][2]), .cell3(green[3][0]), .cell4(green[3][1]), .cell5(green[3][2]), .cell6(green[4][0]), .cell7(green[4][1]), .cell8(green[4][2]), .next(out[3][1]));
 cells cell32 (.clock(clk[23]), .freset(SW[8]), .start(green2[3][2]), .cell0(green[2][1]), .cell1(green[2][2]), .cell2(green[2][3]), .cell3(green[3][1]), .cell4(green[3][2]), .cell5(green[3][3]), .cell6(green[4][1]), .cell7(green[4][2]), .cell8(green[4][3]), .next(out[3][2]));
 cells cell33 (.clock(clk[23]), .freset(SW[8]), .start(green2[3][3]), .cell0(green[2][2]), .cell1(green[2][3]), .cell2(green[2][4]), .cell3(green[3][2]), .cell4(green[3][3]), .cell5(green[3][4]), .cell6(green[4][2]), .cell7(green[4][3]), .cell8(green[4][4]), .next(out[3][3]));
 cells cell34 (.clock(clk[23]), .freset(SW[8]), .start(green2[3][4]), .cell0(green[2][3]), .cell1(green[2][4]), .cell2(green[2][5]), .cell3(green[3][3]), .cell4(green[3][4]), .cell5(green[3][5]), .cell6(green[4][3]), .cell7(green[4][4]), .cell8(green[4][5]), .next(out[3][4]));
 cells cell35 (.clock(clk[23]), .freset(SW[8]), .start(green2[3][5]), .cell0(green[2][4]), .cell1(green[2][5]), .cell2(green[2][6]), .cell3(green[3][4]), .cell4(green[3][5]), .cell5(green[3][6]), .cell6(green[4][4]), .cell7(green[4][5]), .cell8(green[4][6]), .next(out[3][5]));
 cells cell36 (.clock(clk[23]), .freset(SW[8]), .start(green2[3][6]), .cell0(green[2][5]), .cell1(green[2][6]), .cell2(green[2][7]), .cell3(green[3][5]), .cell4(green[3][6]), .cell5(green[3][7]), .cell6(green[4][5]), .cell7(green[4][6]), .cell8(green[4][7]), .next(out[3][6]));
 cells cell37 (.clock(clk[23]), .freset(SW[8]), .start(green2[3][7]), .cell0(green[2][6]), .cell1(green[2][7]), .cell2(1'b0), .cell3(green[3][6]), .cell4(green[3][7]), .cell5(1'b0), .cell6(green[4][6]), .cell7(green[4][7]), .cell8(1'b0), .next(out[3][7]));

 cells cell40 (.clock(clk[23]), .freset(SW[8]), .start(green2[4][0]), .cell0(1'b0), .cell1(green[3][0]), .cell2(green[3][1]), .cell3(1'b0), .cell4(green[4][0]), .cell5(green[4][1]), .cell6(1'b0), .cell7(green[5][0]), .cell8(green[5][1]), .next(out[4][0]));
 cells cell41 (.clock(clk[23]), .freset(SW[8]), .start(green2[4][1]), .cell0(green[3][0]), .cell1(green[3][1]), .cell2(green[3][2]), .cell3(green[4][0]), .cell4(green[4][1]), .cell5(green[4][2]), .cell6(green[5][0]), .cell7(green[5][1]), .cell8(green[5][2]), .next(out[4][1]));
 cells cell42 (.clock(clk[23]), .freset(SW[8]), .start(green2[4][2]), .cell0(green[3][1]), .cell1(green[3][2]), .cell2(green[3][3]), .cell3(green[4][1]), .cell4(green[4][2]), .cell5(green[4][3]), .cell6(green[5][1]), .cell7(green[5][2]), .cell8(green[5][3]), .next(out[4][2]));
 cells cell43 (.clock(clk[23]), .freset(SW[8]), .start(green2[4][3]), .cell0(green[3][2]), .cell1(green[3][3]), .cell2(green[3][4]), .cell3(green[4][2]), .cell4(green[4][3]), .cell5(green[4][4]), .cell6(green[5][2]), .cell7(green[5][3]), .cell8(green[5][4]), .next(out[4][3]));
 cells cell44 (.clock(clk[23]), .freset(SW[8]), .start(green2[4][4]), .cell0(green[3][3]), .cell1(green[3][4]), .cell2(green[3][5]), .cell3(green[4][3]), .cell4(green[4][4]), .cell5(green[4][5]), .cell6(green[5][3]), .cell7(green[5][4]), .cell8(green[5][5]), .next(out[4][4]));
 cells cell45 (.clock(clk[23]), .freset(SW[8]), .start(green2[4][5]), .cell0(green[3][4]), .cell1(green[3][5]), .cell2(green[3][6]), .cell3(green[4][4]), .cell4(green[4][5]), .cell5(green[4][6]), .cell6(green[5][4]), .cell7(green[5][5]), .cell8(green[5][6]), .next(out[4][5]));
 cells cell46 (.clock(clk[23]), .freset(SW[8]), .start(green2[4][6]), .cell0(green[3][5]), .cell1(green[3][6]), .cell2(green[3][7]), .cell3(green[4][5]), .cell4(green[4][6]), .cell5(green[4][7]), .cell6(green[5][5]), .cell7(green[5][6]), .cell8(green[5][7]), .next(out[4][6]));
 cells cell47 (.clock(clk[23]), .freset(SW[8]), .start(green2[4][7]), .cell0(green[3][6]), .cell1(green[3][7]), .cell2(1'b0), .cell3(green[4][6]), .cell4(green[4][7]), .cell5(1'b0), .cell6(green[5][6]), .cell7(green[5][7]), .cell8(1'b0), .next(out[4][7]));
 
 cells cell50 (.clock(clk[23]), .freset(SW[8]), .start(green2[5][0]), .cell0(1'b0), .cell1(green[4][0]), .cell2(green[4][1]), .cell3(1'b0), .cell4(green[5][0]), .cell5(green[5][1]), .cell6(1'b0), .cell7(green[6][0]), .cell8(green[6][1]), .next(out[5][0]));
 cells cell51 (.clock(clk[23]), .freset(SW[8]), .start(green2[5][1]), .cell0(green[4][0]), .cell1(green[4][1]), .cell2(green[4][2]), .cell3(green[5][0]), .cell4(green[5][1]), .cell5(green[5][2]), .cell6(green[6][0]), .cell7(green[6][1]), .cell8(green[6][2]), .next(out[5][1]));
 cells cell52 (.clock(clk[23]), .freset(SW[8]), .start(green2[5][2]), .cell0(green[4][1]), .cell1(green[4][2]), .cell2(green[4][3]), .cell3(green[5][1]), .cell4(green[5][2]), .cell5(green[5][3]), .cell6(green[6][1]), .cell7(green[6][2]), .cell8(green[6][3]), .next(out[5][2]));
 cells cell53 (.clock(clk[23]), .freset(SW[8]), .start(green2[5][3]), .cell0(green[4][2]), .cell1(green[4][3]), .cell2(green[4][4]), .cell3(green[5][2]), .cell4(green[5][3]), .cell5(green[5][4]), .cell6(green[6][2]), .cell7(green[6][3]), .cell8(green[6][4]), .next(out[5][3]));
 cells cell54 (.clock(clk[23]), .freset(SW[8]), .start(green2[5][4]), .cell0(green[4][3]), .cell1(green[4][4]), .cell2(green[4][5]), .cell3(green[5][3]), .cell4(green[5][4]), .cell5(green[5][5]), .cell6(green[6][3]), .cell7(green[6][4]), .cell8(green[6][5]), .next(out[5][4]));
 cells cell55 (.clock(clk[23]), .freset(SW[8]), .start(green2[5][5]), .cell0(green[4][4]), .cell1(green[4][5]), .cell2(green[4][6]), .cell3(green[5][4]), .cell4(green[5][5]), .cell5(green[5][6]), .cell6(green[6][4]), .cell7(green[6][5]), .cell8(green[6][6]), .next(out[5][5]));
 cells cell56 (.clock(clk[23]), .freset(SW[8]), .start(green2[5][6]), .cell0(green[4][5]), .cell1(green[4][6]), .cell2(green[4][7]), .cell3(green[5][5]), .cell4(green[5][6]), .cell5(green[5][7]), .cell6(green[6][5]), .cell7(green[6][6]), .cell8(green[6][7]), .next(out[5][6]));
 cells cell57 (.clock(clk[23]), .freset(SW[8]), .start(green2[5][7]), .cell0(green[4][6]), .cell1(green[4][7]), .cell2(1'b0), .cell3(green[5][6]), .cell4(green[5][7]), .cell5(1'b0), .cell6(green[6][6]), .cell7(green[6][7]), .cell8(1'b0), .next(out[5][7]));

 cells cell60 (.clock(clk[23]), .freset(SW[8]), .start(green2[6][0]), .cell0(1'b0), .cell1(green[5][0]), .cell2(green[5][1]), .cell3(1'b0), .cell4(green[6][0]), .cell5(green[6][1]), .cell6(1'b0), .cell7(green[7][0]), .cell8(green[7][1]), .next(out[6][0]));
 cells cell61 (.clock(clk[23]), .freset(SW[8]), .start(green2[6][1]), .cell0(green[5][0]), .cell1(green[5][1]), .cell2(green[5][2]), .cell3(green[6][0]), .cell4(green[6][1]), .cell5(green[6][2]), .cell6(green[7][0]), .cell7(green[7][1]), .cell8(green[7][2]), .next(out[6][1]));
 cells cell62 (.clock(clk[23]), .freset(SW[8]), .start(green2[6][2]), .cell0(green[5][1]), .cell1(green[5][2]), .cell2(green[5][3]), .cell3(green[6][1]), .cell4(green[6][2]), .cell5(green[6][3]), .cell6(green[7][1]), .cell7(green[7][2]), .cell8(green[7][3]), .next(out[6][2]));
 cells cell63 (.clock(clk[23]), .freset(SW[8]), .start(green2[6][3]), .cell0(green[5][2]), .cell1(green[5][3]), .cell2(green[5][4]), .cell3(green[6][2]), .cell4(green[6][3]), .cell5(green[6][4]), .cell6(green[7][2]), .cell7(green[7][3]), .cell8(green[7][4]), .next(out[6][3]));
 cells cell64 (.clock(clk[23]), .freset(SW[8]), .start(green2[6][4]), .cell0(green[5][3]), .cell1(green[5][4]), .cell2(green[5][5]), .cell3(green[6][3]), .cell4(green[6][4]), .cell5(green[6][5]), .cell6(green[7][3]), .cell7(green[7][4]), .cell8(green[7][5]), .next(out[6][4]));
 cells cell65 (.clock(clk[23]), .freset(SW[8]), .start(green2[6][5]), .cell0(green[5][4]), .cell1(green[5][5]), .cell2(green[5][6]), .cell3(green[6][4]), .cell4(green[6][5]), .cell5(green[6][6]), .cell6(green[7][4]), .cell7(green[7][5]), .cell8(green[7][6]), .next(out[6][5]));
 cells cell66 (.clock(clk[23]), .freset(SW[8]), .start(green2[6][6]), .cell0(green[5][5]), .cell1(green[5][6]), .cell2(green[5][7]), .cell3(green[6][5]), .cell4(green[6][6]), .cell5(green[6][7]), .cell6(green[7][5]), .cell7(green[7][6]), .cell8(green[7][7]), .next(out[6][6]));
 cells cell67 (.clock(clk[23]), .freset(SW[8]), .start(green2[6][7]), .cell0(green[5][6]), .cell1(green[5][7]), .cell2(1'b0), .cell3(green[6][6]), .cell4(green[6][7]), .cell5(1'b0), .cell6(green[7][6]), .cell7(green[7][7]), .cell8(1'b0), .next(out[6][7]));

 cells cell70 (.clock(clk[23]), .freset(SW[8]), .start(green2[7][0]), .cell0(1'b0), .cell1(green[6][0]), .cell2(green[6][1]), .cell3(1'b0), .cell4(green[7][0]), .cell5(green[7][1]), .cell6(1'b0), .cell7(1'b0), .cell8(1'b0), .next(out[7][0]));
 cells cell71 (.clock(clk[23]), .freset(SW[8]), .start(green2[7][1]), .cell0(green[6][0]), .cell1(green[6][1]), .cell2(green[6][2]), .cell3(green[7][0]), .cell4(green[7][1]), .cell5(green[7][2]), .cell6(1'b0), .cell7(1'b0), .cell8(1'b0), .next(out[7][1]));
 cells cell72 (.clock(clk[23]), .freset(SW[8]), .start(green2[7][2]), .cell0(green[6][1]), .cell1(green[6][2]), .cell2(green[6][3]), .cell3(green[7][1]), .cell4(green[7][2]), .cell5(green[7][3]), .cell6(1'b0), .cell7(1'b0), .cell8(1'b0), .next(out[7][2]));
 cells cell73 (.clock(clk[23]), .freset(SW[8]), .start(green2[7][3]), .cell0(green[6][2]), .cell1(green[6][3]), .cell2(green[6][4]), .cell3(green[7][2]), .cell4(green[7][3]), .cell5(green[7][4]), .cell6(1'b0), .cell7(1'b0), .cell8(1'b0), .next(out[7][3]));
 cells cell74 (.clock(clk[23]), .freset(SW[8]), .start(green2[7][4]), .cell0(green[6][3]), .cell1(green[6][4]), .cell2(green[6][5]), .cell3(green[7][3]), .cell4(green[7][4]), .cell5(green[7][5]), .cell6(1'b0), .cell7(1'b0), .cell8(1'b0), .next(out[7][4]));
 cells cell75 (.clock(clk[23]), .freset(SW[8]), .start(green2[7][5]), .cell0(green[6][4]), .cell1(green[6][5]), .cell2(green[6][6]), .cell3(green[7][4]), .cell4(green[7][5]), .cell5(green[7][6]), .cell6(1'b0), .cell7(1'b0), .cell8(1'b0), .next(out[7][5]));
 cells cell76 (.clock(clk[23]), .freset(SW[8]), .start(green2[7][6]), .cell0(green[6][5]), .cell1(green[6][6]), .cell2(green[6][7]), .cell3(green[7][5]), .cell4(green[7][6]), .cell5(green[7][7]), .cell6(1'b0), .cell7(1'b0), .cell8(1'b0), .next(out[7][6]));
 cells cell77 (.clock(clk[23]), .freset(SW[8]), .start(green2[7][7]), .cell0(green[6][6]), .cell1(green[6][7]), .cell2(1'b0), .cell3(green[7][6]), .cell4(green[7][7]), .cell5(1'b0), .cell6(1'b0), .cell7(1'b0), .cell8(1'b0), .next(out[7][7]));

endmodule

module clock_divider (clock, reset, divided_clocks);
 input logic reset, clock;
 output logic [31:0] divided_clocks = 0;

 always_ff @(posedge clock) begin
 divided_clocks <= divided_clocks + 1;
 end

endmodule 


module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic clk;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic [35:0] GPIO_0;
	logic [9:0] LEDR;
	
	DE1_SoC dut (.CLOCK_50(clk), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .GPIO_0);
		

	parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end
		
	integer i;
	initial begin
	SW[9] <= 1; @(posedge clk);
	SW[9] <= 0;
	//start modifying
	SW[8] <= 1; @(posedge clk);
	
	SW[7] <= 1; @(posedge clk);
	SW[6] <= 1; @(posedge clk);
	SW[5] <= 1; @(posedge clk);
	SW[4] <= 1; @(posedge clk);
	SW[3] <= 1; @(posedge clk);
	SW[2] <= 1; @(posedge clk);
	SW[1] <= 1; @(posedge clk);
	
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0; 
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; 
	KEY[2] <= 1; @(posedge clk);
	KEY[2] <= 0; 
	KEY[3] <= 1; @(posedge clk);
	KEY[3] <= 0; 
	
	SW[6] <= 0; @(posedge clk);
	SW[4] <= 0; @(posedge clk);
	SW[2] <= 0; @(posedge clk);
	
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0; 
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0; 
	KEY[2] <= 1; @(posedge clk);
	KEY[2] <= 0; 
	KEY[3] <= 1; @(posedge clk);
	KEY[3] <= 0; 
	
	SW[7] <= 0; @(posedge clk);
	SW[5] <= 0; @(posedge clk);
	SW[3] <= 0; @(posedge clk);
	SW[1] <= 0; @(posedge clk);
	
	SW[8] <= 0; @(posedge clk); 
	
	
	//case 2
	SW[9] <= 1; @(posedge clk);
	SW[9] <= 0;
	//start modifying
	SW[8] <= 1; @(posedge clk);
	
	SW[7] <= 1; @(posedge clk);
	SW[6] <= 1; @(posedge clk);
	SW[5] <= 1; @(posedge clk);
	SW[4] <= 1; @(posedge clk);
	SW[3] <= 1; @(posedge clk);
	SW[2] <= 1; @(posedge clk);
	SW[1] <= 1; @(posedge clk);
	
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0;
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0;
	KEY[1] <= 1; @(posedge clk);
	KEY[1] <= 0;
	
	KEY[2] <= 1; @(posedge clk);
	KEY[2] <= 0; 
	KEY[2] <= 1; @(posedge clk);
	KEY[2] <= 0;
	KEY[2] <= 1; @(posedge clk);
	KEY[2] <= 0;
	
	KEY[3] <= 1; @(posedge clk);
	KEY[3] <= 0; 
	KEY[3] <= 1; @(posedge clk);
	KEY[3] <= 0; 
	KEY[3] <= 1; @(posedge clk);
	KEY[3] <= 0; 
	KEY[3] <= 1; @(posedge clk);
	KEY[3] <= 0;

	SW[7] <= 0; @(posedge clk);
	SW[6] <= 0; @(posedge clk);
	SW[5] <= 0; @(posedge clk);
	SW[4] <= 0; @(posedge clk);
	SW[3] <= 0; @(posedge clk);
	SW[2] <= 0; @(posedge clk);
	SW[1] <= 0; @(posedge clk);
	
	SW[8] <= 0; @(posedge clk);
	
	SW[9] <= 1; @(posedge clk);
	SW[9] <= 0;
	
	SW[8] <= 0; @(posedge clk);
	
	SW[6] <= 1; @(posedge clk);
	SW[4] <= 1; @(posedge clk);
	SW[2] <= 1; @(posedge clk);
	
	KEY[2] <= 1; @(posedge clk);
	KEY[2] <= 0; 
	KEY[2] <= 1; @(posedge clk);
	KEY[2] <= 0;
	KEY[2] <= 1; @(posedge clk);
	KEY[2] <= 0;
	
	SW[6] <= 0; @(posedge clk);
	SW[4] <= 0; @(posedge clk);
	
	KEY[3] <= 1; @(posedge clk);
	KEY[3] <= 0; 
	KEY[3] <= 1; @(posedge clk);
	KEY[3] <= 0;
	
	SW[2] <= 0; @(posedge clk);
	
	SW[8] <= 0; @(posedge clk); 
	
	$stop; 
	 
	 end
	
endmodule


