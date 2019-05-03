// ECEN2350 Project 2 - Spring 2019
// University of Colorado, Boulder
//
// Name: David Kopala
//


//////////////////////////
// Project2_top
//
// Do not remove inputs/ outputs that you don't use. However, any unused
// input/ outputs can remain unconnected in the pin planner.
//
module Project2_top(
	output	[7:0] HEX0,
	output	[7:0] HEX1,
	output	[7:0] HEX2,
	output	[9:0] LEDR,
	input	[9:0] SW,
	input	KEY0,
	input	KEY1,
	input	CLK_50MHZ,
	input   CLK_10MHZ
);

wire [7:0] HEX5, HEX4, HEX3;

simple_machine_3 sm2(CLK_50MHZ, 0, {KEY1, KEY0}, SW, LEDR, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
//simple_machine_3 sm2(MAX10_CLK2_50, 0, KEY, SW, LEDR, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

endmodule
