`include "SHL1.v"
module SHL1_tb ();
reg [15:0] in;
wire [15:0] out;

SHL1  DUT(
	.in(in),
	.out(out)
	);

initial
begin 

	in = 8'b00110110;
	#10;
	in = 8'b11110101;
	#10;
	in = 16'b1010101010101010;
	#10;
end

initial
begin
        $dumpvars;
        $display(" in  |  out  ");
        $monitor(" %b    | %b  ", in, out);
end

endmodule

