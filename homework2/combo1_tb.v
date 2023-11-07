module tb;
	reg a, b, c, d;
	wire o;
	integer i;
	combo1 u0 ( .a(a), .b(b), .c(c), .d(d), .o(o));
	initial begin
		a <= 0;
		b <= 0;
		c <= 0;
		d <= 0;
		$monitor ("a=%0b b=%0b c=%0b d=%0b o=%0b", a, b, c, d, o);
		for (i = 0; i < 16; i = i + 1) begin
			{a, b, c, d} = i;
			#10;
		end
	end
endmodule