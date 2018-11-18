`include "REG_FILE.v"

module REG_FILE_tb ();
reg REG_WE, R15_WE, clk, rst;
reg [3:0] OP1_addr, OP2_addr, W_addr;
reg [15:0] W_data, W_R15;
wire [15:0] OP1_data, OP2_data, R15_data;

REG_FILE DUT(
	.clk(clk),
	.rst(rst),
	.reg_WE(REG_WE),
	.R15_WE(R15_WE),
	.OP1_addr(OP1_addr),
	.OP2_addr(OP2_addr),
	.W_addr(W_addr),
	.W_data(W_data),
	.W_R15(W_R15),
	.OP1_data(OP1_data),
	.OP2_data(OP2_data),
	.R15_data(R15_data)
	);

initial
begin
	$dumpvars;
        $display("clk | rst |REG_WE | R15_WE | OP1_addr | OP2_addr | W_addr | W_data | W_R15 | OP1_data | OP2_data | R15_data ");
        $monitor("%b   | %b   | %h     | %h      | %h        | %h        | %h      | %h   | %h  | %h     | %h     | %h ", clk, rst, REG_WE, R15_WE, OP1_addr, OP2_addr, W_addr, W_data, W_R15, OP1_data, OP2_data, R15_data);

end

initial
	clk = 0;
always
begin
	#2;
	clk = ~clk;
end

initial
begin
	rst = 0;
	REG_WE = 0;
	R15_WE = 0;
	OP1_addr = 4'h1;
	OP2_addr = 4'h2;
	W_addr = 4'h0;
	W_data = 16'h1234;
	W_R15 = 16'h5678;
	#1;
	rst = 1;
	OP1_addr = 4'h3;
        OP2_addr = 4'h4;
	#5;
	OP1_addr = 4'h5;
        OP2_addr = 4'h6;
        #5;
        OP1_addr = 4'h7;
        OP2_addr = 4'h8;
        #5;
	OP1_addr = 4'h9;
        OP2_addr = 4'hA;
        #5;
        OP1_addr = 4'hB;
        OP2_addr = 4'hC;
        #5;
        OP1_addr = 4'hD;
        OP2_addr = 4'hE;
        #5;
        OP1_addr = 4'hF;
        #5 
	W_addr = 4'h1;
	REG_WE = 1;
	R15_WE = 1;
	#5;
	OP1_addr = 4'h1;
	OP2_addr = 4'hF;
	#5;
	W_addr = 4'h8;
        REG_WE = 1;
        #5;
        W_data = 16'hbeef;
	OP1_addr = 4'h8;
	OP2_addr = 4'hA;	
	#5;
	REG_WE = 0;
	R15_WE = 0;
	W_data = 16'hfeed;
	W_R15 = 16'hbed1;
	#5;
	#5 $finish;
end
endmodule
	
