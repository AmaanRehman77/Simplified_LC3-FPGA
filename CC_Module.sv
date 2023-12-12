module CC_Module(input  logic Clk, Reset, LD_CC,
					  input  logic [15:0] IR_Val,
					  input  logic [15:0] Bus_Val,
					  output logic BEN_Val);
					  
logic N, Z, P;
logic N_New, Z_New, P_New;

always_ff @ (posedge Clk)
	begin
	
	if(Reset) begin
		N <= 1'b0;
		Z <= 1'b0;
		P <= 1'b0;
	end
	
	else if(LD_CC) begin
		N <= N_New;
		Z <= Z_New;
		P <= P_New;
	end
	
	end
	
always_comb
	begin
	
	N_New = 1'b0;
	Z_New = 1'b0;
	P_New = 1'b0;
	
	if(Bus_Val == 16'h0000) begin
		Z_New = 1'b1; end
	
	else if(Bus_Val[15] == 1) begin
		N_New = 1'b1; end
	
	else begin
		P_New = 1'b1; end
		
	if((IR_Val[11] & N) | (IR_Val[10] & Z) | (IR_Val[9] & P)) begin
		BEN_Val = 1'b1; end
	
	else begin
		BEN_Val = 1'b0; end
	
	end

endmodule
