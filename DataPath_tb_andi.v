`timescale 1ns/10ps

module DataPath_tb_andi;
	reg clr, clk,
	 R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en,
	 R10en, R11en, R12en, R13en, R14en, R15en, HIen, LOen, Zen,
	 Pen, MDRen, In_Porten, Cen, IRen, MARen, Yen, ZLOen, ZHIen, ZLOout, ZHIout, R0out, R1out, R2out, R3out, R4out, R5out, 
	 R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, MDROut,Pout, Cout, Outport, HIout, LOout, Yout,
	 Write, Read, Gra, Grb, Grc, Rin, Rout, BAout, ConIn; 

	reg [31:0] Mdatain;
	reg [4:0] alu_control;
	 
   parameter Default = 4'b0000; 
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
	 MDROut, Outport, LOout, ZHIout, ZLOout, Pout, Cout, Yout,
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
                T0 : Present_state = T1;
                T1 : Present_state = T2;
                T2 : Present_state = T3;
                T3 : Present_state = T4;
                T4 : Present_state = T5;
					 T5 : Present_state = T6;
            endcase
        end
		  
    always @(Present_state) // do the required job in each state
        begin
            case (Present_state) // assert the required signals in each clock cycle
            Default: begin
					clr<=0;
					R0en<=0; R1en<=0; R2en<=0; R3en<=0; R4en<=0; R5en<=0; R6en<=0; R7en<=0; R8en<=0; R9en<=0;
					R10en<=0; R11en<=0; R12en<=0; R13en<=0; R14en<=0; R15en<=0; HIen<=0; LOen<=0; ZHIen<=0; ZLOen<=0;
					Pen<=0; MDRen<=0; In_Porten<=0; Cen<=0; IRen<=0; MARen<=0; Yen<=0;
					R0out<=0; R1out<=0; R2out<=0; R3out<=0; R4out<=0; R5out<=0; R6out<=0; R7out<=0; R8out<=0; R9out<=0;
					R10out<=0; R11out<=0; R12out<=0; R13out<=0; R14out<=0; R15out<=0; ZHIout<=0; ZLOout<=0; Zen<=0;
					Pout<=0; MDROut<=0; Cout<=0; Outport<=0; 
					Read<=0; Write <= 0; Gra<=0; Grb<=0; Grc<=0; BAout<=0; ConIn<=0;
					Rin<=0; Rout<=0; BAout<=0;
 									alu_control<=5'b00000; Mdatain<=32'h00000000;
            end

            T0: begin 
				   #5 Pout <= 1;
					#5 MARen <= 1;
            end
            T1: begin
					#5 Pout <= 0;
					#5 Read <= 1;
					#5 MDRen <= 1;
				
            end
            T2: begin
				    Read <= 0;
					 MARen <= 0;
					 MDRen <= 0;
					 MDROut <= 1;
					 IRen <= 1;
					
            end
            T3: begin
					 MDROut <= 0;
					 IRen <= 0;
					 Grb <= 1;
					 Rout <= 1;
					 Yen <= 1;
				
            end
            T4: begin
					Grb <= 0;
					Rout <= 0;
					Yen <= 0;
					Cout <= 1;
					alu_control <= 5b'00011;
					Zen <= 1;
					
            end
            T5: begin
					Cout <= 0;
					Zen <= 0;
					ZLOout <= 1;
					Gra <= 1;
					Rin <= 1;
            end
            endcase
        end
endmodule