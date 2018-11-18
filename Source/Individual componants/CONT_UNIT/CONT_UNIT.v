module CONT_UNIT( funcIn, FuncCode, aluSrcA, aluSrcB, aluOP, byteEN,memW, memR, WBsrc, R15w, regW, branchDetect, brnch, brnchOP, jmp, IF_IDclr );
input [3:0] funcIn, FuncCode;
output reg branchDetect, aluSrcA, aluSrcB, byteEN, memW, memR, R15w, regW, brnch, jmp, IF_IDclr;
output reg [2:0] aluOP;
output reg [1:0] WBsrc, brnchOP;

always@(*)
begin
	case( funcIn )

		4'b1111 : begin //R type instructions (add, sub, mul,div)
		aluSrcA  = 0;
		aluSrcB  = 0;
		aluOP    = 3'b000;
		byteEN   = 0;
		memW     = 0;
		memR     = 0;
		WBsrc    = 2'b10;
		regW     = 1;
		brnch    = 0;
		brnchOP  = 2'b00;
		branchDetect = 0;
		jmp      = 0;
		IF_IDclr = 0;
		if ( (FuncCode == 4'b0100) || (FuncCode == 4'b0101) )
			R15w = 1;
		else
			R15w = 0;
		end
		
		4'b1000 : begin // ANDi
                aluSrcA  = 0;
                aluSrcB  = 1;
                aluOP    = 3'b010;
                byteEN   = 0;
                memW     = 0;
                memR     = 0;
                WBsrc    = 2'b10;
		R15w     = 0;
                regW     = 1;
                brnch    = 0;
                brnchOP  = 2'b00;
				branchDetect = 0;
                jmp      = 0;
                IF_IDclr = 0;
                end

		4'b1001 : begin	// ORi
                aluSrcA  = 0;
                aluSrcB  = 1;
                aluOP    = 3'b011;
                byteEN   = 0;
                memW     = 0;
                memR     = 0;
                WBsrc    = 2'b10;
                R15w     = 0;
                regW     = 1;
                brnch    = 0;
                brnchOP  = 2'b00;
				branchDetect = 0;
                jmp      = 0;
                IF_IDclr = 0;
                end

		4'b1010 : begin // LBU
                aluSrcA  = 1;
                aluSrcB  = 1;
                aluOP    = 3'b100;
                byteEN   = 1;
                memW     = 0;
                memR     = 1;
                WBsrc    = 2'b01;
                R15w     = 0;
                regW     = 1;
                brnch    = 0;
                brnchOP  = 2'b00;
				branchDetect = 0;
                jmp      = 0;
                IF_IDclr = 0;
                end

		4'b1011 : begin // SB
                aluSrcA  = 1;
                aluSrcB  = 1;
                aluOP    = 3'b100;
                byteEN   = 1;
                memW     = 1;
                memR     = 0;
                WBsrc    = 2'bXX;
                R15w     = 0;
                regW     = 0;
                brnch    = 0;
                brnchOP  = 2'b00;
				branchDetect = 0;
                jmp      = 0;
                IF_IDclr = 0;
                end

		4'b1100 : begin // LW
                aluSrcA  = 1;
                aluSrcB  = 1;
                aluOP    = 3'b100;
                byteEN   = 0;
                memW     = 0;
                memR     = 1;
                WBsrc    = 2'b00;
                R15w     = 0;
                regW     = 1;
                brnch    = 0;
                brnchOP  = 2'b00;
                jmp      = 0;
                IF_IDclr = 0;
                end

		4'b1101 : begin // SW
                aluSrcA  = 1;
                aluSrcB  = 1;
                aluOP    = 3'b100;
                byteEN   = 0;
                memW     = 1;
                memR     = 0;
                WBsrc    = 2'bXX;
                R15w     = 0;
                regW     = 0;
                brnch    = 0;
                brnchOP  = 2'b00;
				branchDetect = 0;
                jmp      = 0;
                IF_IDclr = 0;
                end

		4'b0101 : begin	// BLT
                aluSrcA  = 1'bX;
                aluSrcB  = 1'bX;
                aluOP    = 3'bXXX;
                byteEN   = 1'bX;
                memW     = 1'bX;
                memR     = 1'bX;
                WBsrc    = 2'b01;
                R15w     = 1'bX;
                regW     = 1'bX;
                brnch    = 1;
                brnchOP  = 2'b00;
				branchDetect = 1;
                jmp      = 0;
                IF_IDclr = 0;
                end

		4'b0100 : begin // BGT
                aluSrcA  = 1'bX;
                aluSrcB  = 1'bX;
                aluOP    = 3'bXXX;
                byteEN   = 1'bX;
                memW     = 1'bX;
                memR     = 1'bX;
                WBsrc    = 2'b01;
                R15w     = 1'bX;
                regW     = 1'bX;
                brnch    = 1;
                brnchOP  = 2'b11;
				branchDetect = 1;
                jmp      = 0;
                IF_IDclr = 0;
                end

		4'b0110 : begin // BEQ
                aluSrcA  = 1'bX;
                aluSrcB  = 1'bX;
                aluOP    = 3'bXXX;
                byteEN   = 1'bX;
                memW     = 1'bX;
                memR     = 1'bX;
                WBsrc    = 2'b01;
                R15w     = 1'bX;
                regW     = 1'bX;
                brnch    = 1;
                brnchOP  = 2'b01;
				branchDetect = 1;
                jmp      = 0;
                IF_IDclr = 0;
                end

		4'b0001 : begin // JMP
                aluSrcA  = 1'bX;
                aluSrcB  = 1'bX;
                aluOP    = 3'bXXX;
                byteEN   = 1'bX;
                memW     = 1'bX;
                memR     = 1'bX;
                WBsrc    = 2'b01;
                R15w     = 1'bX;
                regW     = 1'bX;
                brnch    = 0;
                brnchOP  = 2'bXX;
				branchDetect = 0;
                jmp      = 1;
                IF_IDclr = 0;
                end

		4'b0000 : begin // HLT
                aluSrcA  = 1'bX;
                aluSrcB  = 1'bX;
                aluOP    = 3'bXXX;
                byteEN   = 1'bX;
                memW     = 1'bX;
                memR     = 1'bX;
                WBsrc    = 2'b01;
                R15w     = 1'bX;
                regW     = 1'bX;
                brnch    = 1'bX;
                brnchOP  = 2'bXX;
                jmp      = 1'bX;
                IF_IDclr = 1;
                end

		default : begin
		aluSrcA  = 1'b0;
                aluSrcB  = 1'b0;
                aluOP    = 3'b000;
                byteEN   = 1'b0;
                memW     = 1'b0;
                memR     = 1'b0;
                WBsrc    = 2'b00;
                R15w     = 1'b0;
                regW     = 1'b0;
                brnch    = 1'b0;
                brnchOP  = 2'b00;
                jmp      = 1'b0;
                IF_IDclr = 0;
                end

	endcase
end

endmodule


