module SHL1 ( in, out );
input [15:0] in;
output reg [15:0] out;

always@(*)

out = { in[14:0], 1'b0 };

endmodule
