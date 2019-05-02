module finite_state_machine(
	input				[1:0]		KEY,
	output	reg	[9:0]		LEDR,
	output	reg	[7:0]		HEX0,
	output	reg	[7:0]		HEX1,
	output	reg	[7:0]		HEX2,
	output	wire	[7:0]		HEX3,
	output	wire	[7:0]		HEX4,
	output	wire	[7:0]		HEX5
);

wire [3:0] state_index;

wire [3:0] default_out_state;
wire [9:0] default_out_ledr;
wire [7:0] d_HEX0, d_HEX1, d_HEX2, d_HEX3, d_HEX4, d_HEX5;
default_case d_case(state_index, KEY, default_out_ledr, d_HEX0, d_HEX1, d_HEX2, d_HEX3, d_HEX4, d_HEX5);

wire [3:0] zero_out_state;
wire [9:0] zero_out_ledr;
wire [7:0] z_HEX0, z_HEX1, z_HEX2, z_HEX3, z_HEX4, z_HEX5;
zero_state z_case(state_index, KEY, zero_out_ledr, z_HEX0, z_HEX1, z_HEX2, z_HEX3, z_HEX4, z_HEX5);

always @(state_index)
begin

	case(state_index)
		0: begin 
			LEDR <= default_out_ledr;
			HEX0 <= d_HEX0;
			HEX1 <= d_HEX1;
			HEX2 <= d_HEX2;
//			HEX3 = d_HEX3;
//			HEX4 = d_HEX4;
//			HEX5 = d_HEX5;
//			state_index <= default_out_state;
		end
		1: begin
			LEDR <= zero_out_ledr;
			HEX0 <= z_HEX0;
			HEX1 <= z_HEX1;
			HEX2 <= z_HEX2;
//			HEX3 = z_HEX3.;
//			HEX4 = z_HEX4;
//			HEX5 = z_HEX5;
//			state_index <= zero_out_state;
		end
		
		default:
		begin
			LEDR <= default_out_ledr;
			HEX0 <= d_HEX0;
			HEX1 <= d_HEX1;
			HEX2 <= d_HEX2;
//			HEX3 = d_HEX3;
//			HEX4 = d_HEX4;
//			HEX5 = d_HEX5;
//			state_index <= default_out_state;
		end
	endcase

end // always

bcd_decoder st_out(state_index, 0, HEX5);
bcd_decoder st0_out(default_out_state, 0, HEX4);
bcd_decoder st1_out(zero_out_state, 0, HEX3);

endmodule

module default_case(
	inout 	wire	[3:0] 	state,
	input				[1:0]		KEY,
//	output	reg	[3:0]		out_state,
	output	reg	[9:0]		LEDR,
	output			[7:0]		HEX0,
	output			[7:0]		HEX1,
	output			[7:0]		HEX2,
	output			[7:0]		HEX3,
	output			[7:0]		HEX4,
	output			[7:0]		HEX5
);

reg [3:0] out_state;
assign state = out_state;

	assign {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = 0;
//	assign LEDR = 10'h2AA;
	
	always @(posedge KEY[0])
	begin
		if (state != 1) begin
			out_state = state + 1;
		end
		LEDR = ~LEDR;
//		out_state <= 3'd1;
	end // always
	
endmodule

module zero_state(
	inout 	wire	[3:0] 	state,
	input				[1:0]		KEY,
//	output	reg	[3:0]		out_state,
	output			[9:0]		LEDR,
	output			[7:0]		HEX0,
	output			[7:0]		HEX1,
	output			[7:0]		HEX2,
	output			[7:0]		HEX3,
	output			[7:0]		HEX4,
	output			[7:0]		HEX5
);

assign LEDR = 10'h01F;
reg [3:0] out_state;
assign state = out_state;

always @(negedge KEY[0])
begin
	if (state == 1) begin
		out_state <= state - 1;
	end
//	out_state <= 3'd0;
end // always

endmodule
