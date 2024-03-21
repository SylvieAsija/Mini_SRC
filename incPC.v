module incPC(input [31:0] a, input clk, input reset, input en, output reg [31:0] BusMuxIn);

	initial begin
		BusMuxIn <= 32'b0;
	end

    always @ (posedge clk) begin
		if (reset) begin
			BusMuxIn <= 32'b0;
		end
		else if (en) begin
			BusMuxIn <= a;
		end
	end
    
endmodule