module NCO (clk, rst, step, out);

parameter STEP_SIZE = 16;
parameter ADDR_WIDTH = 8;
parameter LUT_WIDTH = 16; 

localparam FRACT_WIDTH = STEP_SIZE - ADDR_WIDTH;

input clk;
input rst;
input [STEP_SIZE - 1 : 0] step;
output reg [LUT_WIDTH - 1 : 0] out;

reg signed [LUT_WIDTH - 1 : 0] LUT [2 ** ADDR_WIDTH - 1 : 0];
reg [STEP_SIZE + FRACT_WIDTH - 1 : 0] ph_accum;

always @(posedge clk) begin
    if (rst)
        ph_accum <= 0;
    else
        ph_accum <= ph_accum + step;
end

localparam PI = $asin(1) * 4.0;

initial begin
integer phase;
    for (phase = 0; phase < 2 ** ADDR_WIDTH; phase = phase + 1) begin
       LUT[$rtoi(phase)] = ($sin(2 * PI * phase / 2.0 ** ADDR_WIDTH)) * 2 ** (LUT_WIDTH - 2);
    end
end

wire dither;
assign dither = 0;

reg [ADDR_WIDTH - 1 : 0] addr;

always @(posedge clk) begin
    if (rst)
        addr <= 0;
    else
        addr <= ph_accum[ADDR_WIDTH + FRACT_WIDTH - 1 : FRACT_WIDTH];
end

always @ (posedge clk)
	begin
		out <= LUT[addr];
	end

endmodule