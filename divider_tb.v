`timescale 1ns/1ns

module divider_tb;

reg [31:0] a, b;
wire [63:0] q;

divider div(a,b,q);

initial
	begin
		a = 100;
		b = 2;
		#10;
	end
endmodule