module RAM (input read, write, clock, input [8:0] address, input [31:0] ramDataIn, output reg [31:0] ramDataOut);
    reg [31:0] memory [0:511];
	 
	 initial begin
		$readmemh("lab.hex", memory);
	 end

    always @ (posedge clock) begin //some places online write on posedge clock, and also have a reset, used generic for now
        if (write == 1)
            memory[address] <= ramDataIn;
        else if (read == 1)
            ramDataOut <= memory[address];
    end
endmodule