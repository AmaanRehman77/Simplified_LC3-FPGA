module mux_2_1_16 #(parameter N = 16) (input logic  [N-1:0] A, B,
											      input logic  		   SelectBit,
													output logic [N-1:0] Out );

always_comb
	begin
		
		if(SelectBit) begin
			Out = A; end
		
		else begin
			Out = B; end
		
	end

endmodule
