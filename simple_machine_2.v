module simple_machine_2(
	input						clk,
	input						reset,
	
	input				[1:0] KEY,
	output	reg	[9:0] LEDR,
	output	wire	[7:0] HEX0,
	output	wire	[7:0] HEX1
);

reg [3:0] state;

wire [9:0] a_ledr;
wire [3:0] a_new_state;
sm2_a a(state, KEY, a_new_state, a_ledr);

wire [9:0] b_ledr;
wire [3:0] b_new_state;
sm2_b b(state, KEY, b_new_state, b_ledr);

bcd_decoder bcd_a(a_new_state, 0, HEX0);
bcd_decoder bcd_b(b_new_state, 0, HEX1);

always @(posedge clk)
begin
	if (reset)
	begin
		state <= 0;
	end // if
	
	else
	begin
		case (state)
			0: begin
				state <= a_new_state;
			end
			1: begin
				state <= b_new_state;
			end
			default: begin
				state <= 0;
			end
			endcase
	end // else
end // always new_state

always @(state)
begin
	
	if (reset)
	begin
		LEDR <= 10'h3FF;
	end
	
	else
	begin
		case (state)
			0: begin
				LEDR <= a_ledr;
			end
			1: begin
				LEDR <= b_ledr;
			end
			
			default: begin
				LEDR <= 0;
			end
		endcase
	end
	
end // always state


endmodule

module sm2_a(
	input				[3:0] state,
	input				[1:0] KEY,
	output	reg	[3:0] out_state,
	output	reg	[9:0] LEDR
);

always @(state)
begin
//	if (state != 0)
//	begin
//		out_state <= 0;
//	end
	
//	else
//	begin
		LEDR <= 10'h2AA;
//		if (!KEY[0])
//		begin
//			out_state <= 1;
//		end
//		
//		else
//		begin
//			out_state <= 0;
//		end
//	end
end //always

always @(posedge KEY[0])
begin
	if (state == 0)
	begin
		out_state <= 1;
	end
	
	else 
	begin
		out_state <= 0;
	end
end

endmodule

module sm2_b(
	input				[3:0] state,
	input				[1:0] KEY,
	output	reg	[3:0] out_state,
	output	reg	[9:0] LEDR
);

always @(state)
begin
//	if (state != 1)
//	begin
//		out_state <= 1;
//	end
	
//	else
//	begin
		LEDR <= 10'h155;
//		if (!KEY[0])
//		begin
//			out_state <= 0;
//		end
//		
//		else
//		begin
//			out_state <= 1;
//		end
//	end
end //always

always @(posedge KEY[0])
begin
//	if (state == 1)
//	begin
//		out_state <= 0;
//	end
//	
//	else 
//	begin
//		out_state <= 1;
//	end
	out_state <= !out_state;
end

endmodule
