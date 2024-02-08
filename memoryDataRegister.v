module memoryDataRegister(input [31:0] BusMuxOut, input [31:0] Mdatain, output [31:0] out, input read, clear, clock, MDRin)

    reg [31:0] memDataReg;

    assign out[31:0] = memDataReg;

    always @(*) begin
        if (read == 0) begin
            memDataReg[31:0] <= BusMuxOut[31:0]; 
        end
        else if (read == 1) begin
            memDataReg[31:0] <= Mdatain[31:0];
        end
    end

endmodule