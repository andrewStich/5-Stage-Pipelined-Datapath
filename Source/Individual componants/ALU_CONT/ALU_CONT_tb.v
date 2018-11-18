`include "ALU_CONT.v";
module ALU_CONT_tb();
reg [3:0] funCode;
reg [2:0] aluOp;
wire [2:0] aluFunc;

ALU_CONT DUT (
	.funCode(funCode),
	.aluOp(aluOp),
	.aluFunc(aluFunc)
	);

initial
begin

	aluOp = 3'b000;
	funCode = 4'b0000;
	#10;

	funCode = 4'b0001;
	#10;
	
	funCode = 4'b0100;
	#10;
	
	funCode = 4'b0101;
	#10;

	aluOp = 3'b010;
	#10;
	
	aluOp = 3'b011;
	#10;
	
	aluOp = 3'b100;
	#10;

	aluOp = 3'b110;
	#10 $finish;
end

initial
begin
        $dumpvars;
        $display(" aluOp | funCode | aluFunc ");
        $monitor(" %b   | %b    | %b", aluOp, funCode, aluFunc);
end
endmodule
