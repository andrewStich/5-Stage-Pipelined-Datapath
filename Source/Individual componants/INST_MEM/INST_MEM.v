module INST_MEM ( rst, clk, PC_addr, INST_out );
input [15:0] PC_addr;
input rst, clk;
output reg [15:0] INST_out;
reg [7:0] mem_contents [0:63];

always@(posedge clk, negedge rst )
	if( ~rst )
	begin
		mem_contents[ 16'h0000 ] = 8'hfe;
		mem_contents[ 16'h0001 ] = 8'h20;
		mem_contents[ 16'h0002 ] = 8'hfb;
                mem_contents[ 16'h0003 ] = 8'h21;
                mem_contents[ 16'h0004 ] = 8'h93;
                mem_contents[ 16'h0005 ] = 8'hff;
                mem_contents[ 16'h0006 ] = 8'h84;
                mem_contents[ 16'h0007 ] = 8'h4c;
                mem_contents[ 16'h0008 ] = 8'hf5;
                mem_contents[ 16'h0009 ] = 8'h64;
                mem_contents[ 16'h000a ] = 8'hf1;
                mem_contents[ 16'h000b ] = 8'h65;
                mem_contents[ 16'h000c ] = 8'hd5;
                mem_contents[ 16'h000d ] = 8'h9a;
                mem_contents[ 16'h000e ] = 8'h98;
                mem_contents[ 16'h000f ] = 8'h02;
                mem_contents[ 16'h0010 ] = 8'hce;
                mem_contents[ 16'h0011 ] = 8'h9a;
                mem_contents[ 16'h0012 ] = 8'hff;
                mem_contents[ 16'h0013 ] = 8'hf1;
                mem_contents[ 16'h0014 ] = 8'hf1;
                mem_contents[ 16'h0015 ] = 8'h20;
                mem_contents[ 16'h0016 ] = 8'hf1;
                mem_contents[ 16'h0017 ] = 8'h21;
                mem_contents[ 16'h0018 ] = 8'h88;
                mem_contents[ 16'h0019 ] = 8'h02;
                mem_contents[ 16'h001a ] = 8'ha6;
                mem_contents[ 16'h001b ] = 8'h94;
                mem_contents[ 16'h001c ] = 8'hb6;
                mem_contents[ 16'h001d ] = 8'h96;
                mem_contents[ 16'h001e ] = 8'hc6;
                mem_contents[ 16'h001f ] = 8'h96;
                mem_contents[ 16'h0020 ] = 8'hf7;
                mem_contents[ 16'h0021 ] = 8'hd1;
                mem_contents[ 16'h0022 ] = 8'h67;
                mem_contents[ 16'h0023 ] = 8'h04;
                mem_contents[ 16'h0024 ] = 8'hfb;
                mem_contents[ 16'h0025 ] = 8'h10;
                mem_contents[ 16'h0026 ] = 8'h57;
                mem_contents[ 16'h0027 ] = 8'h05;
                mem_contents[ 16'h0028 ] = 8'hfb;
                mem_contents[ 16'h0029 ] = 8'h20;
                mem_contents[ 16'h002a ] = 8'h47;
                mem_contents[ 16'h002b ] = 8'h02;
                mem_contents[ 16'h002c ] = 8'hf1;
                mem_contents[ 16'h002d ] = 8'h10;
                mem_contents[ 16'h002e ] = 8'hf1;
                mem_contents[ 16'h002f ] = 8'h10;
                mem_contents[ 16'h0030 ] = 8'hc8;
                mem_contents[ 16'h0031 ] = 8'h90;
                mem_contents[ 16'h0032 ] = 8'hf8;
                mem_contents[ 16'h0033 ] = 8'h80;
                mem_contents[ 16'h0034 ] = 8'hd8;
                mem_contents[ 16'h0035 ] = 8'h92;
                mem_contents[ 16'h0036 ] = 8'hca;
                mem_contents[ 16'h0037 ] = 8'h92;
                mem_contents[ 16'h0038 ] = 8'hfc;
                mem_contents[ 16'h0039 ] = 8'hc0;
                mem_contents[ 16'h003a ] = 8'hfd;
                mem_contents[ 16'h003b ] = 8'hd1;
                mem_contents[ 16'h003c ] = 8'hfc;
                mem_contents[ 16'h003d ] = 8'hd0;
                mem_contents[ 16'h003e ] = 8'h00;
                mem_contents[ 16'h003f ] = 8'h00;
	end
	else
		INST_out = { mem_contents[ PC_addr ], mem_contents[ PC_addr+1 ] } ;

endmodule
