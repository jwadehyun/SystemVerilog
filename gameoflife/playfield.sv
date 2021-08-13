/*
module centerLight (Clock, Reset, L, R, NL, NR, lightOn);
 input logic Clock, Reset;
 // L is true when left key is pressed, R is true when the right key
 // is pressed, NL is true when the light on the left is on, and NR
 // is true when the light on the right is on.
 input logic L, R, NL, NR;
 // when lightOn is true, the center light should be on.
 output logic lightOn;
 // Your code goes here!!
 enum{off, on} ps, ns;

 always_comb begin
  case (ps)
   on : if (L & R | ~L & ~R)
	 ns = on;
	 else
	 ns = off;
	
	off : if (L & NR | R & NL)
	 ns = on;
	else
	 ns = off;

endcase
end

always_ff @(posedge Clock)
	if (Reset)
		lightOn <= on;
	else
		lightOn <= ns;
 
endmodule

module normalLight (Clock, Reset, L, R, NL, NR, lightOn);
 input logic Clock, Reset;
 // L is true when left key is pressed, R is true when the right key
 // is pressed, NL is true when the light on the left is on, and NR
 // is true when the light on the right is on.
 input logic L, R, NL, NR;
 // when lightOn is true, the normal light should be on.
 output logic lightOn;
 // Your code goes here!!
 enum{off, on} ps, ns;
 always_comb begin
  case (ps)
   on : if (L & R | ~L & ~R)
	 ns = on;
	 else
	  ns = off;
	
	off : if (L & NR | R & NL)
	 ns = on;
	else
	 ns = off;

endcase
  
 end
 
endmodule 

module centerLight_testbench();
 logic Clock, Reset, L, R, NL, NR;
 logic lightOn;
 
 centerLight dut (.Clock, .Reset, .L, .R, .NL, .NR, .lightOn);
 
 parameter CLOCK_PERIOD=100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
end

 initial begin
 Reset <= 1; @(posedge Clock);
 Reset <= 0; @(posedge Clock);
 
 R <= 1; L <= 0; NL <= 1; NR <= 1; @(posedge Clock);
 
 R <= 0; L <= 1; NL <= 0; NR <= 1; @(posedge Clock);
 
 R<=1; L<=1; NL<=0; NR<=0; @(posedge Clock);
 
 R<=1; L<=0; NL <=0; NR<=0; @(posedge Clock);
 
 R<=1; L<=0; NL <=0; NR<=1; @(posedge Clock);
 
 R<=0; L<=1; NL <=0; NR<=0; @(posedge Clock);

 R<=0; L<=1; NL <=1; NR<=0; @(posedge Clock);
 
 R<=1; L<=0; NL <=0; NR<=0; @(posedge Clock);
 
 $stop; 
 
 end
 
endmodule


module normalLight_testbench();
 logic Clock, Reset, L, R, NL, NR;
 logic lightOn;
 
 normalLight dut (.Clock, .Reset, .L, .R, .NL, .NR, .lightOn);
 
 parameter CLOCK_PERIOD=100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
end

 initial begin
 Reset <= 1; @(posedge Clock);
 Reset <= 0; @(posedge Clock);
 
 R <= 1; L <= 0; NL <= 1; NR <= 1; @(posedge Clock);
 
 R <= 0; L <= 1; NL <= 0; NR <= 1; @(posedge Clock);
 
 R<=1; L<=1; NL<=0; NR<=0; @(posedge Clock);
 
 R<=1; L<=0; NL <=0; NR<=0; @(posedge Clock);
 
 R<=1; L<=0; NL <=0; NR<=1; @(posedge Clock);
 
 R<=0; L<=1; NL <=0; NR<=0; @(posedge Clock);

 R<=0; L<=1; NL <=1; NR<=0; @(posedge Clock);
 
 R<=1; L<=0; NL <=0; NR<=0; @(posedge Clock);
 
 $stop; 
 
 end
 
endmodule



*/