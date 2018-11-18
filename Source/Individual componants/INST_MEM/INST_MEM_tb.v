`include "INST_MEM.v"

module INST_MEM_tb ();
reg clk, rst;
reg [15:0] in;
wire [15:0] out;

INST_MEM DUT (
	.clk(clk),
	.rst(rst),
	.PC_addr(in),
	.INST_out(out)
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
	#11;
	rst = 1;
	in = 16'h0000;
	#11;
	in = 16'h0002;
	#11;
        in = 16'h0004;
	#11;
        in = 16'h0006;
	#11 $finish;
end

initial
begin
        $dumpvars;
        $display("clk | rst | input | output  ");
        $monitor("%b  | %b  | %h  | %h  ", clk, rst, in, out);
end
endmodule

