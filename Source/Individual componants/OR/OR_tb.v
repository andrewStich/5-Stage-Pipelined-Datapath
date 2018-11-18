`include "OR.v"

module OR_tb();
reg a, b;
wire y;

OR DUT(
	.a(a),
	.b(b),
	.y(y)
	);

initial
begin
	a = 0;
	b = 0;
	#10;
	b = 1;
	#10;
	a = 1;
	b = 0;
	#10;
	b = 1;

end

initial
begin
        $dumpvars;
        $display("  b  |  a  |  y");
        $monitor(" %b  | %b  | %b", a, b, y);
end

endmodule

