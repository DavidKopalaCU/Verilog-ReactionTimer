module three_to_eight_decoder(
	input				[2:0]	in,
	output	reg	[7:0]	out
);

always @(in)
begin
	case (in)
		0: out <= 8'd0;
		1: out <= 8'd1;
		2: out <= 8'd2;
		3: out <= 8'd4;
		4: out <= 8'd8;
		5: out <= 8'd16;
		6: out <= 8'd32;
		7: out <= 8'd64;
	endcase
end

endmodule
