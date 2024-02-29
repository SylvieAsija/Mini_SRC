module DataPath(
	input wire clk, clr,
		input wire [4:0] alu_control,
      input wire [31:0] Mdatain,
		input wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, Yout,
		input wire IRen,MARen, MDRen, Read, Yen, Pen, ZHIen, ZLOen, HIen, LOen, R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en, R10en, R11en, R12en, R13en, R14en, R15en
	); 

//	wire BAout;
	wire Zen, Out_Porten, Cen, Write, In_Porten;
	
	wire [31:0] R0BusIn, R1BusIn, R2BusIn, R3BusIn, R4BusIn, R5BusIn, R6BusIn, R7BusIn, R8BusIn, R9BusIn,
					R10BusIn, R11BusIn, R12BusIn, R13BusIn, R14BusIn, R15BusIn, HIBusIn, LOBusIn, ZHIBusIn, ZLOBusIn,
					PCBusIn, MDRBusIn, InPortBusIn, IRoutput, alu_input, C_Sign_Extnd, ramDataOut, busMuxOut;
	wire [15:0] Ren_control, Rselect_control, Ren_se, Rselect_se;				
//	wire [8:0] MARoutput;
	wire [63:0] alu_result;
	
	
	//Create Reg 0-15
	register r0 (clr, clk, R0en, busMuxOut, R0BusIn);
	register r1 (clr, clk, R1en, busMuxOut, R1BusIn);
	register r2 (clr, clk, R2en, busMuxOut, R2BusIn);
	register r3 (clr, clk, R3en, busMuxOut, R3BusIn);
	register r4 (clr, clk, R4en, busMuxOut, R4BusIn);
	register r5 (clr, clk, R5en, busMuxOut, R5BusIn);
	register r6 (clr, clk, R6en, busMuxOut, R6BusIn);
	register r7 (clr, clk, R7en, busMuxOut, R7BusIn);
	register r8 (clr, clk, R8en, busMuxOut, R8BusIn);
	register r9 (clr, clk, R9en, busMuxOut, R9BusIn);
	register r10 (clr, clk, R10en, busMuxOut, R10BusIn);
	register r11 (clr, clk, R11en, busMuxOut, R11BusIn);
	register r12 (clr, clk, R12en, busMuxOut, R12BusIn);
	register r13 (clr, clk, R13en, busMuxOut, R13BusIn);
	register r14 (clr, clk, R14en, busMuxOut, R14BusIn);
	register r15 (clr, clk, R15en, busMuxOut, R15BusIn);
	
	
	//Create Other Regs
	register PCreg(clr, clk, Pen, busMuxOut, PCBusIn);
   register IRreg(clr, clk, IRen, busMuxOut, IRoutput);
   register Yreg(clr, clk, Yen, busMuxOut, alu_input);
   register ZLOReg(clr, clk, ZLOen, alu_result[31:0], ZLOBusIn);
	register ZHIReg(clr, clk, ZHIen, alu_result[63:32], ZHIBusIn);
   register HIreg(clr, clk, HIen, busMuxOut, HIBusIn);
   register LOreg(clr, clk, LOen, busMuxOut, LOBusIn);
	
		//memory registers
	memoryDataRegister mdr(clk, clr, MDRen, Read, Mdatain,  busMuxOut, MDRBusIn);
//	mar maR(.busMuxOut(busMuxOut), .MARen(MARen), .clr(clr), .clk(clk), .Q(MARoutput));


//Bus
Bus bus( R0BusIn,  R1BusIn,  R2BusIn,  R3BusIn,  R4BusIn,  R5BusIn,  R6BusIn,  R7BusIn,  R8BusIn,  R9BusIn,  R10BusIn,  R11BusIn,  R12BusIn,  R13BusIn,  R14BusIn,  R15BusIn,
 HIBusIn, LOBusIn, ZHIBusIn, ZLOBusIn, PCBusIn, MDRBusIn, InPortBusIn, C_Sign_Extnd,
 R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, InPortout, busMuxOut
 );
	
	

ALU alu(busMuxOut, alu_input, alu_control, alu_result[63:0]);


endmodule
