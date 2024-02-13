module divider(A, B, Z);
	input signed [31:0] A, B; //Q is A, M is B, temp is A
	output wire signed [63:0] Z;
	reg signed [31:0] Q;
	reg signed [32:0] M, M_twos, temp;
	reg [64:0] shifted;
	integer i;
	
	always @(A, B) begin
		M = B;
		Q = A;
		temp = 33'b0;
		M_twos = -M;
		
		for(i = 0; i<32; i = i+1) begin
			shifted = {temp, Q};
			shifted = shifted << 1;
			temp = shifted[64:32];
			Q = shifted[31:0];
			
			case(temp[32])
				0 : temp = temp + M_twos;
				1 : temp = temp + M;
				default : temp = temp;
			endcase
			
			case(temp[32])
				0 : Q[0] = 1;
				1 : Q[0] = 0;
				default : temp = temp;
			endcase
		end
		
		case(temp[32])
			0 : temp = temp;
			1 : temp = temp + M;
			default temp = temp;
		endcase
	end
	assign Z = {temp[31:0], Q};
endmodule