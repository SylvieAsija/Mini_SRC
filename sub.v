//module sub (input [31:0] a, b, output [31:0] d, carryOut)
//        wire [31:0] difference
//        wire [31:0] negBHigh, negBLow
//        wire [0] carryBit
//
//        neg(.inToNegate(.b), .negatedOutHigh(.negBHigh), .negatedOutLow(.negBLow))
//
//        carryRippleAdder(.a(.a), .b(.negBLow), .cin(1'b0), .s(.difference), .cout(.carryBit))
//
//        d [31:0] = difference [31:0]
//        carryOut [31:0]= 32{carryBit}
//
//endmodule