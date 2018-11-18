module REG_FILE( clk, rst, OP1_addr, OP2_addr, W_data, W_addr, W_R15, OP1_data, OP2_data, R15_data, reg_WE, R15_WE );
input reg_WE, R15_WE, clk, rst;
input [3:0] OP1_addr, OP2_addr, W_addr; 
input [15:0] W_data, W_R15;
output reg [15:0] OP1_data, OP2_data, R15_data;
reg [15:0] registers [15:1];

always@(posedge clk, negedge rst)
begin
	if( ~rst )
	begin
		registers [ 4'h1 ] = 16'h1b18;
		registers [ 4'h2 ] = 16'h245b;
                registers [ 4'h3 ] = 16'hff0f;
                registers [ 4'h4 ] = 16'hf0ff;
                registers [ 4'h5 ] = 16'h0040;
                registers [ 4'h6 ] = 16'h6666;
                registers [ 4'h7 ] = 16'h00ff;
                registers [ 4'h8 ] = 16'hff88;
                registers [ 4'h9 ] = 16'h0000;
                registers [ 4'ha ] = 16'h0000;
                registers [ 4'hb ] = 16'h3099;
                registers [ 4'hc ] = 16'hcccc;
                registers [ 4'hd ] = 16'h0002;
                registers [ 4'he ] = 16'h0011;
                registers [ 4'hf ] = 16'h0000;
	end
	else
		begin
		if( reg_WE )
			registers[ W_addr ] = W_data;
	
		if( R15_WE )
			registers[ 4'hF ] = W_R15;
	end
end

always@(*)
begin
        OP1_data = registers[ OP1_addr ];
        OP2_data = registers[ OP2_addr ];
        R15_data = registers[ 4'hF ];
end
endmodule
