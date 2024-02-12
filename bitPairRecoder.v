module bitPairRecoder(input [31:0] inMultiplier, input [2:0] bitsToConvert, output [32:0] recodedOutHigh, recodedOutLow)

wire [31:0] tempHigh, tempLow

always @ (*)
    case (bitsToConvert)
        // 3'b000, 3'b111: recodedOut [1:0] = 'b000 //0
        // 3'b001, 3'b010: recodedOut [1:0] = 'b001 //+1
        // 3'b011        : recodedOut [1:0] = 'b010 //+2
        // 3'b100        : recodedOut [1:0] = 'b110 //-2
        // 3'b101, 3'b110: recodedOut [1:0] = 'b101 //-1
        3'b000, 3'b111: recodedOut [32:0] = 33'b0                                           //0
        3'b001, 3'b010: recodedOut [32:0] = {2'b0, inMultiplier [31:0]}                     //+1
        3'b011        : recodedOut [32:0] = {1'b0, inMultiplier [31:0], 1'b0}               //+2
        3'b100        : begin                                                               //-2
                            neg(.inToNegate(.inMultiplier), .negatedOutHigh(.tempHigh), .negatedOutLow(.tempLow))
                            recodedOutHigh [31:0] = {30'b1, tempHigh[0]}
                            recodedOutLow [31:0] = {tempLow, 1'b0}
                        end
        3'b101, 3'b110: recodedOut [32:0] = {1'b01, neg(.inToNegate(.inMultiplier))}        //-1                   //-1 
        default: recodedOut [1:0] = 33'b0;
    endcase
endmodule