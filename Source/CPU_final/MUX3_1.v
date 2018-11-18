module MUX3_1 (d0, d1, d2, sel, m );
input [15:0] d0, d1, d2;
input  [1:0] sel;
output reg [15:0] m;

always@(*)
case ( sel )
	0: m = d0;
	1: m = d1;
	2: m = d2;
	default: m = d0;
endcase
endmodule
