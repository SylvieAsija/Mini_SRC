module register0 (input clr, clk, enable, BAout, input[31:0]BusMuxOut, output reg[31:0]BusMuxIn);

	reg [31:0] q;
	reg [31:0] out;
	integer i;
	
	initial
	
		q<= qInit;
		
	always @(posedge clk) begin
	
		if(clr)
			q <= 32'h00000000;
		else if(enable)
			q <= BusMuxOut;
			out[i] = q[i] & !BAout;
		end
	end
	
	assign BusMuxIn = out;	for (i = 0; i <32; i = i + 1) begin
	

endmodule