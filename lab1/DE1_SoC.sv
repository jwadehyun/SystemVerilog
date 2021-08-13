//DE1_SoC module for Lab 1.
//Takes in inputs CLOCK_50 and GPIO_0 then returns HEX0 to HEX5.
//GPIO_0 will be used to signal the movements of the car, which then
//can be interpreted to if a car has entered or exited the parking lot.
//The HEX's wil display the current state of the parking lot,
//the number of cars in it, or if it's full or empty. 
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, GPIO_0);
	
	input logic CLOCK_50; //50MHz clock
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	inout wire [33:0] GPIO_0;
	
	//Assigns the input signals to LEDs so that the LEDs will light
	//up whenever the sensor is triggered. 
	assign GPIO_0[26] = GPIO_0[6]; //Represents sensor a
	assign GPIO_0[27] = GPIO_0[7]; //Represents sensor b
	
	// Generate clk off of CLOCK_50.
	logic [31:0] clk;

	logic reset;
	assign reset = GPIO_0[5]; // Assigns GPIO_0[5] as the reset signal

	logic enter, exit;
	logic [4:0] num;
	
	//counter counts how many cars will be in the parking lot using increments / decrements
	counter co (.clk(CLOCK_50), .reset, .inc(enter), .dec(exit), .num);
	//FSM will determine if a car has fully entered/ exited
	FSM fs (.clk(CLOCK_50), .reset, .a(GPIO_0[6]), .b(GPIO_0[7]), .enter, .exit);
	//Display will display the result in the HEX's.
	display dis (.clk(CLOCK_50), .num, .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
	
endmodule


//Testbench for DE1_SoC
module DE1_SoC_testbench();
	
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [33:0] GPIO_0;
	logic reset, clk;
	
	DE1_SoC dut (.CLOCK_50(clk), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .GPIO_0);
	
	//setting up the clk
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 
	
	integer i;
	initial begin
	GPIO_0[5] <= 1; @(posedge clk);
	GPIO_0[5] <= 0; @(posedge clk); //resetting
	
	//entering 26 cars
	for(i = 0; i < 26; i++) begin
		GPIO_0[6] = 1'b0; GPIO_0[7] = 1'b0; @(posedge clk);
		GPIO_0[6] = 1'b1; GPIO_0[7] = 1'b0; @(posedge clk);
		GPIO_0[6] = 1'b1; GPIO_0[7] = 1'b1; @(posedge clk);
		GPIO_0[6] = 1'b0; GPIO_0[7] = 1'b1; @(posedge clk);
		GPIO_0[6] = 1'b0; GPIO_0[7] = 1'b0; @(posedge clk);
	end
	
	//exiting 26 cars
	for(i = 0; i < 26; i++) begin
		GPIO_0[7] = 1'b0; GPIO_0[6] = 1'b0; @(posedge clk);
		GPIO_0[7] = 1'b0; GPIO_0[6] = 1'b1; @(posedge clk);
		GPIO_0[7] = 1'b1; GPIO_0[6] = 1'b1; @(posedge clk);
		GPIO_0[7] = 1'b1; GPIO_0[6] = 1'b0; @(posedge clk);
		GPIO_0[7] = 1'b0; GPIO_0[6] = 1'b0; @(posedge clk);
	end
	$stop;
end

endmodule
