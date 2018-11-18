`include "ADD_N.v"

module ADD_N_tb();;
reg [15:0] A, B;
wire [15:0] Y;

ADD_N #(.SIZE (32)) DUT(
        .A(A),
        .B(B),
        .Y(Y)
        );

initial
begin
        A = 42;
	B = 420;
	#10;
	A = 569;
	#10;
end

initial
begin
        $dumpvars;
        $display(" A  |  B  | Y");
        $monitor(" %d | %d  | %d ", A, B, Y);
end

endmodule

