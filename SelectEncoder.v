//module SelectEncode(
//    input [31:0] IR,
//    input Gra, Grb, Grc, Rin, Rout, BAout,
//    output [31:0] C_sign,
//    output R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en, R10en, R11en, R12en, R13en, R14en, R15en,
//    output R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out
//);
//
////have two outputs instead
//wire [3:0] OpCode, Ra, Rb, Rc;
//reg [3:0] DecoderInput;
//reg [15:0] DecoderOutput;
//reg [15:0] Out;
//reg [31:0] C_sign_extended;
//reg [15:0] In;
//reg temp;
//integer i;
//
//// Gra or Grb or Grc
////assign OpCode = IR[31:27];
////assign Ra = ;
////assign Rb = ;
////assign Rc = ;
//
//
//always @ (*) begin
//
//    if(Gra == 1) begin 
//        DecoderInput <= Ra;
//	 end
//    else if(Grb == 1) begin 
//        DecoderInput <= Rb;
//	 end
//    else if(Grc == 1) begin 
//        DecoderInput <= Rc;
//	 end
//
//	 DecoderInput <= (IR[26:23] & {4{Gra}}) | (IR[22:19] & {4{Grb}}) | (IR[18:15] & {4{Grc}});
//
//    if(DecoderInput == 4'b0000) begin
//        DecoderOutput <= 16'b0000000000000001;
//    end
//    else if(DecoderInput == 4'b0001) begin
//        DecoderOutput <= 16'b0000000000000010;
//    end
//    else if(DecoderInput == 4'b0010) begin
//        DecoderOutput <= 16'b0000000000000100;
//    end
//    else if(DecoderInput == 4'b0011) begin
//        DecoderOutput <= 16'b0000000000001000;
//    end
//    else if(DecoderInput == 4'b0100) begin
//        DecoderOutput <= 16'b0000000000010000;
//    end
//    else if(DecoderInput == 4'b0101) begin
//        DecoderOutput <= 16'b0000000000100000;
//    end
//    else if(DecoderInput == 4'b0110) begin
//        DecoderOutput <= 16'b0000000001000000;
//    end
//    else if(DecoderInput == 4'b0111) begin
//        DecoderOutput <= 16'b0000000010000000;
//    end
//    else if(DecoderInput == 4'b1000) begin
//        DecoderOutput <= 16'b0000000100000000;
//    end
//    else if(DecoderInput == 4'b1001) begin
//        DecoderOutput <= 16'b0000001000000000;
//    end
//    else if(DecoderInput == 4'b1010) begin
//        DecoderOutput <= 16'b0000010000000000;
//    end
//    else if(DecoderInput == 4'b1011) begin
//        DecoderOutput <= 16'b0000100000000000;
//    end
//    else if(DecoderInput == 4'b1100) begin
//        DecoderOutput <= 16'b0001000000000000;
//    end
//    else if(DecoderInput == 4'b1101) begin
//        DecoderOutput <= 16'b0010000000000000;
//    end
//    else if(DecoderInput == 4'b1110) begin
//        DecoderOutput <= 16'b0100000000000000;
//    end
//    else if(DecoderInput == 4'b1111) begin
//        DecoderOutput <= 16'b1000000000000000;
//    end
//	 else begin 
//		DecoderOutput <= 16'b0000000000000000;
//	 end 
//    for (i = 0 ; i < 16 ; i = i + 1)
//        In[i] = DecoderOutput[i] & Rin;
//	 temp = Rout | BAout;
//    for (i = 0 ; i < 16 ; i = i + 1)
//        Out[i] = DecoderOutput[i] & temp;
//    C_sign_extended = {{13{IR[18]}}, {IR[18:0]}};
//	 
//end
////assign temp = Rout || BAout;
////assign C_sign_extended = {{13{IR[18]}}, {IR[18:0]}};
//assign {R15en, R14en, R13en, R12en, R11en, R10en, R9en, R8en, R7en, R6en, R5en, R4en, R3en, R2en, R1en, R0en} = In;
//assign {R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out} = Out;
//assign C_sign = {{13{IR[18]}}, IR[18:0]};
//
////SelectEncode SE (.Rout(R0out, R1Out, R2out, ...)
//
//endmodule



`timescale 1ns/10ps
module SelectEncoder(input [31:0] IR_out, input Gra, Grb, Grc, Rin, Rout, BAout, output [31:0] C_Sign_Extnd, output R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out, R15en, R14en, R13en, R12en, R11en, R10en, R9en, R8en, R7en, R6en, R5en, R4en, R3en, R2en, R1en, R0en);
wire [3:0] RA, RB, RC, R_dec_in;
wire [15:0] R_dec_out;
assign RA = IR_out[26:23] & {4{Gra}};
assign RB = IR_out[22:19] & {4{Grb}};
assign RC = IR_out[18:15] & {4{Grc}};
assign R_dec_in = RA | RB | RC;
decoder_4_16 DECOD(R_dec_in, R_dec_out);
assign C_Sign_Extnd = {{13{IR_out[18]}}, IR_out[18:0]}; 
assign {R15en, R14en, R13en, R12en, R11en, R10en, R9en, R8en, R7en, R6en, R5en, R4en, R3en, R2en, R1en, R0en} = {16{Rin}} & R_dec_out;
assign {R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out} = {16{Rout | BAout}} & R_dec_out;
endmodule



