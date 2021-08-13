//This module creates a counter that counts the new num.
//Takes in inputs clk, reset, inc(rement), and 
//dec(rement) and returns output num. 
//This module takes in inc and dec, an 1-bit value, to determine if 
//the number should be incremented or decremented or neither and
//returns the final num value depending on inc and dec values
module counter (clk, reset, inc, dec, num);

	input logic clk, reset, inc, dec;
	output logic [4:0] num; //5-bits
	
	//always_ff block that increments / decrements num appropriately
	always_ff @(posedge clk) begin
		if (reset) //if reset, num should be 0.
			num <= 5'b00000;
		else if (inc & ~dec & num < 5'b11001) //in case of increment
			num <= num + 1'b1; //increment by 1
		else if (~inc & dec & num > 5'b00000) //in case of decrement
			num <= num - 1'b1; //decrement by 1
		else //neither inc nor dec
			num <= num; //stays the same
	end
endmodule
	
//Testbench of counter module	
module counter_testbench();
	logic clk, reset, inc, dec;
	logic [4:0] num;
	
	counter dut (.clk, .reset, .inc, .dec, .num);
	
	//setting up clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	//some test cases
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; //resetting
 
		inc <= 1; dec <= 0; repeat(40) @(posedge clk); //incrementing 40 times
		
		reset <= 1; @(posedge clk);
		reset <= 0; //reset
		
		inc <= 0; dec <= 1; repeat(40) @(posedge clk); //dec 40 times
		
		reset <= 1; @(posedge clk);
		reset <= 0; //reset
		
		inc <= 1; dec <= 1; @(posedge clk); //case: both inc & dec
		inc <= 0; dec <= 0; @(posedge clk); //case: neither inc & dec
 
		$stop; 
	end
endmodule
		