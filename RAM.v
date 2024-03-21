module RAM (input read, write, clock, input [8:0] address, input [31:0] ramDataIn, output reg [31:0] ramDataOut);
    reg [31:0] memory [0:511];
	 
	 initial begin
		memory[0] <= 32'h01000095;
		memory[149] <= 32'h000000FF;
	 end

    always @ (posedge clock) begin //some places online write on posedge clock, and also have a reset, used generic for now
        if (write == 1) begin
            memory[address] <= ramDataIn;
			end

         ramDataOut <= memory[address];
			$display (memory[address]);
			$display (address);

    end
endmodule