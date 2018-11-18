module SIGN_EXT ( in, out );
parameter IN_SIZE = 8;
input [IN_SIZE - 1:0] in;
output reg [15:0] out;

always@(*)

out = {{(16 - IN_SIZE){in[IN_SIZE - 1]}}, in };

endmodule
