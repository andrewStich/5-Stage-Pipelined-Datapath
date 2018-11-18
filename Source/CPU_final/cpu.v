`include "ADD_N.v";
`include "ALU.v";
`include "ALU_CONT.v";
`include "AND.v";
`include "CMPR.v";
`include "CONT_UNIT.v";
`include "DATA_MEM.v";
`include "HZD_DET.v";
`include "INST_MEM.v";
`include "MUX2_1.v";
`include "MUX3_1.v";
`include "MUX5_1.v";
`include "OR.v";
`include "REG_FILE.v";
`include "REG_FWD.v";
`include "REG_N.v";
`include "SHL1.v";
`include "SIGN_EXT.v";
`include "ZERO_EXT.v";
`include "MUX_BUB.v";
/* 
TO DO:
exception handling
*/
module cpu( clk, reset );
input clk, reset;

wire [15:0] nextAddr, pcOut, pcPlus2, bnchJmpAddr, instOut;
wire pcSrc, pcWrite, f_dClr;
wire [31:0] FDregIn, FDregOut;
assign FDregIn = {pcPlus2, instOut};

wire [15:0] op1Data, op2Data, R15Data, cmpIn, fwdMuxOut;
wire [15:0] signExt12out, signExt8out, JBsel, JBoffset,zeroExtout;
wire [2:0] aluOP;
wire [1:0] cmpSrc, branchOp, WBsrc;
wire jmpTrue, cmpOut, branch, andOut, aluSrcA, aluSrcB, byteEN, memW, memR, regW, R15w, branchInst;
wire [67:0] DEregIn, DEregOut;
wire [11:0] controlSignals, muxBubOut;
assign controlSignals = {aluOP, aluSrcB, aluSrcA, byteEN, memW, memR, WBsrc, regW, R15w};
assign DEregIn = { FDregOut[7:4], FDregOut[11:8], zeroExtout, op2Data, fwdMuxOut, muxBubOut };

wire [15:0] aluA1, aluA2, aluB1, aluB2, aluOut, aluHigh;
wire [2:0] fwdA, fwdB, aluFunc;
wire OF_flag, FDfwd;
wire [59:0] EMregIn, EMregOut;
assign EMregIn = { DEregOut[63:60], aluHigh, aluOut, aluA2, DEregOut[6:4], DEregOut[3:0] };

wire [15:0] memOut, zeroOut, WBdata;
wire [37:0] MWregIn, MWregOut;
assign MWregIn = { EMregOut[58:55], EMregOut[54:39], WBdata, EMregOut[1:0] };

wire bubble, F_Dwrite;

//First Stage
MUX2_1 pcMux (
	.d0(pcPlus2),
	.d1(bnchJmpAddr),
	.m(nextAddr),
	.sel(pcSrc)
	);
REG_N #(.reg_size( 16 ) ) PC (
 	.clk(clk),
	.rst(reset),
	.write_enable(pcWrite),
	.wdata(nextAddr),
	.rdata(pcOut)
	);
ADD_N #(.SIZE(16) ) pcPlus2Adder(
	.A(16'h02),
	.B(pcOut),
	.Y(pcPlus2)
	);
INST_MEM instruction_memory (
	.clk(clk),
	.rst(reset),
	.PC_addr(pcOut),
	.INST_out(instOut)
	);
REG_N #(.reg_size(32) ) F_Dregister (
	.clk(clk),
	.rst(!f_dClr),
	.write_enable(F_Dwrite),
	.wdata( FDregIn ),
	.rdata(FDregOut)
	);
	
// Second Stage
REG_FILE registers (
	.clk(clk),
	.rst(reset),
	.OP1_addr(FDregOut[11:8]),
	.OP2_addr(FDregOut[7:4]),
	.W_data(MWregOut[17:2]),
	.W_addr(MWregOut[37:34]),
	.W_R15(MWregOut[33:18]),
	.OP1_data(op1Data),
	.OP2_data(op2Data),
	.R15_data(R15Data),
	.reg_WE(MWregOut[1]),
	.R15_WE(MWregOut[0])
	);
SIGN_EXT #(.IN_SIZE( 12 )) signExt12 (
	.in(FDregOut[11:0]),
	.out(signExt12out)
	);
SIGN_EXT #(.IN_SIZE( 8 )) signExt8 (
	.in(FDregOut[7:0]),
	.out(signExt8out)
	);
ZERO_EXT decodeZero (
	.in(FDregOut[7:0]),
	.out(zeroExtout)
	);
MUX2_1 b_jAddrSel (
	.d0(signExt8out),
	.d1(signExt12out),
	.m(JBsel),
	.sel(jmpTrue)
	);
SHL1 JBshift (
	.in(JBsel),
	.out(JBoffset)
	);
ADD_N #(.SIZE( 16 )) JBaddr (
	.A(FDregOut[31:16]),
	.B(JBoffset),
	.Y(bnchJmpAddr)
	);
MUX3_1 cmpInSel (
	.d0(R15Data),
	.d1(MWregOut[33:18]),
	.d2(EMregOut[54:39]),
	.m(cmpIn),
	.sel(cmpSrc)
	);
CMPR comparator(
	.branchOp(branchOp),
	.regIn(fwdMuxOut),
	.reg15In(cmpIn),
	.jmpTrue(cmpOut)
	);
AND branchDetect (
	.a(cmpOut),
	.b(branch),
	.y(andOut)
	);
OR JorB (
	.a(jmpTrue),
	.b(andOut),
	.y(pcSrc)
	);
CONT_UNIT control_unit (
	.funcIn(FDregOut[15:12]),
	.FuncCode(FDregOut[3:0]),
	.aluSrcA(aluSrcA),//EX
	.aluSrcB(aluSrcB),//EX
	.aluOP(aluOP), //EX
	.byteEN(byteEN), //MEM
	.memW(memW), //MEM
	.memR(memR), //MEM
	.WBsrc(WBsrc), //WB
	.regW(regW), //WB
	.brnch(branchInst), //D
	.brnchOP(branchOp), //D
	.branchDetect(branchInst), //to HZD_DET
	.jmp(jmpTrue), //D
	.R15w(R15w), //WB
	.IF_IDclr(f_dClr) //D
	);
MUX2_1 registerOut_forward(
	.d0(op1Data),
	.d1(MWregOut[17:2]),
	.m(fwdMuxOut),
	.sel(FDfwd)
	);
MUX_BUB bubble_sel (
	.d0(controlSignals),
	.d1(12'd0),
	.sel(bubble),
	.m(muxBubOut)
	);
	REG_N #(.reg_size( 68 )) DEregister (
	.clk(clk),
	.rst(reset),
	.wdata(DEregIn),
	.rdata(DEregOut),
	.write_enable(1'b0)
	);

// Third Stage
MUX2_1 aluSelA (
	.d0(DEregOut[27:12]),
	.d1(DEregOut[43:28]),
	.m(aluA1),
	.sel(DEregOut[7])
	);
MUX5_1 aluAin (
	.d0(aluA1),
	.d1(MWregOut[33:18]),
	.d2(EMregOut[54:39]),
	.d3(MWregOut[17:2]),
	.d4(EMregOut[38:23]),
	.m(aluA2),
	.sel(fwdA)
	);
MUX2_1 aluBin (
	.d0(aluB1),
	.d1({12'd0,DEregOut[47:44]}),
	.sel(DEregOut[8]),
	.m(aluB2)
	);
MUX5_1 aluSelB (
	.d0(DEregOut[43:28]),
	.d1(MWregOut[33:18]),
	.d2(EMregOut[54:39]),
	.d3(MWregOut[17:2]),
	.d4(EMregOut[38:23]),
	.sel(fwdB),
	.m(aluB1)
	);
ALU_CONT alu_control (
	.aluOp(DEregOut[11:9]),
	.funCode(DEregOut[47:44]),
	.aluFunc(aluFunc)
	);
ALU alu (
	.a(aluA2),
	.b(aluB2),
	.OF_detect(OF_flag),
	.ALU_FUNC(aluFunc),
	.out( { aluHigh, aluOut } )
	);
REG_N #(.reg_size( 60 ) ) EMreg (
	.clk(clk),
	.rst(reset),
	.rdata(EMregOut),
	.wdata(EMregIn),
	.write_enable(1'b0)
	);

// Fourth Stage
DATA_MEM data_memory (
	.clk(clk),
	.rst(reset),
	.DATA_in(EMregOut[22:7]),
	.ADDR(EMregOut[38:23]),
	.DATA_out(memOut),
	.BYTE_EN(EMregOut[6]),
	.MEM_W(EMregOut[5]),
	.MEM_R(EMregOut[4])
	);
ZERO_EXT zero_extend (
	.in(memOut[7:0]),
	.out(zeroOut)
	);
MUX3_1 writeBackSelect (
	.d0(memOut),
	.d1(zeroOut),
	.d2(EMregOut[38:23]),
	.m(WBdata),
	.sel(EMregOut[3:2])
	);
REG_N #(.reg_size( 38 ) ) MWreg (
	.clk(clk),
	.rst(reset),
	.rdata(MWregOut),
	.wdata(MWregIn),
	.write_enable(1'b0)
	);


//fifth stage
//only data being written back to previous instances	

// register Forwarding
REG_FWD register_fwd (
	.f_dop1(FDregOut[11:8]),
	.d_xop1(DEregOut[63:60]),
	.d_xop2(DEregOut[67:64]),
	.x_mop2(EMregOut[58:55]),
	.m_wop2(MWregOut[37:34]),
	.branch(branchInst),
	.m_wregwrite(MWregOut[1]),
	.x_mregwrite(EMregOut[1]),
	.m_wr15write(MWregOut[0]),
	.x_mr15write(EMregOut[0]),
	.alufwda(fwdA),
	.alufwdb(fwdB),
	.cmpsrc(cmpSrc),
	.regFwd(FDfwd)
	);

// Hazard Detection
HZD_DET hazard_detection (
	.branchOp(branchInst),
	.branch(branch),
	.bubble(bubble),
	.D_Xmem_R(memR),
	.X_Mmem_R(EMregOut[4]),
	.X_Mreg_W(EMregOut[1]),
	.M_Wmem_R(),
	.F_Dwrite(F_Dwrite),
	.PCwrite(pcWrite),
	.D_Xop1(DEregOut[63:60]),
	.F_Dop1(FDregOut[11:8]),
	.F_Dop2(FDregOut[7:4]),
	.X_Mop1(EMregOut[58:55]),
	.M_Wop1(MWregOut[37:34])
	);
endmodule