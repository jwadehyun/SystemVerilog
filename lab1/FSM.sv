//This module creates an FSM for the parking lot.
//Takes in inputs clk, reset, a, and b and outputs enter and exit.
//By looking at the sensor's blockage, which is represented by a & b,
//and looking at which direction the sensor is being blocked / unblocked,
//determines if the car is entering and exiting and returns the value. 
module FSM(clk, reset, a, b, enter, exit);
	
	input logic a, b, reset, clk;
	output logic enter, exit;
	
	// 7 states; 1 neutral state and 3 each for exit / enter.
	// Naming is based on the signal it gets, and the "r" stands for reverse direction.
	enum{S00, S10, S11, S01, S01_r, S11_r, S10_r} ps, ns; //present state, next state
	
	//next state logic for enter & exit
	//depending on the a & b value, determines which direction the car is moving towards. 
	always_comb begin
		case (ps)
			S00 : begin //initial state
					if (a & ~b) ns = S10; //initializing path to enter
					else if (~a & b) ns = S01_r; //initializing path to exit
					else ns = S00; 
					end
			S10 : begin
					if (a & b) ns = S11; //entering more
					else if (~a & ~b) ns = S00; //backing out
					else ns = S10;
					end
			S11 : begin
					if (~a & b) ns = S01; //entering more
					else if (a & ~b) ns = S10; //backing out
					else ns = S11;
					end
			S01 : begin
					if (~a & ~b) begin //entering more
						ns = S00; //fully entered
						end
					else if (a & b) ns = S11; //backing out
					else ns = S01;
					end
			S01_r:begin
					if (a & b) ns = S11_r; //exiting more
					else if (~a & ~b) ns = S00; //backing
					else ns = S01_r;
					end
			S11_r:begin
					if (a & ~b) ns = S10_r; //exiting more
					else if (~a & b) ns = S01_r; //backing
					else ns = S11_r;
					end
			S10_r:begin
					if (~a & ~b) begin //exiting
						ns = S00; //fully exited
					end
					else if (a & b) ns = S11_r; //backing
					else ns = S10_r;
					end
		endcase
	end
	
	//if at one state before entering & fits requirements to go one more step, enter
	assign enter = (ps == S01) && (~a & ~b); 
	//if at one state before exiting & fits requirements to go one more step, exit
	assign exit = (ps == S10_r) && (~a & ~b);
	
	//sequential logic (DFFs)
	always_ff @(posedge clk) begin
		if (reset)
			ps <= S00;
		else
			ps <= ns;
	end
	
endmodule

//Testbench for FSM
module FSM_testbench();
	logic clk, reset, a, b;
	logic enter, exit;
	
	FSM dut (.clk, .reset, .a, .b, .enter, .exit);

	//setting up the clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	integer j;
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		//complete enter cycle
		for (i = 0; i < 5; i++) begin
			a <= 0; b <= 0; @(posedge clk);
			a <= 1; b <= 0; @(posedge clk); 
			a <= 1; b <= 1; @(posedge clk); 
			a <= 0; b <= 1; @(posedge clk); 
			a <= 0; b <= 0; @(posedge clk); 
		end
		//complete exit cycle
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		for (j = 0; j < 5; j++) begin
			a <= 0; b <= 0; @(posedge clk);
			a <= 0; b <= 1; @(posedge clk); 
			a <= 1; b <= 1; @(posedge clk); 
			a <= 1; b <= 0; @(posedge clk); 
			a <= 0; b <= 0; @(posedge clk); 
		end
		
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		//testing some random backing outs
		a <= 0; b <= 0; @(posedge clk);
		a <= 0; b <= 1; @(posedge clk); 
		a <= 0; b <= 0; @(posedge clk); 
		a <= 0; b <= 1; @(posedge clk); 
		a <= 1; b <= 1; @(posedge clk);
		a <= 1; b <= 0; @(posedge clk);
		a <= 1; b <= 1; @(posedge clk);
		a <= 0; b <= 1; @(posedge clk);
		a <= 0; b <= 0; @(posedge clk);
		
	$stop;
	end
endmodule
	