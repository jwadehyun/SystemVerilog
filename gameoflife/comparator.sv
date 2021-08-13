module comparator (A, B, out);
	
	input logic [9:0] A, B;
	output logic out;
	
	always_comb begin
		if (A > B) begin
			out = 1; 
			end
		else begin
			out = 0;
			end
	end

endmodule 