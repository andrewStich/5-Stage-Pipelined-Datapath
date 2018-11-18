`include "REG_FWD.v";
module REG_FWD_tb();
reg [3:0] f_dop1, f_dop2, d_xop1, d_xop2, x_mop2, m_wop2;
reg branch, m_wregwrite, x_mregwrite, x_mr15write, m_wr15write;
wire [2:0] alufwda, alufwdb;
wire [1:0] cmpsrc;

REG_FWD dut(
	.f_dop1(f_dop1),
	.f_dop2(f_dop2),
	.d_xop1(d_xop1),
	.d_xop2(d_xop2),
	.x_mop2(x_mop2),
	.m_wop2(m_wop2),
	.branch(branch),
	.x_mr15write(x_mr15write),
	.m_wregwrite(m_wregwrite),
	.x_mregwrite(x_mregwrite),
	.m_wr15write(m_wr15write),
	.alufwda(alufwda),
	.alufwdb(alufwdb),
	.cmpsrc(cmpsrc)
	);

initial
begin
	f_dop1 = 0;
	f_dop2 = 0;
	d_xop1 = 0;
	d_xop2 = 0;
	x_mop2 = 0;
	m_wop2 = 0;
	branch = 0;
	m_wregwrite = 0;
	x_mregwrite = 0;
	x_mr15write = 0;
	m_wr15write = 0;
	#10;
	
	x_mregwrite = 1;
	d_xop1 = 5;
	x_mop2 = 5;
	#10;
	
	x_mregwrite = 0;
	x_mop2 = 0;
	m_wregwrite = 1;
	m_wop2 = 5;
	#10;
	
	m_wregwrite = 0;
	m_wop2 = 0;
	x_mregwrite = 1;
	x_mop2 = 5;
	d_xop2 = 5;
	d_xop1 = 0;
	#10;
	
	x_mregwrite = 0;
	x_mop2 = 0;
	m_wregwrite = 1;
	m_wop2 = 5;
	#10;
	
	m_wregwrite = 0;
	m_wop2 = 0;
	d_xop2 = 0;
	#10;
	
	x_mr15write = 1;
	d_xop1 = 15;
	#10;
	
	x_mr15write = 0;
	m_wr15write = 1;
	#10;
	
	d_xop1 = 0;
	m_wr15write = 0;
	x_mr15write = 1;
	d_xop2 = 15;
	#10;
	
	x_mr15write = 0;
	m_wr15write = 1;
	#10;
	
	m_wr15write = 0;
	d_xop2 = 0;
	#10;
	
	branch = 1;
	x_mr15write = 1;
	#10;
	
	m_wr15write = 1;
	#10;
	
	x_mr15write = 0;
	#10;
	
	x_mregwrite = 1;
	m_wregwrite = 1;
	x_mr15write = 1;
	d_xop1 = 3;
	d_xop2 = 15;
	x_mop2 = 3;
	m_wop2 = 15;
	#10;
	
	x_mr15write = 0;
	#10;
	
	m_wr15write = 0;
	d_xop2 = 3;
	m_wop2 = 3;
	
	#10 $finish;
end

initial
begin
        $dumpvars;
        $display(" f_dop1 | f_dop2 | d_xop1 | d_xop2 | x_mop2 | m_wop2 | x_mregwrite | m_wregwrite | x_mr15write | m_wr15write | alusrca | alusrcb | cmpsrc ");
        $monitor(" %b   | %b   | %b   | %b   | %b   | %b   | %b           | %b           | %b           | %b           | %b     | %b     | %b", f_dop1, f_dop2, d_xop1, d_xop2, x_mop2, m_wop2, x_mregwrite, m_wregwrite, x_mr15write, m_wr15write, alufwda, alufwdb, cmpsrc);
end
endmodule
