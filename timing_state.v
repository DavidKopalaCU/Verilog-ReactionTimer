module timing_state(
	input 					en,
	input 					clk,
	
	input				[1:0]	KEY,
	
	output	reg	[9:0] LEDR,
	
	output	wire	[7:0] HEX0,
	output	wire	[7:0] HEX1,
	output	wire	[7:0] HEX2,
	
	output	reg	[3:0]	score_a,
	output	reg	[3:0]	score_b,
	output	reg	[3:0]	score_c,
	
	output	wire	[3:0] out_state
);

wire khz_clk;

wire [3:0] cnt_a;
wire [3:0] cnt_b;
wire [3:0] cnt_c;

wire carry_a;
wire carry_b;
wire carry_c;

clock_divider clk_div(clk, khz_clk);
bcd_counter ca(khz_clk, !en, cnt_a, carry_a);
bcd_counter cb(carry_a, !en, cnt_b, carry_b);
bcd_counter cc(carry_b, !en, cnt_c, carry_c);

bcd_decoder da(cnt_a, 0, HEX0);
bcd_decoder db(cnt_b, 0, HEX1);
bcd_decoder dc(cnt_c, 0, HEX2);

always @(negedge en)
begin
	score_a <= cnt_a;
	score_b <= cnt_b;
	score_c <= cnt_c;
end

always @(posedge clk)
begin
	if (en)
		LEDR <= 10'h3ff;
	else
		LEDR <= 0;
end

assign out_state = (en && !KEY[0]) ? 3 : 2;

endmodule