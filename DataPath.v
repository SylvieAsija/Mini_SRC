module DataPath(
	input wire clk, stop, reset,
     input wire [31:0] In_PortIN, 
		output wire [31:0] Out_PortOUT,
     

		output [4:0] op,
		output [31:0] BusMuxOut,
		output [63:0] alu_result
	); 
	
	wire Gra, Grb, Grc, Rin, Rout, BAout;
	wire HIen, LOen, Pen, Zen, Yen, MDRen, MARen, Out_Porten, Cen, IRen, con_en, Write, Read;
	wire HIselect, LOselect, ZHIselect, ZLOselect, Pselect, MDRselect, In_Portselect, IncPC, Cselect;
	wire con_out, run, clr;
	

	
	reg [15:0] Ren, Rselect;
	
	
	
	wire [31:0] R0BusIn, R1BusIn, R2BusIn, R3BusIn, R4BusIn, R5BusIn, R6BusIn, R7BusIn, R8BusIn, R9BusIn,
					R10BusIn, R11BusIn, R12BusIn, R13BusIn, R14BusIn, R15BusIn, HIBusIn, LOBusIn, ZHIBusIn, ZLOBusIn,
					PCBusIn, MDRBusIn, InPortBusIn, IRoutput, alu_input, C_Sign_Extnd, ramDataOut, busMuxOut;
	wire [15:0] Ren_control, Rselect_control, Ren_se, Rselect_se;				
	wire [8:0] MARoutput;
	
	assign BusMuxOut = busMuxOut;
	
	//Create Reg 0-15
	register0 r0 (clr, clk, Ren[0], BAout, busMuxOut, R0BusIn);
	register r1 (clr, clk, Ren[1], busMuxOut, R1BusIn);
	register r2 (clr, clk, Ren[2], busMuxOut, R2BusIn);
	register r3 (clr, clk, Ren[3], busMuxOut, R3BusIn);
	register r4 (clr, clk, Ren[4], busMuxOut, R4BusIn);
	register r5 (clr, clk, Ren[5], busMuxOut, R5BusIn);
	register r6 (clr, clk, Ren[6], busMuxOut, R6BusIn);
	register r7 (clr, clk, Ren[7], busMuxOut, R7BusIn);
	register r8 (clr, clk, Ren[8], busMuxOut, R8BusIn);
	register r9 (clr, clk, Ren[9], busMuxOut, R9BusIn);
	register r10 (clr, clk, Ren[10], busMuxOut, R10BusIn);
	register r11 (clr, clk, Ren[11], busMuxOut, R11BusIn);
	register r12 (clr, clk, Ren[12], busMuxOut, R12BusIn);
	register r13 (clr, clk, Ren[13], busMuxOut, R13BusIn);
	register r14 (clr, clk, Ren[14], busMuxOut, R14BusIn);
	register r15 (clr, clk, Ren[15], busMuxOut, R15BusIn);
	
	
	//Create Other Regs
	//In_Port IP(clr, clk, In_PortIN, InPortBusIn);
	register Out_Port(clr, clk, Out_Porten, busMuxOut, Out_PortOUT);
	register PCreg(clr, clk, Pen, busMuxOut, PCBusIn);
   register IRreg(clr, clk, IRen, busMuxOut, IRoutput);
   register Yreg(clr, clk, Yen, busMuxOut, alu_input);
   register ZLOReg(clr, clk, Zen, alu_result[31:0], ZLOBusIn);
	register ZHIReg(clr, clk, Zen, alu_result[63:32], ZHIhBusIn);
   register HIreg(clr, clk, HIen, busMuxOut, HIBusIn);
   register LOreg(clr, clk, LOen, busMuxOut, LOBusIn);


//Bus
Bus bus(Rselect[0], Rselect[1], Rselect[2], Rselect[3], Rselect[4], Rselect[5], Rselect[6], Rselect[7], Rselect[8], Rselect[9],
	 Rselect[10], Rselect[11], Rselect[12], Rselect[13], Rselect[14], Rselect[15], HIselect, LOselect, ZHIselect, ZLOselect,
	 Pselect, MDRselect, In_Portselect, Cselect, R0BusIn, R1BusIn, R2BusIn, R3BusIn, R4BusIn, R5BusIn, R6BusIn, R7BusIn, R8BusIn, R9BusIn,
					R10BusIn, R11BusIn, R12BusIn, R13BusIn, R14BusIn, R15BusIn, HIBusIn, LOBusIn, ZHIBusIn, ZLOBusIn,
					PCBusIn, MDRBusIn, InPortBusIn, C_Sign_Extnd, busMuxOut
	);




endmodule
