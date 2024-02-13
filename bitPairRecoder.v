//module bitPairRecoder(input [31:0] inMultiplier, input [2:0] bitsToConvert, output [31:0] recodedOutHigh, recodedOutLow)
//
//wire [31:0] tempNeg
//neg negation (.inToNegate(.inMultiplier), 
//                    .negatedOut(.tempNeg))
//
//
//always @ (*)
//    case (bitsToConvert)
//        // 3'b000, 3'b111: recodedOut [1:0] = 'b000 //0
//        // 3'b001, 3'b010: recodedOut [1:0] = 'b001 //+1
//        // 3'b011        : recodedOut [1:0] = 'b010 //+2
//        // 3'b100        : recodedOut [1:0] = 'b110 //-2
//        // 3'b101, 3'b110: recodedOut [1:0] = 'b101 //-1
//        3'b000, 3'b111: begin
//                            recodedOutHigh  [31:0] = 32'b0
//                            recodedOutLow   [31:0] = 32'b0
//                        end   //0
//
//        3'b001, 3'b010: begin
//                            recodedOutHigh  [31:0] = 32{inMultiplier [31]}
//                            recodedOutLow   [31:0] = inMultiplier [31:0]
//                        end   //+1
//        
//        
//        3'b011        : begin
//                            recodedOutHigh  [31:0] = 32{inMultiplier [31]}
//                            recodedOutLow   [31:0] = {inMultiplier [30:0], 1'b0}
//                        end   //+2
//        
//        
//        3'b100        : begin                                                             
//                            recodedOutHigh [31:0] = {30'b1, tempHigh[0]}
//                            recodedOutLow [31:0] = {tempLow, 1'b0}
//                        end   //-2
//
//        3'b101, 3'b110: begin
//                            neg negation(.inToNegate(.inMultiplier), .negatedOut(.tempNeg))
//                        end      //-1 
//        default: recodedOut [1:0] = 33'b0;
//    endcase
//endmodule