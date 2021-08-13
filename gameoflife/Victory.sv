module Victory (clk, reset, L, R, led9, led1, winner);
	input logic clk, reset, L, R, led9, led1;
	output logic [6:0] winner;
	
	enum{off, oneWins, twoWins} ps, ns;
	
	
	always_comb begin
		case(ps)
		
		off: begin
			winner = 7'b1111111;
			
			if (led1 & ~L & R)
				ns = oneWins;
			else if (led9 & L & ~R)
				ns = twoWins;
			else
				ns = off;
		end

		oneWins: begin
			winner = 7'b1111001;
			ns = oneWins;
			end
			
		twoWins: begin
			winner = 7'b0100100;
			ns = twoWins;
			end
				
		endcase
		
	end
		
		always_ff @(posedge clk)
			if (reset) 
				ps <= off;
			else
				ps <= ns;
	
	endmodule
	
module Victory_testbench();
	logic clk, reset, L, R, led9, led1;
	logic [6:0] winner;
	
	Victory dut (.clk, .reset, .L, .R, .led9, .led1, .winner);
	
parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	

	integer i;
	initial begin
 reset <= 1; @(posedge clk);
 reset <= 0;
 
 for (i=0; i<16; i++) begin
	{L, R, led9, led1} = i; @(posedge clk);
end
 
 $stop; 
 
 end
 
endmodule
		