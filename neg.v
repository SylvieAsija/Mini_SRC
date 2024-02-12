module neg (input [31:0] inToNegate, output [31:0] negatedOutHigh, negatedOut)
        wire [31:0] inverse, sum
        wire [0] carryBit
        inverse [31:0] = ~inToNegate
        carryRippleAdder(.a(.inverse), .b(1'b1), .cin(1'b0), .s(.sum), .c(.carryBit))

        negatedOutHigh [31:0] = 32{carryBit}
        negatedOutLow  [31:0] = sum

endmodule