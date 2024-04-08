
module Bus ( 
//Mux 
input [31:0] R0BusIn,  R1BusIn,  R2BusIn,  R3BusIn,  R4BusIn,  R5BusIn,  R6BusIn,  R7BusIn,  R8BusIn,  R9BusIn,  R10BusIn,  R11BusIn,  R12BusIn,  R13BusIn,  R14BusIn,  R15BusIn,
 HIBusIn, LOBusIn, ZHIBusIn, ZLOBusIn, PCBusIn, MDRBusIn, InPortBusIn, C_Sign_Extnd,
//Encoder 
input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, InPortout,

output wire [31:0] busMuxout
);

reg [31:0]q;

always @ (*) begin
	if (R0out) q <= R0BusIn;
	if (R1out) q <= R1BusIn;
	if (R2out) q <= R2BusIn;
	if (R3out) q <= R3BusIn;
	if (R4out) q <= R4BusIn;
	if (R5out) q <= R5BusIn;
	if (R6out) q <= R6BusIn;
	if (R7out) q <= R7BusIn;
	if (R8out) q <= R8BusIn;
	if (R9out) q <= R9BusIn;
	if (R10out) q <= R10BusIn;
	if (R11out) q <= R11BusIn;
	if (R12out) q <= R12BusIn;
	if (R13out) q <= R13BusIn;
	if (R14out) q <= R14BusIn;
	if (R15out) q <= R15BusIn;
	if (Pout) q <= PCBusIn;
	if (HIout) q <= HIBusIn;
	if (LOout) q <= LOBusIn;
	if (ZHIout) q <= ZHIBusIn;
	if (ZLOout) q <= ZLOBusIn;
	if (MDROut) q <= MDRBusIn;
	if (InPortout) q <= InPortBusIn;
	if (Cout) q <= C_Sign_Extnd;
	
end
assign busMuxout = q[31:0];
endmodule
