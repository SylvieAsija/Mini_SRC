//module neg (input [31:0] inToNegate, output [31:0] negatedOut)
//        wire [31:0] inverse, sum
//        wire [0] carryBit
//        inverse [31:0] = ~inToNegate
//        carryRippleAdder cra(.a(.inverse), .b(1'b1), .cin(1'b0), .s(.sum), .c(.carryBit))
//
//        negatedOut [31:0] = sum [31:0]
//
//endmodule