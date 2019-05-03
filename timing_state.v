module timing_state(
	input 					en,
	input 					clk,
	
	input				[1:0]	KEY,
	input				[9:0] SW,
	
	output	reg	[9:0] LEDR,
	
	output	wire	[7:0] HEX0,
	output	wire	[7:0] HEX1,
	output	wire	[7:0] HEX2,
	output	wire	[7:0] HEX3,
	
	output	reg	[3:0]	score_a,
	output	reg	[3:0]	score_b,
	output	reg	[3:0]	score_c,
	output	reg	[3:0] score_d,
	
	output	wire	[3:0] out_state
);

wire khz_clk;

wire [3:0] cnt_a;
wire [3:0] cnt_b;
wire [3:0] cnt_c;
wire [3:0] cnt_d;

wire carry_a;
wire carry_b;
wire carry_c;
wire carry_d;

clock_divider clk_div(clk, khz_clk);
bcd_counter ca(khz_clk, !en, cnt_a, carry_a);
bcd_counter cb(carry_a, !en, cnt_b, carry_b);
bcd_counter cc(carry_b, !en, cnt_c, carry_c);
bcd_counter cd(carry_c, !en, cnt_d, carry_d);

bcd_decoder da(cnt_a, 0, HEX0);
bcd_decoder db(cnt_b, 0, HEX1);
bcd_decoder dc(cnt_c, 0, HEX2);
bcd_decoder dz(cnt_d, 1, HEX3);

wire 	[2:0] l_out;
reg	[3:0] l_mem;
lfsr_nine lnine(khz_clk, l_out);

wire [7:0] eight_dec;
three_to_eight_decoder ted(l_mem, eight_dec);

always @(negedge en)
begin
	score_a <= cnt_a;
	score_b <= cnt_b;
	score_c <= cnt_c;
	score_d <= cnt_d;
end

always @(posedge clk)
begin
	if (en)
//		LEDR <= 10'h3ff;
		LEDR <= { 2'd0, eight_dec };
	else
	begin
		LEDR <= 0;
		l_mem <= l_out;
	end
end

assign out_state = (en && (SW == { 2'd0, eight_dec })) ? 3 : 2;
//assign out_state = (en && !KEY[0]) ? 3 : 2;

endmodule