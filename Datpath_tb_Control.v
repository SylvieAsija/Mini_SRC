`timescale 1ns/10ps

module Datapath_tb_Control;
		reg clk, clr, stop;
	   reg [4:0] alu_control;
      reg [31:0] Mdatain;
		reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, Yout;
		reg IRen, MARen, MDRen, Read, Write, Yen, Pen, ZHIen, ZLOen, HIen, LOen, R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en, R10en, R11en, R12en, R13en, R14en, R15en,
		Gra, Grb, Grc, BAout, ConIn, Rin, Rout, Zen, Run, incPC;
        
    DataPath Dut(
        clk, clr, stop, alu_control, Mdatain, 
	R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, 
	 MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, Yout,
	 IRen,MARen, MDRen, Read, Yen, Pen, ZHIen, ZLOen, HIen, LOen,
	R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en, R10en, R11en, R12en, R13en, R14en, R15en, run
	);

initial
        begin
            clk = 0;
            forever #10 clk = ~ clk;
    end
endmodule