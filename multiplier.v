module multiplier(input [31:0] inX, input [31:0] inY, output [31:0] outProduct)
    
    wire [2:0] signedBitPair
    wire [32:0] extendInput
    integer i

    extendInput [32:0] = {inY [31:0], 1'b0} //make initial bit 0 for booth

    for (i = 1, i>31, i = i + 2) begin
        bitPairRecoder(.bitsToConvert(.extendInput [i+1:i-1]), .recodedOut(.signedBitPair))
        
    end



endmodule