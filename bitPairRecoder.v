module bitPairRecoder(input [31:0] inMultiplier, input [2:0] bitsToConvert, output [32:0] recodedOut)

always @ (*)
    case (bitsToConvert)
        // 3'b000, 3'b111: recodedOut [1:0] = 'b000 //0
        // 3'b001, 3'b010: recodedOut [1:0] = 'b001 //+1
        // 3'b011        : recodedOut [1:0] = 'b010 //+2
        // 3'b100        : recodedOut [1:0] = 'b110 //-2
        // 3'b101, 3'b110: recodedOut [1:0] = 'b101 //-1
        3'b000, 3'b111: recodedOut [32:0] = 33'b0
        3'b001, 3'b010: recodedOut [32:0] = {2'b0, inMultiplier [31:0]}
        3'b011        : recodedOut [32:0] = {1'b0, inMultiplier [31:0], 1'b0}
        3'b100        : recodedOut [32:0] = {1'b1, inMultiplier [31:0], 1'b0} 
        3'b101, 3'b110: recodedOut [32:0] = {1'b01} // will call negate operation on these once made
        default: recodedOut [1:0] = 'b000;
    endcase
endmodule