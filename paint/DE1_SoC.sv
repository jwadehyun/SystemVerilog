module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS, N8_DATA_IN, N8_LATCH, N8_PULSE);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50;
	input  N8_DATA_IN;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
    output N8_LATCH;
    output N8_PULSE;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	
	
	logic [31:0] div_clk;
	parameter whichClock = 20; 
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk));
	logic clkSelect;
	assign clkSelect = div_clk[whichClock]; // for board
	
	logic reset;
	assign reset = SW[9];
	
	logic frame_start;
	logic pixel_color;
	
	//////// DOUBLE_FRAME_BUFFER ////////
	logic dfb_en;
	assign dfb_en = 1'b0;
	/////////////////////////////////////
	
	logic [9:0] x;
	logic [8:0] y;
	
	
	 wire up;
    wire down;
    wire left;
    wire right;
    wire a;
    wire b;
	 
	 
	 wire upoutput;
	 wire downoutput;
	 wire leftoutput;
	 wire rightoutput;
	 

    n8_driver driver(
        .clk(CLOCK_50),
        .data_in(N8_DATA_IN),
        .latch(N8_LATCH),
        .pulse(N8_PULSE),
        .up(up),
        .down(down),
        .left(left),
        .right(right),
        .select(LEDR[9]),
        .start(LEDR[8]),
        .a(a),
        .b(b)
    );
    
	
	
	userInput leftPress(.clk(CLOCK_50), .reset, .keypress(left), .userin(leftoutput));
	userInput rightPress(.clk(CLOCK_50), .reset, .keypress(right), .userin(rightoutput));
	userInput upPress(.clk(CLOCK_50), .reset, .keypress(up), .userin(upoutput));
	userInput downPress(.clk(CLOCK_50), .reset, .keypress(down), .userin(downoutput));
	
	
	// Change the size of the gap between pixels depending on how detailed you want the drawing to be
	logic jump20pixels;
	logic jump10pixels;
	logic jump2pixels;
	
	assign jump20pixels = SW[7];
	assign jump10pixels = SW[6];
	assign jump2pixels = SW[5];
	
	int jumpsize;
	
	always_ff @(posedge CLOCK_50) begin
		if (jump20pixels) begin
			jumpsize = 20;
		end else if (jump10pixels) begin
			jumpsize = 10;
		end else if (jump2pixels) begin
			jumpsize = 2;
		end
	
	
	
		if (reset) begin
			x <= 200;
			y <= 200;
		end	
		if (upoutput == 1) begin
			y <= y - jumpsize;
		end 
		if (downoutput == 1) begin
			y <= y + jumpsize;
		end
		if (leftoutput == 1) begin
			x <= x - jumpsize;
		end
		if (rightoutput == 1) begin
			x <= x + jumpsize;
		end	
	end
	
	logic writeenable;
	assign writeenable = SW[8];
	
	logic color;
	assign color = SW[0]; 

	
	//pass in a x, y to be colored in on the screen
	VGA_framebuffer fb(.clk(CLOCK_50), .rst(1'b0), .x(x), .y(y),
				.pixel_color(color), .pixel_write(writeenable), .dfb_en, .frame_start,
				.VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_HS, .VGA_VS,
				.VGA_BLANK_N, .VGA_SYNC_N);
	
	
	
	//logic clear;
	//assign clear = SW[0]; 
	
	//logic color;
	//assign color = SW[0];
	//assign pixel_color = SW[9]; //1 is white, 0 is black
	
	
endmodule



module DE1_SoC_testbench ();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;
	logic [7:0] VGA_R;
	logic [7:0] VGA_G;
	logic [7:0] VGA_B;
	logic VGA_BLANK_N;
	logic VGA_CLK;
	logic VGA_HS;
	logic VGA_SYNC_N;
	logic VGA_VS;

	// draw lines between (x0, y0) and (x1, y1)
	DE1_SoC dut(.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .CLOCK_50, 
	.VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N, .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
	
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	//Just let the line be drawn, little needs to be done in testbench
	initial begin			
		SW[9] <= 1; repeat(3) @(posedge CLOCK_50);
		SW[9] <= 0; repeat(80) @(posedge CLOCK_50);
		$stop;
	end

endmodule

