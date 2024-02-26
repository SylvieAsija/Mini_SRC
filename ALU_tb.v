`timescale 1ns/10ps

module ALU_tb;

	reg [31:0] b, y; 
	reg [4:0] control; 
	wire [63:0] result;
	
	ALU alu(b,y,control, result);

	
	initial 
		begin 
			//first test: or
			b <= 32'h00000000;
			y <= 32'h00000000;

			#10;
			control <= 5'b01011; 
			#100;

		end
endmodule
		
