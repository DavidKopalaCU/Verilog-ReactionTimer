module clock_divider(
	input					clk,
	output				div_clk
);

reg [15:0] cnt;
reg clk_mem;
assign div_clk = clk_mem;

always @(posedge clk)

	if (cnt == 25000)
	begin
		cnt <= 0;
		clk_mem <= !clk_mem;
	end // if
	
	else
	begin
		cnt <= cnt + 1;
	end // else
	
endmodule
