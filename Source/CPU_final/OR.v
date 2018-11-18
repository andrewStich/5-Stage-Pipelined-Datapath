module OR ( a, b, y );
input a, b;
output reg y;

always@(*)

if( a || b )
	y = 1;
else
	y = 0;

endmodule
