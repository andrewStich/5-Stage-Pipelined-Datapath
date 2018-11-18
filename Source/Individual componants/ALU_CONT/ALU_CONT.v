module ALU_CONT( aluOp, funCode, aluFunc );
input [3:0] funCode;
input [2:0] aluOp;
output reg [2:0] aluFunc;

always@(*)
begin

case( aluOp )

	3'b000 : begin
		if( funCode == 4'b0000 )
			aluFunc = 3'b000;
		if( funCode == 4'b0001 )
			aluFunc = 3'b001;
		if( funCode == 4'b0100 )
			aluFunc = 3'b100;
		if( funCode == 4'b0101 )
			aluFunc = 3'b101;
	end

	3'b010 :
		aluFunc = 3'b010;

	3'b011 :
		aluFunc = 3'b011;
	
	3'b100 :
		aluFunc = 3'b000;
	
	default :
		aluFunc = 3'b000;
endcase
end
endmodule
	
