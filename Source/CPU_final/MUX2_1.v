module MUX2_1( d0, d1, m, sel );
input [15:0] d0, d1;
input  sel;
output reg [15:0] m;

always@(*)
if( sel )
	m = d1;
else
	m = d0;

endmodule
