`include "HZD_DET.v";
module HZD_DET_tb();
reg branchOp, branch, D_Xmem_R, X_Mmem_R, X_Mreg_W, M_Wmem_R;
reg [3:0] D_Xop1, F_Dop1, F_Dop2, X_Mop1, M_Wop1; 
wire bubble, F_Dwrite, PCwrite;

HZD_DET DUT(
	.branchOp(branchOp),
	.branch(branch),
	.D_Xmem_R(D_Xmem_R),
	.X_Mmem_R(X_Mmem_R),
	.X_Mreg_W(X_Mreg_W),
	.M_Wmem_R(M_Wmem_R),
	.D_Xop1(D_Xop1),
	.F_Dop1(F_Dop1),
	.F_Dop2(F_Dop2),
	.X_Mop1(X_Mop1),
	.M_Wop1(M_Wop1),
	.bubble(bubble),
	.F_Dwrite(F_Dwrite),
	.PCwrite(PCwrite)
	);

initial
begin
	branchOp = 0;
	branch = 0;
	D_Xmem_R = 0;
	X_Mmem_R = 0;
	X_Mreg_W = 0;
	M_Wmem_R = 0;
	D_Xop1 = 0;
	F_Dop1 = 1;
	F_Dop2 = 2;
	X_Mop1 = 3;
	M_Wop1 = 4;
	#10;

	D_Xmem_R = 1;
	F_Dop1 = 0;
	#10;
	
	F_Dop1 = 1;
	F_Dop2 = 0;
	#10;
	
	D_Xmem_R = 0;
	F_Dop2 = 2;
	#10;

	X_Mreg_W = 1;
	branchOp = 1;
	M_Wop1 = 0;
	#10;

	X_Mreg_W = 0;
	#10;

	X_Mmem_R = 1;
	X_Mop1 = 0;
	#10;

	X_Mop1 = 3;
	X_Mmem_R = 0;
	#10;

	M_Wop1 = 0;
	M_Wmem_R = 1;
	#10;

	M_Wop1 = 3;
	M_Wmem_R = 1;
	branchOp = 0;
	#10;
	
	branch = 1;
	#10

	branch = 0;
	#10 $finish;

end

initial
begin
        $dumpvars;
        $display(" f_dop1 | f_dop2 | d_xop1 | x_mop1 | m_wop1 | D_Xmem_R | X_Mmem_R | X_Mreg_W | M_Wmem_R | branchOp | branch | bubble ");
        $monitor(" %b   | %b   | %b   | %b   | %b   | %b        | %b        | %b        | %b        | %b        | %b      | %b", F_Dop1, F_Dop2, D_Xop1, X_Mop1, M_Wop1, D_Xmem_R, X_Mmem_R, X_Mreg_W, M_Wmem_R, branchOp, branch, bubble);
end
endmodule

