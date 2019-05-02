module bcd_counter(
	input						clk,
	input						reset,
	output	reg	[3:0]	cnt,
	output	reg			carry
);

//reg [3:0] cnt_mem;
//assign cnt = cnt_mem;

always @(posedge clk, posedge reset)
begin

	if (reset == 1)
		cnt = 0;
	else
	begin
		if (cnt == 9)
		begin
			cnt <= 0;
			carry <= 1;
		end // if
		
		else
		begin
			cnt <= cnt + 1;
			carry <= 0;
		end // else
	end

end // always

endmodule

//module BCDcount (Clock, Clear, E, BCD1, BCD0);
//module bcd_counter(
//	input						clk, 
//	input						reset, 
//	output	reg	[3:0]	cnt, 
//	output	reg			carry
//);
//
////	input Clock, Clear, E;
////	output reg [3:0] BCD1, BCD0;
//
//	always @(posedge clk)
//	begin
//
//		if (reset)
//		begin
//			cnt <= 0;
////			BCD0 <= 0;
//		end 
//		
//		else if (1)
//			if (cnt == 4'b1001)
//				begin
//					cnt <= 0; 
//					carry <= 1;
//				end
//			else
//			begin
//				cnt <= cnt + 1;
//				carry <= 0;
//			end
//end
//
//endmodule
