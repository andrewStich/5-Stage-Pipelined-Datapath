module CMPR( branchOp, regIn, reg15In, jmpTrue);
input [1:0] branchOp;
input [15:0] regIn, reg15In;
output reg jmpTrue;
reg [15:0] result;

always@(*)
begin

result = regIn - reg15In;

	if( branchOp == 2'b11 ) begin
		if( ( result[15] == 0 ) && ( result > 0 ) )
			jmpTrue = 1;
		else
			jmpTrue = 0;
	end

	else if( branchOp == 2'b01 ) begin
		if( result[15] == 1 )
			jmpTrue = 1;
		else
			jmpTrue = 0;
	end

	else if( branchOp == 2'b10) begin
		if( result == 0	)
			jmpTrue = 1;
		else
			jmpTrue = 0;
	end

	else
		jmpTrue = 0;

end

endmodule
