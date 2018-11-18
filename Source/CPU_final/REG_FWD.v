module REG_FWD( f_dop1, d_xop1, d_xop2, x_mop2, m_wop2, branch, m_wregwrite, x_mregwrite, x_mr15write, m_wr15write, alufwda, alufwdb, cmpsrc, regFwd);
input [3:0] f_dop1, d_xop1, d_xop2, x_mop2, m_wop2;
input branch, m_wregwrite, x_mregwrite, x_mr15write, m_wr15write;
output reg [2:0] alufwda, alufwdb;
output reg [1:0] cmpsrc;
output reg regFwd;

always@(*)
begin
	
	if( x_mregwrite && (x_mop2 != 0) && (x_mop2 == d_xop1) )
		alufwda = 3'b100;
	else if( m_wregwrite && (m_wop2 != 0) && (m_wop2 == d_xop1) )
		alufwda = 3'b011;
	else if( x_mr15write && (d_xop1 == 4'b1111) )
		alufwda = 3'b010;
	else if( m_wr15write && (d_xop1 == 4'b1111) )
		alufwda = 3'b001;
	else
		alufwda = 3'b000;
		
	if( x_mregwrite && (x_mop2 != 0) && (x_mop2 == d_xop2) )
		alufwdb = 3'b100;
	else if( m_wregwrite && (m_wop2 != 0) && (m_wop2 == d_xop2) )
		alufwdb = 3'b011;
	else if( x_mr15write && (d_xop2 == 4'b1111) )
		alufwdb = 3'b010;
	else if( m_wr15write && (d_xop2 == 4'b1111) )
		alufwdb = 3'b001;
	else
		alufwdb = 3'b000;
		
	if( branch && x_mr15write )
		cmpsrc = 2'b10;
	else if( branch && m_wr15write && !x_mr15write )
		cmpsrc = 2'b01;
	else
		cmpsrc = 2'b00;
	
	if( m_wregwrite && (f_dop1 == m_wop2 ) )
		regFwd = 1;
	else
		regFwd = 0;
end
endmodule