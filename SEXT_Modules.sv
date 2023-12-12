// All Sign Extension Modules

module SEXT_10(input  logic [10:0] In,
					output logic [15:0] SEXT_OUT);
					
		assign SEXT_OUT = {{5{In[10]}},In};
					
endmodule

module SEXT_8(input  logic [8:0] In,
				  output logic [15:0] SEXT_OUT);
					
		assign SEXT_OUT = {{7{In[8]}},In};
					
endmodule

module SEXT_5(input  logic [5:0] In,
				  output logic [15:0] SEXT_OUT);
					
		assign SEXT_OUT = {{10{In[5]}},In};
					
endmodule

module SEXT_4(input  logic [4:0] In,
				  output logic [15:0] SEXT_OUT);
					
		assign SEXT_OUT = {{11{In[4]}},In};
					
endmodule
