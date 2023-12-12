module testbench_W2();

timeunit 10ns;
timeprecision 1ns;

logic [9:0] SW;
logic	Clk, Run, Continue;
logic [9:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3;

slc3_testtop slc3_1(.*);

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
	Clk = 0;
end

initial begin: TEST_Vectors

Continue = 1;
Run = 1;

#2 Continue = 0;
	Run = 0;

#2 Continue = 1;
	Run = 1;

#2  SW = 16'h005a;

#10 Run = 0;

#2  Run = 1;

#160 SW = 9'b00000010;

#10 Continue = 0;

#2  Continue = 1;

#29000 SW = 9'b00000011;

#10 Continue = 0;

#2  Continue = 1;

#600 Continue = 0;

#2  Continue = 1;

//#120 SW = 9'b00000010;

//#10 Continue = 0;
//
//#2  Continue = 1;

//#120 Continue = 0;
//
//#2  Continue = 1;

//#120 SW = 9'b10000000;

//
//#2  Continue = 1;

end

endmodule
