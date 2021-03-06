module cells (clock, freset, start, cell0, cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, next);
	input logic clock;
	input logic freset;
	input logic start; 
	input logic cell0, cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8;

	output logic next; 
	
	logic [3:0] cellcount; 
	logic cycle; 
	
	
	assign cellcount = cell0 + cell1 + cell2 + cell3 + cell5 + cell6 + cell7 + cell8;
	
	
	enum {off, on} ps, ns;
	
	always_comb begin
		case (ps)
			on : if (cellcount == 2 || cellcount == 3)
						ns = on; 
					else
						ns = off;
			off : if (cellcount == 3)
						ns = on;
					else
						ns = off; 
		endcase
	end
	
	assign next = ps; 
	
	always_ff @(posedge clock) begin
		if (freset) begin
			if (start == 1)
				ps <= on;
			else
				ps <= off;
			end
		else begin
			if (cell4 == 1)
				ps <= on;
			else
				ps <= off;
		end
		ps <= ns; 
	end
endmodule


module cells_testbench();
	logic clock;
	logic freset;
	logic start; 
	logic cell0, cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8;
	logic next;
	
	cells dut (.clock, .freset, .start, .cell0, .cell1, .cell2, .cell3, .cell4, .cell5, .cell6, .cell7, .cell8, .next);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end
	
	initial begin
	
	freset <= 1; @(posedge clock);
	freset <= 0;
	start <= 1; cell0 <= 0; cell1 <= 0; cell2 <= 1; cell3 <= 1; cell4 <= 1; cell5 <= 0; cell6 <=0; cell7 <= 0; cell8 <= 0; @(posedge clock); 
	@(posedge clock);
	
	start <= 1; cell0 <= 1; cell1 <= 1; cell2 <= 1; cell3 <= 1; cell4 <= 1; cell5 <= 1; cell6 <=0; cell7 <= 0; cell8 <= 0; @(posedge clock); 
	@(posedge clock);
	
	start <= 0; cell0 <= 1; cell1 <= 1; cell2 <= 1; cell3 <= 0; cell4 <= 0; cell5 <= 0; cell6 <=0; cell7 <= 0; cell8 <= 0; @(posedge clock); 
	@(posedge clock);
	
	start <= 0; cell0 <= 1; cell1 <= 1; cell2 <= 1; cell3 <= 1; cell4 <= 0; cell5 <= 1; cell6 <=1; cell7 <= 0; cell8 <= 0; @(posedge clock); 
	@(posedge clock);


 $stop; 
 
 end
 
endmodule

