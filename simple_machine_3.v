module simple_machine_3 (
	input						clk,
	input						reset,
	
	input				[1:0] KEY,
	input				[9:0] SW,
	output	reg	[9:0] LEDR,
	output	wire	[7:0] HEX5,
	output	wire	[7:0] HEX4,
	output	reg	[7:0] HEX3,
	output	reg	[7:0] HEX2,
	output	reg	[7:0] HEX1,
	output	reg	[7:0] HEX0
);

reg [3:0] state;

reg 			a_enable;
wire [9:0]	a_ledr;
wire [3:0]	a_out_state;
default_state a(a_enable, clk, KEY, a_ledr, a_out_state);

reg 			b_enable;
wire [9:0]	b_ledr;
wire [3:0]	b_out_state;
waiting_state b(b_enable, clk, KEY, b_ledr, b_out_state);

reg			c_enable;
wire	[9:0] c_ledr;
wire	[3:0]	c_out_state;
wire	[7:0] c_HEX3;
wire	[7:0] c_HEX2;
wire	[7:0] c_HEX1;
wire	[7:0] c_HEX0;
wire	[3:0]	c_score_a;
wire	[3:0]	c_score_b;
wire	[3:0]	c_score_c;
wire	[3:0]	c_score_d;
timing_state c(c_enable, clk, KEY, SW, c_ledr, c_HEX0, c_HEX1, c_HEX2, c_HEX3, c_score_a, c_score_b, c_score_c, c_score_d, c_out_state);

reg d_enable;
wire	[7:0] d_HEX0;
wire	[7:0] d_HEX1;
wire	[7:0] d_HEX2;
wire	[7:0] d_HEX3;
wire	[3:0] d_out_state;
score_display_state d(d_enable, clk, KEY, c_score_a, c_score_b, c_score_c, c_score_d, d_HEX0, d_HEX1, d_HEX2, d_HEX3, d_out_state);

reg e_enable;
wire	[7:0] e_HEX0;
wire	[7:0] e_HEX1;
wire	[7:0] e_HEX2;
wire	[7:0] e_HEX3;
wire	[3:0] e_out_state;
high_score_state e(e_enable, clk, KEY, c_score_a, c_score_b, c_score_c, c_score_d, e_HEX0, e_HEX1, e_HEX2, e_HEX3, e_out_state);

bcd_decoder bs(state, 1, HEX5);
bcd_decoder ba(10, 0, HEX4);

wire reset_line;
assign reset_line = !KEY[1];

always @(posedge clk)// or negedge reset_line) //(posedge KEY[0], posedge KEY[1])
begin

	if (!reset_line)
	begin
	
		if (state == 0)
		begin                                                                                                                                                                                                                                                                                                                      
			a_enable <= 1;
			b_enable <= 0;
			c_enable <= 0;
			d_enable <= 0;
			e_enable <= 0;
			if (1)//SW[0])
			begin
				if (a_out_state == 1)
					state = 1;
				else
					state = 0;
	//			state <= a_out_state;
			end
		end
		else if (state == 1)
		begin
			a_enable <= 0;
			b_enable <= 1;
			c_enable <= 0;
			d_enable <= 0;
			e_enable <= 0;
			if (1)//SW[1])
			begin
				if (b_out_state == 2)
					state <= 2;
				else if (b_out_state == 0)
					state <= 0;
				else
					state <= 1;
			end
	//			state <= b_out_state;
		end
		else if (state == 2)
		begin
			a_enable <= 0;
			b_enable <= 0;
			c_enable <= 1;
			d_enable <= 0;
			e_enable <= 0;
			if (1)//SW[2])
			begin
				if (c_out_state == 3)
					state <= 3;
				else
					state <= 2;
			end
	//			state <= c_out_state;
		end
		else if (state == 3)
		begin
			a_enable <= 0;
			b_enable <= 0;
			c_enable <= 0;
			d_enable <= 1;
			e_enable <= 0;
			if (1)//SW[3])
			begin
				if (d_out_state == 4)
					state <= 4;
				else
					state <= 3;
			end
		end
		else if (state == 4)
		begin
			a_enable <= 0;
			b_enable <= 0;
			c_enable <= 0;
			d_enable <= 0;
			e_enable <= 1;
			if (1)//SW[4])
			begin
				if (e_out_state == 0)
					state <= 0;
				else
					state <= 4;
			end
		end
		else
			state <= 0;
	end
	
	else
		state <= 0;
end // transition

always @(*)
begin

	if (state == 0)
	begin
		LEDR <= a_ledr;
		HEX0 <= 8'hff;
		HEX1 <= 8'hff;
		HEX2 <= 8'hff;
		HEX3 <= 8'hff;
	end
	else if (state == 1)
	begin
		LEDR <= b_ledr;
		HEX0 <= 8'hff;
		HEX1 <= 8'hff;
		HEX2 <= 8'hff;
		HEX3 <= 8'hff;
	end
	else if (state == 2)
	begin
		LEDR <= c_ledr;
		HEX0 <= c_HEX0;
		HEX1 <= c_HEX1;
		HEX2 <= c_HEX2;
		HEX3 <= c_HEX3;
	end
	else if (state == 3)
	begin
//		LEDR <= d_LEDR;
		LEDR <= 0;
		HEX0 <= d_HEX0;
		HEX1 <= d_HEX1;
		HEX2 <= d_HEX2;
		HEX3 <= d_HEX3;
	end
	else if (state == 4)
	begin
		LEDR <= 0;
		HEX0 <= e_HEX0;
		HEX1 <= e_HEX1;
		HEX2 <= e_HEX2;
		HEX3 <= e_HEX3;
	end
	else
	begin
		LEDR <= 0;
		HEX0 <= 8'hff;
		HEX1 <= 8'hff;
		HEX2 <= 8'hff;
		HEX3 <= 8'hff;
	end
end // mux


endmodule
