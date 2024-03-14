module ALU(input [31:0] b, y, input [4:0] control, output reg [63:0] result);
	//Y register is the 'temp register' that holds the value 
	
	wire [31:0] addOut, subOut, negOut, orOut, andOut, shrOut, sraOut, shlOut, rorOut, rolOut, notOut, incOut;
	wire [63:0] mulOut, divOut;
	reg first, last; 
	wire cOutAdd,cOutSub, cOutNeg;

	
	//Subtraction
	
	carryRippleAdder crSub(
	.a (y),
	.b (-b),
	.cin(0),
	.s (subOut),
	.cout(cOutSub));
	
	
	//Addition
	
	carryRippleAdder cra(
	.a (y),
	.b (b),
	.cin(0),
	.s (addOut),
	.cout(cOutAdd));
	
	
	//Multiplication 
	
	boothMultiplier mul(
	.a (y),
	.b (b),
	.c (mulOut));
	
	
	//Division
	
	divider div(
	.A (y),
	.B (b),
	.Z (divOut));
	
	//Or
	
	Or_notbroken or_op(y, b, orOut);
	
	//And
	
	And_notbroken and_op(y, b, andOut);
	
	//Shift Right
	
	shr shiftR(y, b, shrOut); 
	
	//Shift Right Arth
	
	sra shiftRA(y, b, sraOut);

	//Shift Left
	
	shl shiftL(y,b, shlOut);
	
	//Rotate Right
	
	ror rotR(y, b, rorOut);
	
	//Rotate Left
	
	rol rotL(y, b, rolOut);
	
	//Not
	Not_notbroken nonono(y, notOut);
	
	//Negate
	
	neg negate(y, negOut);
	
	//Increment PC
	
	//incPC inc();
	
always @(*)	begin
	case(control)
		5'b01011 : result <= orOut;
		5'b01010 : result <= andOut;
		5'b00101 : result <= shrOut;
		5'b00110 : result <= sraOut;
		5'b00111 : result <= shlOut;
		5'b01000 : result <= rorOut;
		5'b01001 : result <= rolOut;
		5'b10001 : result <= negOut;
		5'b10010 : result <= notOut;
		5'b00011 : result <= addOut;
		5'b00100 : result <= subOut;
		5'b01111 : result <= mulOut;
		5'b10000 : result <= divOut;
		5'b11111 : result <= 0;
		
		default : result <= orOut;
	endcase
end
endmodule
		
