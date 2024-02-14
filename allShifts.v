
module shr(input wire[31:0] a, bits, output wire[31:0] result);
	
		assign result = a >> bits;
	
endmodule

	
module sra(input signed [31:0] a, bits, output wire[31:0] result);
	
		assign result = a >>> bits;
	
endmodule

module shl(input wire[31:0] a, bits, output wire[31:0] result);
	
		assign result = a << bits;
	
endmodule