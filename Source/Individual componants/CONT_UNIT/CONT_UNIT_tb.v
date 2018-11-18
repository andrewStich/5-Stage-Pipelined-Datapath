`include "CONT_UNIT.v";
module CONT_UNIT_tb();
reg [3:0] funcIn, FuncCode;
wire aluSrcA, aluSrcB, byteEN, memW, memR, regW, R15w, brnch, jmp, IF_IDclr;
wire [1:0] WBsrc, brnchOP;
wire [2:0] aluOP;

CONT_UNIT DUT(
	.funcIn(funcIn),
	.FuncCode(FuncCode),
	.aluSrcA(aluSrcA),
	.aluSrcB(aluSrcB),
	.aluOP(aluOP),
	.byteEN(byteEN),
	.memW(memW),
	.memR(memR),
	.brnch(brnch),
	.brnchOP(brnchOP),
	.jmp(jmp),
	.R15w(R15w),
	.IF_IDclr(IF_IDclr)
	);

initial
begin
	funcIn = 4'b1111;
	FuncCode = 4'b0000;
	#1;
	FuncCode = 4'b0001;
	#1;
	FuncCode = 4'b0100;
	#1;
	FuncCode = 4'b0101;
	#1;
	funcIn = 4'b1000;
	FuncCode = 4'b0000;
	#1;
	funcIn = 4'b1001;
	#1;
	funcIn = 4'b1010;
	#1;
	funcIn = 4'b1011;
	#1;
	funcIn = 4'b1100;
	#1;
	funcIn = 4'b1101;
	#1;
	funcIn = 4'b0101;
	#1;
	funcIn = 4'b0100;
	#1;
	funcIn = 4'b0110;
	#1;
	funcIn = 4'b0001;
	#1;
	funcIn = 4'b0000;
	#1 $finish;
end

initial
begin
        $dumpvars;
        $display(" funcIn | FuncCode | aluSrcA | aluSrcB | aluOP | byteEN | memW | memR | brnch | brnchOP | jmp | R15w | IF_IDclr ");
        $monitor(" %b   | %b     | %b       | %b       | %b   | %b      | %b    | %b    | %b     | %b      | %b   | %b    | %b ", funcIn, FuncCode, aluSrcA, aluSrcB, aluOP, byteEN, memW, memR, brnch, brnchOP, jmp, R15w, IF_IDclr);
end
endmodule
