module HZD_DET( branchOp,branch, bubble, D_Xmem_R, X_Mmem_R, X_Mreg_W, M_Wmem_R, F_Dwrite, PCwrite, D_Xop1, F_Dop1, F_Dop2, X_Mop1, M_Wop1 );
input [3:0] D_Xop1, F_Dop1, F_Dop2, X_Mop1, M_Wop1;
input branchOp,branch, D_Xmem_R, X_Mmem_R, M_Wmem_R, X_Mreg_W;
output reg bubble, F_Dwrite, PCwrite;

always@(*)
begin
	// Load/read hazard
	if( D_Xmem_R && ( (F_Dop1 == D_Xop1) || (F_Dop2 == D_Xop1) ) ) begin
		bubble = 1;
		F_Dwrite = 1;
		PCwrite = 1;
	end

	// branch immediately is afer ALU instruction
	else if( X_Mreg_W && branchOp && (M_Wop1 == D_Xop1) ) begin
		bubble = 1;
		F_Dwrite = 1;
		PCwrite = 1;
	end

	// branch is immediately after load instruction
	else if( X_Mmem_R && branchOp && (X_Mop1 == D_Xop1) ) begin
		bubble = 1;
		F_Dwrite = 1;
		PCwrite = 1;
	end

	// branch is 2nd instruction after load instruction
	else if( M_Wmem_R && branchOp && (M_Wop1 == D_Xop1) ) begin
		bubble = 1;
		F_Dwrite = 1;
		PCwrite = 1;
	end

	// branch is taken
	else if( branch ) begin
		bubble = 1;
		F_Dwrite = 1;
		PCwrite = 1;
	end 
	
	// default state
	else begin
		bubble = 0;
		F_Dwrite = 0;
		PCwrite = 0;
	end
end

endmodule
