module memoryDataRegister (input clk, clr, MDRen, MDROut, read, input [31:0] Mdatain,input [31:0] busMuxout,
	output wire [31:0] q
);
wire [31:0] d;

if(MDRen) begin
	d = Mdatain
	register r1(clr, clk, MDRen, d, q);
end
else if (MDROut) begin
	d = busMuxout
	register r(clr, clk, MDROut, d, q);
end

//assign d = read ? Mdatain : busMuxout;
//register r(clr, clk, MDRen, d, q);
endmodule
