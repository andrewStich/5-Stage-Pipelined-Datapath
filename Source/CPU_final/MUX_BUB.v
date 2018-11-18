module MUX_BUB( d0, d1, m, sel);
input sel;
input [11:0] d0,d1;
output reg [11:0] m;

always@(*)

	if( sel )
		m = d1;
	else
		m = d0;

endmodule