`timescale 1ns/1ns

module ALU_tb;

	reg [31:0]a, b, y; 
	reg [31:0] control; 
	reg con_flag;
	wire [63:0] result;
	
	ALU alu(b,y,control, con_flag, result);
	
	initial 
		begin 
			//first test: or
			#10
			a = 32'h00000001;
			b = 32'h00000010;
			y = a;
			control = 32'h00000000; //or_opcode 32'h00000011
			#100
			// second test: and
			a = 32'h0000FFFF;
			b = 32'h0000F000;
			y=a;
			#10
			control = 32'h00000002; // and_opcode 32'h0000F000
			#100;
			// this one isnt working yet
		end
endmodule
		