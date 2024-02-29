module memoryDataRegister (input clk, clr, MDRen, read, input [31:0] Mdatain,input [31:0] busMuxout,
	output wire [31:0] q
);

reg [31:0] d;
register r(clr, clk, MDRen, d, q);
always @ (*) begin
	if (read) d = Mdatain;
	else	d = busMuxout;
end
endmodule