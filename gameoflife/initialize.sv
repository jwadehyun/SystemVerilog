module initialize (
	input logic clk, 
	input logic reset,
	input logic freset,
	input logic [7:0] SW, 
	input logic [3:0] KEY,
	output logic [7:0][7:0] led
	
	);
	
	logic [7:0][7:0] val;
	
	logic [1:0] press0, press1, press2, press3;
	logic out0, out1, out2, out3;
	
	userinput one (.clock(clk), .reset, .key(~KEY[0]), .out(out0));
	userinput two (.clock(clk), .reset, .key(~KEY[1]), .out(out1));
	userinput three (.clock(clk), .reset, .key(~KEY[2]), .out(out2));
	userinput four (.clock(clk), .reset, .key(~KEY[3]), .out(out3));
	
	
	always_ff @(posedge clk) begin
		if (reset) begin
			press0 <= 0;
			press1 <= 0;
			press2 <= 0;
			press3 <= 0;
		end
		
		if (out0)
			press0 <= press0 + 2'b01;
			
		if (out1)
			press1 <= press1 + 2'b01;
			
		if (out2)
			press2 <= press2 + 2'b01;
			
		if (out3)
			press3 <= press3 + 2'b01; 
	end
	
	integer i;
	integer j; 
	integer k;
	
	always_ff @(posedge clk) begin
	
		if (reset) begin
				for (int i = 0; i < 8; i++) begin
					for (int j = 0; j < 8; j++)
						val[i][j] = 0;
				end
			end
		else if (~reset & freset) begin
			for (k = 0; k < 8; k++) begin
				if (SW[k]) begin
					if (press0 == 2'b00) begin
						val[k][0] = 0;
						val[k][1] = 0;
						end
					
					else if (press0 == 2'b01) begin
						val[k][0] = 1;
						val[k][1] = 0;
						end
					
					else if (press0 == 2'b10) begin
						val[k][0] = 0;
						val[k][1] = 1;
						end
					
					else if (press0 == 2'b11) begin
						val[k][0] = 1;
						val[k][1] = 1;
						end
						
					if (press1 == 2'b00) begin
						val[k][2] = 0;
						val[k][3] = 0;
						end
						
					else if (press1 == 2'b01) begin
						val[k][2] = 1;
						val[k][3] = 0;
						end
					
					else if (press1 == 2'b10) begin
						val[k][2] = 0;
						val[k][3] = 1;
						end
						
					else if (press1 == 2'b11) begin
						val[k][2] = 1;
						val[k][3] = 1;
						end
						
					if (press2 == 2'b00) begin
						val[k][4] = 0;
						val[k][5] = 0;
						end
						
					else if (press2 == 2'b01) begin
						val[k][4] = 1;
						val[k][5] = 0;
						end
						
					else if (press2 == 2'b10) begin
						val[k][4] = 0;
						val[k][5] = 1;
						end
						
					else if (press2 == 2'b11) begin
						val[k][4] = 1;
						val[k][5] = 1;
						end
						
					if (press3 == 2'b00) begin
						val[k][6] = 0;
						val[k][7] = 0;
						end
						
					else if (press3 == 2'b01) begin
						val[k][6] = 1;
						val[k][7] = 0;
						end
						
					else if (press3 == 2'b10) begin
						val[k][6] = 0;
						val[k][7] = 1;
						end
						
					else if (press3 == 2'b11) begin
						val[k][6] = 1;
						val[k][7] = 1;
						end
				end
			end
		end			
	end
	
	assign led = val;

endmodule



module initialize_testbench();
	logic clk;
	logic reset;
	logic freset;
	logic [7:0] SW;
	logic [3:0] KEY;
	logic [7:0][7:0] led;
	
	initialize dut (.clk, .reset, .freset, .SW, .KEY, .led);
		

	parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end
		
	integer i;
	initial begin
	reset <= 1; @(posedge clk);
	reset <= 0;
	freset <= 1;
	
	for (i = 0; i < 8; i++)
		SW[i] = 1;
	
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	KEY[0] <= 1; @(posedge clk); 
	KEY[0] <= 0; 
	
	for (int i = 0; i < 8; i++)
		SW[i] = 0;
	
	SW[3] <= 1; @(posedge clk);
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	
	SW[3] <= 0; @(posedge clk);
	
	SW[6] <= 1; @(posedge clk);
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	KEY[0] <= 1; @(posedge clk);
	KEY[0] <= 0;
	
	SW[6] <= 0; @(posedge clk);

	$stop; 
	 
	 end
	
endmodule