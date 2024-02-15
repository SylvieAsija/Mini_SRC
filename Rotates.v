module ror(input wire[31:0] a, bits, output wire[31:0] result);

		reg bit;
		reg[31:0] A;
		integer i;
		
always @* begin
	A = a;

	for(i = 0; i < 32; i = i+1) begin
	
		if (i < bits) begin
			bit = A[0];
			A = A >> 1;
			A[31] = bit;
		end
		
	end

end

	assign result = A;
	
endmodule


module rol(input wire[31:0] a, bits, output wire[31:0] result);

		reg bit;
		reg[31:0] A;
		integer i;
		
always @* begin
	A = a;

	for(i = 0; i < 32; i = i+1) begin
	
		if (i < bits) begin
			bit = A[31];
			A = A << 1;
			A[0] = bit;
		end
		
	end
	
end

	assign result = A;
	
endmodule