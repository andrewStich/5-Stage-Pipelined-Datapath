module ZERO_EXT ( in, out );
input [7:0] in;
output reg [15:0] out;

always@(*)

out = { 8'h00, in };

endmodule 
