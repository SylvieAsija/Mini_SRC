module register_32(input [31:0] D, output [31:0] Q, input clear, clock, enable)
    
    reg [31:0] dataReg;
    initial begin
        dataReg [31:0] = 32'b0;
    end 

    always @ (posedge clock, negedge clear)
    
    if (clear) begin 
        dataReg[31:0] <= 32'b0;
    end
    else if (enable) begin
        dataReg[31:0] <= D[31:0]; 
    end

    assign Q[31:0] = dataReg[31:0];

endmodule