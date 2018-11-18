`include "ALU.v"
module ALU_tb ();
reg [15:0] a, b;
reg [2:0] ALU_FUNC;
wire [31:0] out;
wire OF_detect;

ALU DUT(
	.a(a),
	.b(b),
	.ALU_FUNC(ALU_FUNC),
	.out(out),
	.OF_detect(OF_detect)
	);

initial
begin
	a = 5076;
	b = 200;;
	ALU_FUNC = 3'b000;
	#10;
	ALU_FUNC = 3'b001;
	#10;
	ALU_FUNC = 3'b010;
	#10;
	ALU_FUNC = 3'b011;
	#10;
	ALU_FUNC = 3'b100;
	#10;
	ALU_FUNC = 3'b101;
	#10;
	ALU_FUNC = 3'b000;
	a = 16'hcccc;
	b = 16'hcccc;
	#10;
	ALU_FUNC = 3'b001;
	b = 16'hcccd;
	#10 $finish;
end

initial
begin
        $dumpvars;
        $display(" a  |  b  | ALU_FUNC | out | OF_detect ");
        $monitor(" %b | %b  | %b | %b   | %b", a, b, ALU_FUNC, out, OF_detect);
end
endmodule 
