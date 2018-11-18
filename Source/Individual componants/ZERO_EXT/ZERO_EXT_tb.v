`include "ZERO_EXT.v"

module ZERO_EXT_tb ();
reg [7:0] unex;
wire [15:0] ext;

ZERO_EXT  DUT(
	.in(unex),
	.out(ext)
	);

initial
begin 

	unex = 8'b00110110;
	#10;
	unex = 8'b11110101;
	#10;
end

initial
begin
        $dumpvars;
        $display(" unex  |  ext  ");
        $monitor(" %b    | %b  ", unex, ext);
end

endmodule

