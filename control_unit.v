`timescale 1ns/10ps

module control_unit (
    output reg PCout, ZHIen, ZLOen, ZHIout, ZLOout, MDROut, MARen, MDRen, Pen, IRen, Yen, Pout, Read,
               HIen, LOen, HIout, LOout, Cout, Write, Gra, Grb, Grc, Rin, Rout, BAout, 
               ConIn, In_Porten, Out_Porten, InPortout, Outport, Zin, Run, incPC,
    input [31:0] BusMuxInIR,
    input clock, reset, stop);

parameter reset_state = 8'h00, fetch0 = 8'h01, fetch1 = 8'h02, fetch2 = 8'h03,
          add3 = 8'h04, add4 = 8'h05, add5 = 8'h06, 
          sub3 = 8'h07, sub4 = 8'h08, sub5 = 8'h09, 
          mul3 = 8'h0A, mul4 = 8'h0B, mul5 = 8'h0C, mul6 = 8'h0D,
          div3 = 8'h0E, div4 = 8'h0F, div5 = 8'h10, div6 = 8'h11,
          shr3 = 8'h12, shr4 = 8'h13, shr5 = 8'h14,
          shra3 = 8'h15, shra4 = 8'h16, shra5 = 8'h17,
          shl3 = 8'h18, shl4 = 8'h19, shl5 = 8'h1A,
          ror3 = 8'h1B, ror4 = 8'h1C, ror5 = 8'h1D,
          rol3 = 8'h1E, rol4 = 8'h1F, rol5 = 8'h20,
          neg3 = 8'h21, neg4 = 8'h22,
          not3 = 8'h23, not4 = 8'h24,
          or3 = 8'h25, or4 = 8'h26, or5 = 8'h27,
          and3 = 8'h28, and4 = 8'h29, and5 = 8'h2A,
          ld3 = 8'h2B, ld4 = 8'h2C, ld5 = 8'h2D, ld6 = 8'h2E, ld7 = 8'h2F,
          ldi3 = 8'h30, ldi4 = 8'h31, ldi5 = 8'h32,
          st3 = 8'h33, st4 = 8'h34, st5 = 8'h35, st6 = 8'h36, st7 = 8'h37,
          addi3 = 8'h38, addi4 = 8'h39, addi5 = 8'h3A,
          andi3 = 8'h3B, andi4 = 8'h3C, andi5 = 8'h3D,
          ori3 = 8'h3E, ori4 = 8'h3F, ori5 = 8'h40,
          br3 = 8'h41, br4 = 8'h42, br5 = 8'h43, br6 = 8'h44, br7 = 8'h45,
          jr3 = 8'h46,
          jal3 = 8'h47, jal4 = 8'h48,
          mfhi3 = 8'h49,
          mflo3 = 8'h4A,
          in3 = 8'h4B,
          out3 = 8'h4C,
          nop3 = 8'h4D,
          halt3 = 8'h4E;

reg [7:0] present_state = reset_state;

always @ (posedge clock, posedge reset) begin
    if (reset) present_state = reset_state;
    if (stop) present_state = halt3;
    else case (present_state)
        reset_state : present_state = fetch0;
        fetch0      : present_state = fetch1;
        fetch1      : present_state = fetch2;
        fetch2      : begin
                        @ (posedge clock);
                        case (BusMuxInIR[31:27])
                            5'b00011 : present_state = add3;
                            5'b00100 : present_state = sub3;
                            5'b01111 : present_state = mul3;
                            5'b10000 : present_state = div3;
                            5'b00101 : present_state = shr3;
                            5'b00110 : present_state = shra3;
                            5'b00111 : present_state = shl3;
                            5'b01000 : present_state = ror3;
                            5'b01001 : present_state = rol3;
                            5'b10001 : present_state = neg3;
                            5'b10010 : present_state = not3;
                            5'b01011 : present_state = or3;
                            5'b01010 : present_state = and3;
                            5'b00000 : present_state = ld3;
                            5'b00001 : present_state = ldi3;
                            5'b00010 : present_state = st3;
                            5'b01100 : present_state = addi3;
                            5'b01101 : present_state = andi3;
                            5'b01110 : present_state = ori3;
                            5'b10011 : present_state = br3;
                            5'b10100 : present_state = jr3;
                            5'b10101 : present_state = jal3;
                            5'b11000 : present_state = mfhi3;
                            5'b11001 : present_state = mflo3;
                            5'b10110 : present_state = in3;
                            5'b10111 : present_state = out3;
                            5'b11010 : present_state = nop3;
                            5'b11011 : present_state = halt3;
                        endcase
                    end
    add3 : present_state = add4;
    add4 : present_state = add5;
    add5 : present_state = fetch0;

    sub3 : present_state = sub4;
    sub4 : present_state = sub5;
    sub5 : present_state = fetch0;

    mul3 : present_state = mul4;
    mul4 : present_state = mul5;
    mul5 : present_state = mul6;
    mul6 : present_state = fetch0;

    div3 : present_state = div4;
    div4 : present_state = div5;
    div5 : present_state = div6;
    div6 : present_state = fetch0;

    shr3 : present_state = shr4;
    shr4 : present_state = shr5;
    shr5 : present_state = fetch0;

    shra3 : present_state = shra4;
    shra4 : present_state = shra5;
    shra5 : present_state = fetch0;

    shl3 : present_state = shl4;
    shl4 : present_state = shl5;
    shl5 : present_state = fetch0;

    ror3 : present_state = ror4;
    ror4 : present_state = ror5;
    ror5 : present_state = fetch0;

    rol3 : present_state = rol4;
    rol4 : present_state = rol5;
    rol5 : present_state = fetch0;

    neg3 : present_state = neg4;
    neg4 : present_state = fetch0;

    not3 : present_state = not4;
    not4 : present_state = fetch0;

    or3 : present_state = or4;
    or4 : present_state = or5;
    or5 : present_state = fetch0;

    and3 : present_state = and4;
    and4 : present_state = and5;
    and5 : present_state = fetch0;

    ld3 : present_state = ld4;
    ld4 : present_state = ld5;
    ld5 : present_state = ld6;
    ld6 : present_state = ld7;
    ld7 : present_state = fetch0;

    ldi3 : present_state = ldi4;
    ldi4 : present_state = ldi5;
    ldi5 : present_state = fetch0;

    st3 : present_state = st4;
    st4 : present_state = st5;
    st5 : present_state = st6;
    st6 : present_state = st7;
    st7 : present_state = fetch0;

    addi3 : present_state = addi4;
    addi4 : present_state = addi5;
    addi5 : present_state = fetch0;

    andi3 : present_state = andi4;
    andi4 : present_state = andi5;
    andi5 : present_state = fetch0;

    ori3 : present_state = ori4;
    ori4 : present_state = ori5;
    ori5 : present_state = fetch0;

    br3 : present_state = br4;
    br4 : present_state = br5;
    br5 : present_state = br6;
    br6 : present_state = fetch0;

    jr3 : present_state = fetch0;

    jal3 : present_state = fetch0;

    mfhi3 : present_state = fetch0;

    mflo3 : present_state = fetch0;

    in3 : present_state = fetch0;

    out3 : present_state = fetch0;

    nop3 : present_state = fetch0;

    halt3 : present_state = fetch0;

    endcase

end

always @ (present_state)
begin
    case(present_state)
        reset_state: begin
            Run<=1;Gra<=0;Grb<=0;Grc<=0;Yen<=0;Pout<=0;ZHIout<=0;ZLOout<=0;MDROut<=0;MARen<=0;
            Pen<=0;MDRen<=0;IRen<=0;Yen<=0;PCout<=0;Read<=0;HIen<=0;LOen<=0;HIout<=0;LOout<=0;
            ZHIen<=0;ZLOen<=0;Cout<=0;Write<=0;Rin<=0;Rout<=0;BAout<=0;ConIn<=0;In_Porten<=0;
            Out_Porten<=0;InPortout<=0;Outport<=0;
        end

        fetch0 : begin 
            PCout<=1;MARen<=1;Pout<=1;Zin<=1;
        end

        fetch1 : begin
            PCout<=0;MARen<=0;Pout<=0;Zin<=0;
            MDRen<=1;Read<=1;ZLOout<=1;
        end

        fetch2 : begin
            MDRen<=0;Read<=0;ZLOout<=0;
            MDROut<=1;IRen<=1;Pen<=1;incPC<=1;
            #20 Pen<=0;
        end
        
        //-------------------------------------------------------------\\
        add3, sub3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Grb<=1;Rout<=1;Yen<=1;
        end

        add4, sub4 : begin
            Grb<=0;Rout<=0;Yen<=0;
            Grc<=1;Rout<=1;ZHIen<=1;ZLOen<=1;
        end

        add5, sub5 : begin
            Grc<=0;Rout<=0;ZHIen<=0;ZLOen<=0;
            ZLOout<=1;Gra<=1;Rin<=1;
        end

        //-------------------------------------------------------------\\
        mul3, div3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Grb<=1;Rout<=1;Yen<=1;
        end

        mul4, div4 : begin
            Grb<=0;Rout<=0;Yen<=0;
            Grc<=1;Rout<=1;ZHIen<=1;ZLOen<=1;
        end

        mul5, div5 : begin
            Grc<=0;Rout<=0;ZHIen<=0;ZLOen<=0;
            ZLOout<=1;LOen<=1;
        end

        mul6, div6 : begin
            ZLOen<=0;LOen<=0;
            ZHIen<=0;HIen<=1;
        end

        //-------------------------------------------------------------\\
        or3, and3, shr3, shra3, shl3, ror3, rol3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Grb<=1;Rout<=1;Yen<=1;
        end

        or4, and4, shr4, shra4, shl4, ror4, rol4 : begin
            Grb<=0;Rout<=0;Yen<=0;
            Grc<=1;Rout<=1;ZHIen<=1;ZLOen<=1;
        end

        or5, and5, shr5, shra5, shl5, ror5, rol5 : begin
            Grc<=0;Rout<=0;ZHIen<=0;ZLOen<=0;
            ZLOout<=1;Gra<=1;Rin<=1;
            #20 ZLOout<=0;Gra<=1;Rin<=0;Rout<=1;
        end

        //-------------------------------------------------------------\\
        not3, neg3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Grb<=1;Rout<=1;Yen<=1;
        end

        not4, neg4 : begin
            Grb<=0;Rout<=0;Yen<=0;
            Gra<=1;ZLOout<=1;Rin<=1;
        end

        //-------------------------------------------------------------\\
        andi3, andi3, ori3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Grb<=1;Rout<=1;Yen<=1;
        end

        andi4, andi4, ori4 : begin
            Grb<=0;Rout<=0;Yen<=0;
            Cout<=1;ZHIen<=1;ZLOen<=1;
        end

        andi5, andi5, ori5 : begin
            Cout<=0;ZHIen<=0;ZLOen<=0;
            ZLOout<=1;Gra<=1;Rin<=1;
            #20 ZLOout<=0;Gra<=0;Rin<=0;Rout<=1;
        end

        //-------------------------------------------------------------\\
        ld3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Grb<=1;BAout<=1;Yen<=1;
        end
    
        ld4 : begin
            Grb<=0;Rout<=0;Yen<=0;
            Cout<=1;ZHIen<=1;ZLOen<=1;            
        end

        ld5 : begin
            Cout<=0;ZHIen<=0;ZLOen<=0;            
            ZLOout<=1;MARen<=1;
        end

        ld6 : begin
            ZLOout<=0;MARen<=0;
            Read<=1;MDRen<=1;
        end

        ld7 : begin
            Read<=0;MDRen<=0;
            MDROut<=1;Gra<=1;Rin<=1;
        end

        //-------------------------------------------------------------\\
        ldi3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Grb<=1;BAout<=1;Yen<=1;
        end

        ldi4 : begin
            Grb<=0;BAout<=0;Yen<=0;
            Cout<=1;ZHIen<=1;ZLOen<=1;
        end

        ldi5 : begin
            Cout<=0;ZHIen<=0;ZLOen<=0;
            #20 ZLOout<=1;Gra<=1;Rin<=1;
        end

        //-------------------------------------------------------------\\
        st3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Grb<=1;BAout<=1;Yen<=1;
        end

        st4 : begin
            Grb<=0;BAout<=0;Yen<=0;
            Cout<=1;ZHIen<=1;ZLOen<=1;
        end

        st5 : begin
            Cout<=0;ZHIen<=0;ZLOen<=0;
            ZLOout<=1;MARen<=1;
        end

        st6 : begin
            ZLOout<=0;MARen<=0;
            Read<=0;Gra<=0;Rout<=0;MDRen<=0;
        end

        st7 : begin
            Gra<=0;Rout<=0;MDRen<=0;
            MDROut<=1;
            #10 Pen<=0;
        end

        //-------------------------------------------------------------\\
        jr3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Gra<=1;Rout<=1;Pen<=1;
            #20 Pen<=0;
        end

        //-------------------------------------------------------------\\
        jal3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            PCout<=1;
        end

        jal4: begin
            PCout<=0;Gra<=1;Rout<=1;Pen<=1;
        end

        //-------------------------------------------------------------\\
        mfhi3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Gra<=1;Rin<=1;HIout<=1;
            #20 Gra<=0;Rin<=0;HIout<=0;
        end

        //-------------------------------------------------------------\\
        mflo3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Gra<=1;Rin<=1;LOout<=1;
            #20 Gra<=0;Rin<=0;LOout<=0;
        end

        //-------------------------------------------------------------\\
        in3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Gra<=1;Rin<=1;InPortout<=1;
        end

        //-------------------------------------------------------------\\
        out3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Gra<=0;Rout<=1;Yen<=1;Out_Porten<=1;
        end

        //-------------------------------------------------------------\\
        br3 : begin
            MDROut<=0;IRen<=0;Pen<=0;incPC<=0;
            Gra<=1;Rout<=1;ConIn<=1;
        end

        br4 : begin
            Gra<=0;Rout<=0;ConIn<=0;
            PCout<=1;Yen<=1;
        end

        br5: begin
            PCout<=0;Yen<=0;
            Cout<=1;ZHIen<=1;ZLOen<=1;
        end

        br6 : begin
            Cout<=0;ZHIen<=0;ZLOen<=0;
            ZLOout<=1;Pen<=1;
        end

        br7 : begin
            ZLOout<=0;Pen<=0;
            PCout<=1;
        end

        //-------------------------------------------------------------\\
        nop3 : begin
        end
        
        //-------------------------------------------------------------\\
        halt3 : begin
            Run<=0;
        end

        default:begin end
    endcase
end
endmodule