`timescale 1ns / 1ns 
module mp7to1_tb; 

	reg [6:0] a [0:6];
	wire [6:0] out;
	reg [2:0] b;
	integer i;

	mp7to1 mp(.a(a), .b(b), .out(out));
	initial begin
		$monitor("%d  --->  %p %b %b %b %b %b %b %b %b %b", $time, a, a[0], a[1], a[2], a[3], a[4], a[5], a[6], b, out);
		b <= 0;
		for (i = 0; i < 7; i = i + 1) begin
			a[i] <= $random + $random;
		end
		
      for (i = 1; i < 7; i = i + 1) begin
			#5
			b <= i;
		end
		#10
		$stop;
	end 
endmodule