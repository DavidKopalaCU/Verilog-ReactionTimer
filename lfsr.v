module lfsr(
	input 					clk,
	output	reg	[9:0] out
);

wire linear_feedback;
assign linear_feedback = (out[2] ^ out[9]);

initial
begin
	out = 1;
end
always @(posedge clk)
begin
	out = {
		out[8],
		out[7],
		out[6],
		out[5],
		out[4],
		out[3],
		out[2],
		out[1],
		out[0],
		linear_feedback
	};
end

endmodule
