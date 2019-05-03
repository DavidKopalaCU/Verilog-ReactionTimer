module high_score_state(
	input 					en,
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
	
	output	wire	[3:0] out_state
);

reg [3:0] high_a;
reg [3:0] high_b;
reg [3:0] high_c;
reg [3:0] high_d;

always @(posedge en)
begin
	if ({score_d, score_c, score_b, score_a} < {high_d, high_c, high_b, high_a} || {high_d, high_c, high_b, high_a} == 0)
	begin
		high_a <= score_a;
		high_b <= score_b;
		high_c <= score_c;
		high_d <= score_d;
	end
end

bcd_decoder(high_a, 0, HEX0);
bcd_decoder(high_b, 0, HEX1);
bcd_decoder(high_c, 0, HEX2);
bcd_decoder(high_d, 1, HEX3);
//bcd_decoder(score_a, 0, HEX0);
//bcd_decoder(score_b, 0, HEX1);
//bcd_decoder(score_c, 0, HEX2);

wire khz_clk;
clock_divider clk_div(clk, khz_clk);

reg [15:0]	delay;
reg [15:0]	clk_cnt;
reg			started;

reg clk_done;

always @(negedge en)
begin
	delay <= 16'd3000;
end

always @(posedge khz_clk)
begin

	if (!en)
	begin
		clk_done <= 0;
		clk_cnt <= delay;
		started <= 0;
	end
	else if (started == 0)
	begin
		clk_cnt <= delay;
		started <= 1;
	end
	
	else
	begin
		if (clk_cnt == 0)
		begin
			clk_done <= 1;
		end
		else
		begin
			clk_cnt <= clk_cnt - 1;
		end
	end
end

assign out_state = en ? ((clk_cnt == 0) ? 0 : 4) : 4;

endmodule
