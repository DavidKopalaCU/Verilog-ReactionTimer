//module simple_machine(
//	input				[1:0] KEY,
//	output	wire	[7:0] HEX5,
//	output	wire	[7:0] HEX4,
//	output	wire	[7:0] HEX3,
//	output	reg	[9:0] LEDR,
//	input						clk
//);
//
//reg [3:0] state;
//
//reg [3:0] next_state, next_state_a, next_state_b;
//wire [3:0] a_net, b_net, ahnet, bhnet;
//
//assign a_net = next_state_a;
//assign b_net = next_state_b;
//
//wire [9:0] a_led, b_led;
//
//simple_a a(state, a_net, KEY, a_led);
//simple_b b(state, b_net, KEY, b_led);
//
////bcd_decoder a_hex(ahnet, 0, HEX5);
////bcd_decoder b_hex(bhnet, 0, HEX4);
//
//always @(state)
//begin
//	next_state_a <= state;
//	next_state_b <= state;
//end
//
//always @(state)
//begin
////	next_state_a <= state;
////	next_state_b <= state;
//	case(state)
//		0: begin
//			LEDR <= 10'h1;
////			LEDR <= a_led;
////			next_state <= next_state_a;
//		end
//		1: begin
//			LEDR <= 10'h3;
////			LEDR <= b_led;
////			next_state <= next_state_b;
//		end
//		2: begin
//			LEDR <= 10'h5;
////			LEDR <= b_led;
////			next_state <= next_state_b;
//		end
//		3: begin
//			LEDR <= 10'h6;
////			LEDR <= b_led;
////			next_state <= next_state_b;
//		end
//	endcase
//end
//
////always @(posedge clk)
////begin
////	state <= next_state;
////end // always
//
//endmodule
//
//module simple_a(
//	input		wire	[3:0] state,
//	output	reg	[3:0] nxt_state_net,
//	
//	input				[1:0] KEY,
//	output	wire	[9:0] LEDR
//);
//
////reg [3:0] nxt_state;
////assign nxt_state_net = nxt_state;
//
//always @(posedge KEY[0])
//begin
//	nxt_state_net <= 1;
//end // always
//
//assign LEDR = 10'h1;
//
//endmodule
//
//module simple_b(
//	input		wire	[3:0] state,
//	output	reg	[3:0] nxt_state_net,
//	
//	input				[1:0] KEY,
//	output	wire	[9:0] LEDR
//);
//
////reg [3:0] nxt_state;
////assign nxt_state_net = nxt_state;
//
//always @(posedge KEY[0])
//begin
//	nxt_state_net <= 0;
//end // always
//
//assign LEDR = 10'h2;
//
//endmodule
//

