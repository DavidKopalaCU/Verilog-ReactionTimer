module waiting_state(
	input						en,
	input 					clk,
	input				[1:0] KEY,
	output	wire	[9:0] LEDR,
	output	wire	[3:0] out_state
);

reg [10:0]	delay;
reg [10:0]	clk_cnt;
reg			started;
reg 			clk_done;

wire 			khz_clk;
clock_divider clk_div(clk, khz_clk);

wire [9:0]	l_out;
lfsr l(khz_clk, l_out);

always @(negedge en)
begin
	delay <= l_out + 1024;
end

assign LEDR = delay;//delay[9:0];

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

assign out_state = en ? ((clk_cnt == 0) ? 2 : KEY[1]) : 1;
//assign out_state = en ? ((KEY[1] == 0) : 2 : 1) : 1;

endmodule
