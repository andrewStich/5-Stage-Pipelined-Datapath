`include "DATA_MEM.v"

module DATA_MEM_tb ();
reg MEM_W, MEM_R, BYTE_EN, clk, rst;
reg [15:0] ADDR, DATA_in;
wire [15:0] DATA_out;

DATA_MEM DUT (
	.clk(clk),
	.rst(rst),
	.MEM_W(MEM_W),
	.MEM_R(MEM_R),
	.BYTE_EN(BYTE_EN),
	.ADDR(ADDR),
	.DATA_in(DATA_in),
	.DATA_out(DATA_out)
	);

initial
	clk = 0;
always
begin
	#5;
	clk = ~clk;
end	

initial
begin
	rst = 0;
	MEM_W = 0;
	MEM_R = 0;
	BYTE_EN = 0;
	DATA_in = 16'h0000;
	ADDR = 16'h0000;
	#10;
	rst = 1;
	MEM_R = 1;
	#10;
	ADDR = 16'h0002;
	#10;
	ADDR = 16'h0004;
	#10;
	ADDR = 16'h0006;
	#10;
	ADDR = 16'h0008;
	#10;
	MEM_W = 1;
	ADDR = 16'h0000;
	#10;
	DATA_in = 16'h1234;
	ADDR = 16'h0002;
	#10;
	BYTE_EN = 1;
	DATA_in = 16'hAAAA;
	ADDR = 16'h0004;
	#10;
	ADDR = 16'h0006;
	#10;
	MEM_W = 0;
	BYTE_EN = 0;
	ADDR = 16'h0004;
	#10;
	ADDR = 16'h0006;
	#10 $finish;

end

initial
begin
	$dumpvars;
        $display("clk | rst | MEM_W | MEM_R | BYTE_EN | ADDR | DATA_in | DATA_out");
        $monitor("%b   | %b   %h     | %h      | %h     | %h | %h    | %h", clk, rst, MEM_W, MEM_R, BYTE_EN, ADDR, DATA_in, DATA_out);

end

endmodule
