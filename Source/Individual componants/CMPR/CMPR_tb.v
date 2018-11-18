`include "CMPR.v";

module CMPR_tb();
reg [1:0] branchOp;
reg [15:0] regIn, reg15In;
wire jmpTrue;
wire [15:0] result;

CMPR DUT(
	.branchOp(branchOp),
	.regIn(regIn),
	.reg15In(reg15In),
	.jmpTrue(jmpTrue),
	.result(result)
	);
initial
begin

	branchOp = 2'b00;
	regIn = 10;
	reg15In = 0;
	#10;
	
	branchOp = 2'b01;
	reg15In = 15;
	#10;
	
	reg15In = 10;
	#10;
	
	reg15In = 5;
	#10;

	branchOp = 2'b10;
        reg15In = 15;
        #10;

        reg15In = 10;
        #10;

        reg15In = 5;
        #10;
 
	branchOp = 2'b11;
        reg15In = 15;
        #10;

        reg15In = 10;
        #10;

        reg15In = 5;
	#10 $finish;
end

initial
begin
        $dumpvars;
        $display(" instIn | regIn  | reg15In | jmpTrue | result");
        $monitor(" %b | %d  | %d   | %b       | %d", branchOp, regIn, reg15In, jmpTrue, result);
end

endmodule
