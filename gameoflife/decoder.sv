module decoder (out, in, enable);
	output logic [3:0] out;
	input logic [1:0] in;
	input logic enable;
	
	
	always_comb begin
		if (enable) begin
			case(in)
				2'b00: out = 4'b001;
				2'b01: out = 4'b001;
				2'b10: out = 4'b001;
				2'b11: out = 4'b001;
			endcase
		end else
			out = 4'b000;
		end
	
endmodule 