`timescale 1ns/1ns

module ALU_tb;

	reg [31:0]a, b, y; 
	reg [4:0] control; 
	reg clk;
	wire [63:0] result;
	
	ALU alu(b,y,control, clk, result);
	
	initial 
		begin 
			//first test: or
			a = 32'h00000001;
			b = 32'h00000010;
			y=a;
			#10;
			control = 5'b01011; 
			#100;
		end
endmodule
		