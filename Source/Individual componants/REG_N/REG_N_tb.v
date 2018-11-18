`include "REG_N.v"

module REG_32_tb();
reg clk, rst, write_enable;
reg [15:0] wdata;
wire [15:0] rdata;

REG_N #(.reg_size(24)) DUT(
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .wdata(wdata),
        .rdata(rdata)
        );


initial
begin
        clk = 1'b0;
        forever #10 clk = ~clk;
end

initial
begin
        rst = 0;
        wdata = 125;
        #20 rst = 1;
        #20 write_enable = 1;
        #20 wdata = 235094;
        #21 rst = 0;
	#30 rst = 1;
        #20 $finish;
end

initial
begin
        $dumpvars;
        $display("clk | rst | write_enable | wdata | rdata |");
        $monitor(" %b | %b  | %b           | %b    | %b    |", clk, rst, write_enable, wdata, rdata);
end

endmodule
