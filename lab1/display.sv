// This module takes in inputs num and clk, and then displays
//outputs in 7-bit logics, HEX5 ~ HEX0. 
// If num is greater than 25, HEX's will show "FULL." If between
//0 and 25, it will display the number in numerals in HEX1 & 0.
//If 0, it will display "EMPTY0" in HEX5 - 1. 
//This is a function built to display the output of the counter
//function. 
module display (clk, num, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input logic clk;
	input logic [4:0] num;
	output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	
	//Combinational logic that displays appropriate HEX outputs
	//depending on the num input. 
	always_comb begin
		//Specifies output "empty" for 0, "full" for 25, and all
		//other numbers in between are set to nothing. 
		//Determining the ones digit of the output -
		//displaying ones digit in HEX0 by using the % logic. 
		case (num % 10)
			default: HEX0 = 7'b1000000; //0
			1: HEX0 = 7'b1111001; //1
			2: HEX0 = 7'b0100100; //2
			3: HEX0 = 7'b0110000; //3
			4: HEX0 = 7'b0011001; //4
			5: HEX0 = 7'b0010010; //5
			6: HEX0 = 7'b0000011; //6
			7: HEX0 = 7'b1111000; //7
			8: HEX0 = 7'b0000000; //8
			9: HEX0 = 7'b0011000; //9
		endcase
		
		//Determining the tens digit of the output -
		//displaying the tens digit in HEX1 by determining the tens
		//digit by dividing num by 10. 
		case (num / 10)
			default: HEX1 = 7'b1000000; //default is 0
			1: HEX1 = 7'b1111001; //10's
			2: HEX1 = 7'b0100100; //20's
		endcase
		
		case (num)
			0: begin //"Empty"
				HEX5 = 7'b0000110; 
            HEX4 = 7'b1101010; 
			   HEX3 = 7'b0001100;
			   HEX2 = 7'b0000111;
				HEX1 = 7'b0010001;
				end
			25: begin //"FULL"
				HEX5 = 7'b0001110;
				HEX4 = 7'b1000001;
				HEX3 = 7'b1000111;
				HEX2 = 7'b1000111;
				end
			default: begin //Not 0 or 25 cases don't have outputs for now
						HEX5 = 7'b1111111;
						HEX4 = 7'b1111111;
						HEX3 = 7'b1111111;
						HEX2 = 7'b1111111;
						end
		endcase
	end
	
endmodule

// Testbench of the display module described above. 
// Since it is a testbench, inputs and outputs are same as above
module display_testbench();
	logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	logic [4:0] num;
	logic clk;
	
	display dut (.clk, .num, .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
	
	//Setting up clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i = 0;
	// Testing every single scenario
	initial begin
		for (i = 0; i < 27; i++) begin
			num <= i; @(posedge clk);
		end
	
		$stop; 
	end
endmodule