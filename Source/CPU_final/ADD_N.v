module ADD_N ( A, B, Y );
parameter SIZE = 16;
input [SIZE - 1:0] A, B;
output reg [SIZE - 1:0] Y;

always@(*)
Y = A + B;

endmodule
