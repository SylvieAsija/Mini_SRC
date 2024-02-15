module mar #(parameter qInit = 0)(input wire [31:0] busMuxOut, input wire MARen, input wire clr, input wire clk, output reg [31:0] Q);
	initial begin
	
		Q = qInit;
		end
	always @(*) 
		begin
			if (clr)
				Q<=32'h00000000;
			else if(MARen)
				Q<= busMuxOut[31:0];
		end
		
endmodule 