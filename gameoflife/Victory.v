module victory (clk, reset, L, R, led9, led1, winnner);
	input logic clk, reset, L, R, led9, led1;
	output logic winner;
	
	logic [1:0] ps;
	logic [1:0] ns;
	
	parameter off = 2'b00, oneWins = 2'b01; twoWins = 2'b10;
	
	
	always_comb
		case(ps)
		
		off: begin
			winner = 7'b1111111;
			
			if (led1 & ~L & R)
				ns = oneWins;
			else if (led9 & L & ~R)
				ns = woWins;
			else
				ns = off;
			end
		
		oneWins: begin
			winner = 7'b1111001;
			ns = oneWins;
			end
			
		twoWins: begin
			winner = 7'0100100;
			ns = twoWins;
			end
		
		default winner = 7'bX;
		
		endcase
		
		always_ff @(posedge clk)
			if (reset) 
				ps <= off;
			else
				ps <= ns;
	
	endmodule
	
	module victory_testbench();
		logic clk, reset, L, R, led9, led1;
		logic winner;
		
		victory dut (.clk, .reset, .L, .R, .led9, .led1, .winnner);
		parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end

 initial begin
 reset <= 1; @(posedge clk);
 reset <= 0; @(posedge clk);
 
 R <= 1; L <= 0; led9 <= 1; led1 <= 1; @(posedge clk);
 
 R <= 0; L <= 1; led9 <= 0; led1 <= 1; @(posedge clk);
 
 R<=1; L<=1; led9 <=0; led1 <=0; @(posedge clk);
 
 R<=1; L<=0; led9 <=0; led1 <=0; @(posedge clk);
 
 R<=1; L<=0; led9 <=0; led1<=1; @(posedge clk);
 
 R<=0; L<=1; led9 <=0; led1<=0; @(posedge clk);

 R<=0; L<=1; led9 <=1; led1<=0; @(posedge clk);
 
 R<=1; L<=0; led9 <=0; led1<=0; @(posedge clk);
 
 $stop; 
 
 end
 
endmodule
		
		