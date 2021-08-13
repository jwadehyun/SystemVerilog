module LFSR (clock, reset, out);
	input logic clock, reset;
	output logic [9:0] out;
	
	logic feedback;

	assign feedback = ~(out[0] ^ out[3]);
	
	always_ff @(posedge clock) begin
		if (reset) begin
			out <= 10'b0000000000;
			end
		else begin
			out <= {feedback, out[9:1]};
		end
	end

endmodule


module LFSR_testbench();
	logic [9:0] out;
	logic clock, reset;
	
	LFSR dut(.out, .clock, .reset);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= !clock;
	end
	
	integer i;
	initial begin
		reset <= 1; @(posedge clock);
		reset <=0; @(posedge clock);
		for (i = 0; i < 1025; i++) begin
			@(posedge clock);
		end
		$stop;
	end
endmodule



