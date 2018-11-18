module DATA_MEM( clk, rst, DATA_in, ADDR, MEM_W, MEM_R, BYTE_EN, DATA_out );
input MEM_W, MEM_R, BYTE_EN, rst, clk;
input [15:0] DATA_in, ADDR;
output reg [15:0] DATA_out;
reg [7:0] memory [63:0];

always@( posedge clk,  negedge rst)
begin
	if( ~rst )
	begin
		memory[ 0000 ] = 8'h13;
		memory[ 0001 ] = 8'h42;
		memory[ 0002 ] = 8'h00;
		memory[ 0003 ] = 8'h00;
		memory[ 0004 ] = 8'h56;
		memory[ 0005 ] = 8'h78;
		memory[ 0006 ] = 8'hde;
		memory[ 0007 ] = 8'had;
		memory[ 0008 ] = 8'hbe;
		memory[ 0009 ] = 8'hef;
	end
	else if( MEM_W )
	begin
		if( BYTE_EN )
			memory[ ADDR ] = DATA_in[7:0];
		else
		begin
			memory[ ADDR ] = DATA_in[15:8];
			memory[ ADDR+1 ] = DATA_in[7:0];
		end
	end
end

always@(*)
	DATA_out = { memory[ ADDR ], memory[ ADDR+1 ] };

endmodule

