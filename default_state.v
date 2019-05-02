module default_state(
	input						en,
	input 					clk,
	input				[1:0] KEY,
	output	reg	[9:0] LEDR,
	output	wire	[3:0] out_state
);

//assign LEDR = 10'h2AA;
reg dir;
reg sw_db;

reg [20:0] clk_cnt;
always @(posedge clk)
begin
	if (clk_cnt == 22'h1fffff || !en)
		clk_cnt = 0;
	else
		clk_cnt = clk_cnt + 1;
	
end // clk

always @(posedge clk_cnt[20])
begin
	if (LEDR == 0)
		LEDR <= 1;
	else
	begin
		if (dir == 1)
			LEDR = LEDR >> 1;
		else
			LEDR = LEDR << 1;
			
		if (LEDR == 1 || LEDR == 10'b1000000000)
			dir = !dir;
	end
end

assign out_state = en ? !KEY[0] : 0;

endmodule
