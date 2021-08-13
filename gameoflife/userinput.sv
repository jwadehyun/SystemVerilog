module userinput (clock, reset, key, out);

	input logic reset, key, clock;
	output logic out;	
	
	enum {off, on} ps, ns;	
		
	always_comb 
		case(ps)
			off: begin  
				if(key) begin 
			      ns = on;
			  		out = 1;
					end 
			    else begin  
				         ns = off;
							out = 0;
				end
			end
				 
			on:begin  
			if (key)  begin
    		    ns = on;
	          out=0;
				 
			end 
			else  begin  
				 ns = off;
				 out = 0;
			end
		end
		
		endcase
	
	always_ff @(posedge clock)
		if (reset)
			ps <= off;
		else
			ps <= ns;
			
endmodule

module userinput_testbench();
	logic clock, reset, key;
	logic out;
	
	userinput dut (.clock, .reset, .key, .out);
	
	 parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end
	
	initial begin
 reset <= 1; @(posedge clock);
 reset <= 0;
 
 key <= 0; @(posedge clock);
 
 key <= 1; @(posedge clock);
 
 $stop; 
 
 end
 
endmodule