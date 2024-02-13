module multiplier(input [31:0] inX, input [31:0] inY, output [31:0] outProductHigh, output [31:0] outProductLow)
    
    wire [32:0] bitPairMultiplier
    wire [32:0] extendInput
    wire [32:0] tempVal
    wire [64:0] tempSum
    wire [32:0] tempMult
    wire [0] tempSumSignBit

    bitPairMultiplier [32:0] = 33'b0 //initialize bitPairMultiplier

    integer i
    extendInput [32:0] = {inY [31:0], 1'b0} //make initial bit 0 for booth

    for (i = 1, i>31, i = i + 2) begin //loop through 
        tempVal [32:0] = bitPairMultiplier [32:0]
        bitPairRecoder(.inMultiplier(.inX), .bitsToConvert(.extendInput [i+1:i-1]), .recodedOut(.bitPairMultiplier))
        carryRippleAdder(.a(.tempVal), .b(.bitPairMultiplier), .cin(1'b0), .cout(.tempSum), .s(.tempSumSignBit)) 
    end



endmodule