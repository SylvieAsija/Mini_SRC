`timescale 1ns/10ps

module Datapath_tb_Control;
    input wire clk, clr, stop,
		input wire [4:0] alu_control,
      input wire [31:0] Mdatain, 
		input wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, Yout,
		input wire IRen, MARen, MDRen, Read, Write, Yen, Pen, ZHIen, ZLOen, HIen, LOen, R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en, R10en, R11en, R12en, R13en, R14en, R15en,
		Gra, Grb, Grc, BAout, ConIn, Rin, Rout, Zen, Run
        
    DataPath Dut(
        clk, clr, stop, alu_control, Mdatain, 
	R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, 
	 MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, Yout,
	 IRen,MARen, MDRen, Read, Yen, Pen, ZHIen, ZLOen, HIen, LOen,
	R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en, R10en, R11en, R12en, R13en, R14en, R15en, run
	);

    intial begin
        clk = 0;
        reset = 0;
    end
    always 
    #10 clk <= ~clk;
endmodule