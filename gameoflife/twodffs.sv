module twodffs (clock, reset, d, q2);
	
	input logic clock, reset, d;
	output logic q2;
	
	logic q1;
	
	always_ff @(posedge clock) begin
		if (reset) begin
			q1 <=0;
			q2 <=0;
		end
		else begin
			q1 <= d;
			q2 <= q1;
		end
	end

endmodule 

module twodffs_testbench();
	logic clock, reset, d;
	logic q2;
	
	twodffs dut (.clock, .reset, .d, .q2);
	
	 parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end
	
	initial begin
 reset <= 1; @(posedge clock);
 reset <= 0; 
 
 d <= 0; @(posedge clock);
 
 reset <= 1; @(posedge clock);
 reset <= 0;

 d <= 1; @(posedge clock);

 $stop; 
 
 end
 
endmodule		
		