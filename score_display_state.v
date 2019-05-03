module score_display_state(
	input					en,
	input						clk,
	input				[1:0]	KEY,
	
	input				[3:0] score_a,
	input				[3:0] score_b,
	input				[3:0] score_c,
	input				[3:0] score_d,
	
	output	wire	[7:0] HEX0,
	output	wire	[7:0] HEX1,
	output	wire	[7:0] HEX2,
	output	wire	[7:0] HEX3,
	
	output	reg	[3:0] out_state
);

wire khz_clk;
clock_divider kc(clk, khz_clk);

bcd_decoder(score_a, 0, HEX0);
bcd_decoder(score_b, 0, HEX1);
bcd_decoder(score_c, 0, HEX2);
bcd_decoder(score_d, 1, HEX3);

reg [15:0] clk_cnt;
always @(posedge khz_clk)
begin
	if (!en)
	begin
		clk_cnt <= 0;
		out_state <= 3;
	end
	else
	begin
		if (clk_cnt == 3000)
			out_state <= 4;
		else
		begin
			out_state <= 3;
			clk_cnt = clk_cnt + 1;
		end
	end
end

endmodule
