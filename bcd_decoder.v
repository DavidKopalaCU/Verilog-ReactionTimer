module bcd_decoder(
	input				[3:0]	decimal,
	input						dec,
	output	reg	[7:0] hex_out
);

always @(decimal, dec)
begin

	case (decimal)
//	begin
		0: hex_out = { !dec, 7'b1000000 };
		1: hex_out = { !dec, 7'b1111001 };
		2: hex_out = { !dec, 7'b0100100 };
		3: hex_out = { !dec, 7'b0110000 };
		4: hex_out = { !dec, 7'b0011001 };
		5: hex_out = { !dec, 7'b0010010 };
		6: hex_out = { !dec, 7'b0000010 };
		7: hex_out = { !dec, 7'b1111000 };
		8: hex_out = { !dec, 7'b0000000 };
		9: hex_out = { !dec, 7'b0010000 };
		default: hex_out = 8'hff;
	endcase

end // always

endmodule
