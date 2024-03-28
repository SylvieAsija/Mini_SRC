module DataPath(
	input wire clk, clr,
		input wire [4:0] alu_control,
      input wire [31:0] Mdatain, 
		input wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, Yout,
		input wire IRen, MARen, MDRen, Read, Write, Yen, Pen, ZHIen, ZLOen, HIen, LOen, R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en, R10en, R11en, R12en, R13en, R14en, R15en,
		Gra, Grb, Grc, BAout, ConIn, Rin, Rout, Zen
	); 


	wire Out_Porten, Cen, In_Porten;
	
	wire [31:0] R0BusIn, R1BusIn, R2BusIn, R3BusIn, R4BusIn, R5BusIn, R6BusIn, R7BusIn, R8BusIn, R9BusIn,
					R10BusIn, R11BusIn, R12BusIn, R13BusIn, R14BusIn, R15BusIn, HIBusIn, LOBusIn, ZHIBusIn, ZLOBusIn,
					PCBusIn, MDRBusIn, InPortBusIn, IRoutput, alu_input, C_Sign_Extnd, ramDataOut, busMuxOut, 
					BusMuxInIR, ramOut, R0mid, InPortout;
	wire [15:0] Ren_control, Rselect_control, Ren_se, Rselect_se;				
	wire [63:0] alu_result;
	wire [8:0] address;
	

	reg [15:0] R0_15_out;
	reg [15:0] R0_15_in;
	initial begin
		R0_15_out <= 16'd0;
		R0_15_in <= 16'd0;
	end
	always @ (*) begin
	R0_15_out <= {R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out};
	R0_15_in <= {R15en, R14en, R13en, R12en, R11en, R10en, R9en, R8en, R7en, R6en, R5en, R4en, R3en, R2en, R1en, R0en};
	end
	
	
	//Create Reg 0-15
	register r0 (clr, clk, R0en, busMuxOut, R0mid);
	assign R0BusIn = {32{!BAout}} & R0mid;
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
	incPC PCreg(busMuxOut, clk, clr, Pen, PCBusIn);
   register IRreg(clr, clk, IRen, busMuxOut, BusMuxInIR);
   register Yreg(clr, clk, Yen, busMuxOut, alu_input);
   register ZLOReg(clr, clk, Zen, alu_result[31:0], ZLOBusIn);
	register ZHIReg(clr, clk, Zen, alu_result[63:32], ZHIBusIn);
   register HIreg(clr, clk, HIen, busMuxOut, HIBusIn);
   register LOreg(clr, clk, LOen, busMuxOut, LOBusIn);
	
		//memory registers
	memoryDataRegister mdr(clk, clr, MDRen, Read, ramOut,  busMuxOut, MDRBusIn);
   MAR mar(clk, clr, MARen, busMuxOut, address);


//Bus
//Bus bus( R0BusIn,  R1BusIn,  R2BusIn,  R3BusIn,  R4BusIn,  R5BusIn,  R6BusIn,  R7BusIn,  R8BusIn,  R9BusIn,  R10BusIn,  R11BusIn,  R12BusIn,  R13BusIn,  R14BusIn,  R15BusIn,
// HIBusIn, LOBusIn, ZHIBusIn, ZLOBusIn, PCBusIn, MDRBusIn, InPortBusIn, C_Sign_Extnd,
// R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, InPortout, busMuxOut
// );

Bus bus( R0BusIn,  R1BusIn,  R2BusIn,  R3BusIn,  R4BusIn,  R5BusIn,  R6BusIn,  R7BusIn,  R8BusIn,  R9BusIn,  R10BusIn,  R11BusIn,  R12BusIn,  R13BusIn,  R14BusIn,  R15BusIn,
 HIBusIn, LOBusIn, ZHIBusIn, ZLOBusIn, PCBusIn, MDRBusIn, InPortBusIn, C_Sign_Extnd,
 R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, InPortout, busMuxOut
 );
 
 conff CONFF(busMuxOut, BusMuxInIR, ConIn, Pen);
 
 SelectEncoder selectencode(BusMuxInIR, Gra, Grb, Grc, Rin, Rout, BAout, C_Sign_Extnd, R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out, R15en, R14en, R13en, R12en, R11en, R10en, R9en, R8en, R7en, R6en, R5en, R4en, R3en, R2en, R1en, R0en);
 
RAM ram(Read, Write, clk, address, MDRBusIn, ramOut);
	

ALU alu(busMuxOut, alu_input, alu_control, alu_result[63:0]);


endmodule
