module register #(parameter qInit = 0)(input clr, clk, enable, input[31:0]d, output reg[31:0]q);

	initial
	
		q<= qInit;
		
	always @(posedge clk) begin
	
		if(clr)
			q <= 32'h00000000;
		if(enable)
			q <= d;
			
	end

endmodule
		
