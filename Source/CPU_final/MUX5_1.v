module MUX5_1 (d0, d1, d2, d3, d4, sel, m );
input [15:0] d0, d1, d2, d3, d4;
input  [2:0] sel;
output reg [15:0] m;

always@(*)
case ( sel )
	0: m = d0;
	1: m = d1;
	2: m = d2;
	3: m = d3;
	4: m = d4;
	default: m = d0;
endcase
endmodule

