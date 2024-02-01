module fourtooneMux(output reg [31:0] out, input wire [31:0] a, b, c, d, input wire s0, s1);
		always @(*)
			begin
				out = s1 ? (s0 ? d : c) : (S0 ? b : a);
			end
endmodule