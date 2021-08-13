module userInput (clk, reset, keypress, userin);
	input logic clk, reset, keypress;
	output logic userin;
	
	enum {unpressed, pressed, holdpress} ps, ns;
	
	always_comb begin
		case (ps)
			unpressed: if (~keypress) ns = unpressed;
					else ns = pressed;
			pressed: if(~keypress) ns = unpressed;
					else ns = holdpress;
			holdpress: if (~keypress) ns = unpressed;
					else ns = holdpress;
		endcase
	end 
	
	always_comb begin
		case (ps) 
			unpressed: begin
				userin = 1'b0; 
				end
			pressed: begin
				userin = 1'b1; //only output a 1 if pressed
				end
			holdpress: begin
				userin = 1'b0; 
				end
		endcase
	end
	
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= unpressed;  //reset to unpressed
		else
			ps <= ns;
		end
	
endmodule


module userInput_testbench();
	logic clk, reset, keypress, userin;

	
	userInput dut (.clk, .reset, .keypress, .userin);

	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end

 // Test the design.
	initial begin
		

		$stop;
	end

endmodule
