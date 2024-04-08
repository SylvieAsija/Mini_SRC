module memoryDataRegister (input clk, clr, MDRen, read, input [31:0] Mdatain,input [31:0] busMuxout,
	output wire [31:0] q
);

wire [31:0] d;
assign d = read ? Mdatain : busMuxout;
register r(clr, clk, MDRen, d, q);
endmodule