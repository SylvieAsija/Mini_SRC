`timescale 1ns/10ps

module DataPath_tb_jump;
	reg clr, clk,
	 R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en,
	 R10en, R11en, R12en, R13en, R14en, R15en, HIen, LOen, Zen,
	 Pen, MDRen, In_Porten, Cen, IRen, MARen, Yen, ZLOen, ZHIen, ZLOout, ZHIout, R0out, R1out, R2out, R3out, R4out, R5out, 
	 R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, MDROut,Pout, Cout, Outport, HIout, LOout, Yout,
	 Write, Read, Gra, Grb, Grc, Rin, Rout, BAout, ConIn; 

	reg [31:0] Mdatain;
	reg [4:0] alu_control;
	 
   parameter Default = 4'b0000; 
	parameter Reg_load1a = 4'b0001; 
	parameter Reg_load1b = 4'b0010;
	parameter Reg_load1c = 4'b0011;
	parameter Reg_load1d = 4'b0100;
	parameter T0 = 4'b0111;
   parameter T1 = 4'b1000; 
	parameter T2 = 4'b1001; 
	parameter T3 = 4'b1010; 
	parameter T4 = 4'b1011; 
	parameter T5 = 4'b1100;
	parameter T6 = 4'b1101;
   reg [3:0] Present_state = Default;
	 
	DataPath dut(clk, clr, alu_control, Mdatain, 
	R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, 
	 MDROut, HIout, LOout, ZHIout, ZLOout, Pout, Cout, Yout,
	 IRen,MARen, MDRen, Read, Write, Yen, Pen, ZHIen, ZLOen, HIen, LOen,
	R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en, R10en, R11en, R12en, R13en, R14en, R15en,
	Gra, Grb, Grc, BAout, ConIn, Rin, Rout
	);
	

	 
    initial
        begin
            clk = 0;
            forever #10 clk = ~ clk;
    end
	 
    always @(posedge clk) // finite state machine; if clock rising-edge
        begin
            case (Present_state)
                Default : Present_state = T0;
                T0 : #40 Present_state = T1;
                T1 : #40 Present_state = T2;
                T2 : #40 Present_state = T3;
                T3 : #40 Present_state = T4;
                T4 : #40 Present_state = T5;
					 T5 : #40 Present_state = T6;
            endcase
        end
		  
    always @(Present_state) // do the required job in each state
        begin
            case (Present_state) // assert the required signals in each clock cycle
            Default: begin
					clr<=0;
				   ZHIout<=0; ZLOout<=0; Zen<=0;
					Pout<=0; MDROut<=0; Cout<=0; Outport<=0; 
					Read<=0; Write <= 0; Gra<=0; Grb<=0; Grc<=0; BAout<=0; ConIn<=0;
					Rin<=0; Rout<=0; BAout<=0;
 									alu_control<=5'b00000; Mdatain<=32'h00000000;
            end
				
            T0: begin
				     Pout <= 1;
					 MARen <= 1;
					 #15
					 Pout <= 0;
					 MARen <= 0;

            end
            T1: begin
					Read <= 1;
					 MDRen <= 1;
					 #25
					 Read <= 0;
					 MDRen <= 0;
				
            end
            T2: begin
				     MDROut <= 1;
					 IRen <= 1;
					 #25
					 MDROut <= 0;
					 IRen <= 0;
					
            end
            T3: begin
					 Gra <= 1;
					 Rout <= 1;
					 Pen<=1;
					 BAout <= 1;
					 #25
					 Gra <= 0;
					 Rout <= 0;
					 Pen<=0;
					 BAout <= 0;
				
            end
//            T4: begin
//				
//					
//            end
//            T5: begin
//					
//            end
            endcase
        end
endmodule