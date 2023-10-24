module mp7to1 (
	input [6:0] a [0:6],
	input [2:0] b,
	output reg [6:0] out);

	always @(b) begin
		case (b)
			3'b000: out <= a[0];
			3'b001: out <= a[1];
			3'b010: out <= a[2];
			3'b011: out <= a[3];
			3'b100: out <= a[4];
			3'b101: out <= a[5];
			3'b110: out <= a[6];
		endcase
	end

endmodule