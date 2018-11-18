module REG_N ( clk, rst, wdata, write_enable, rdata );
parameter reg_size = 32;
input clk, rst, write_enable;
input [reg_size - 1:0] wdata;
output reg [reg_size - 1:0] rdata;

always@( posedge clk, negedge rst )

     if( !rst )
          rdata <= 0;
     else if( write_enable )
          rdata <= wdata;

endmodule

