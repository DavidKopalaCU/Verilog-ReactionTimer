module lfsr_nine(
	input						clk,
	output	reg	[0:2]	out
);

initial
	out = 1;

always @(posedge clk)
begin
	out <= {out[2], out[2] ^ out[0], out[1]};
end

endmodule
