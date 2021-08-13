module counters (clock, reset, freset, dir, led, score);
	input logic clock, reset, dir, led;
	output logic freset;
	output logic [6:0] score;
	
	enum{off, one, two, three, four, five, six, seven} ps, ns;
	
	
	always_comb begin
		case(ps)
		
		off: begin
			score = 7'b1111111; 
			if (led & dir)
				ns = one;
			else
				ns = off;
		end

		one: begin
			score = 7'b1111001;
			if (led & dir)
				ns = two;
			else
				ns = one;
			end
			
		two: begin
			score = 7'b0100100;
			if (led & dir)
				ns = three;
			else
				ns = two;
			end
			
		three: begin
			score = 7'b0110000;
			if (led & dir)
				ns = four;
			else
				ns = three;
			end
		
		four: begin
			score = 7'b0011001;
			if (led & dir)
				ns = five;
			else
				ns = four;
			end
			
		five: begin
			score = 7'b0010010;
			if (led & dir)
				ns = six;
			else
				ns = five;
			end
		
		six: begin
			score = 7'b0000010;
			if (led & dir)
				ns = seven;
			else
				ns = six;
			end
		
		seven: begin
			score = 7'b1111000;
			ns = seven;
			end
				
		endcase
		
		
	end
	
	always_comb begin
		if (led & dir) begin
			freset = 1'b1;
			end
		else begin
			freset = 1'b0;
		end
	end
		
		always_ff @(posedge clock)
			if (reset) 
				ps <= off;
			else
				ps <= ns;
	
	endmodule
	
module counters_testbench();
	logic clock, reset, dir, led;
	logic freset;
	logic [6:0] score;
	
	counters dut (.clock, .reset, .freset, .dir, .led, .score);
	
parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end
	


	initial begin
 reset <= 1; @(posedge clock);
 reset <= 0;
 
dir <= 1; led <= 1; repeat(40) @(posedge clock);
 
 $stop; 
 
 end
 
endmodule
		