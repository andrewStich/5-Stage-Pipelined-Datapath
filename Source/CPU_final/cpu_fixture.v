`include "cpu.v";
module cpu_fixture();
reg clk, reset;

cpu DUT(
	.clk(clk),
	.reset(reset)
	);
initial
	$vcdpluson;

initial //clk
begin
	clk = 0;
	forever #10 clk = ~clk;
end

always@( negedge clk) //display
begin
	if($time > 1) begin
	$display("\n\t\tTime = %4d\tPC = %h\n\tRegister Values:", $time, cpu.PC.rdata);
	$display("\t\tR0 = %h\tR4 = %h\tR8 = %h\tR12 = %h", cpu.registers.registers[0], cpu.registers.registers[4], cpu.registers.registers[8], cpu.registers.registers[12]);
	$display("\t\tR1 = %h\tR5 = %h\tR9 = %h\tR13 = %h", cpu.registers.registers[1], cpu.registers.registers[5], cpu.registers.registers[9], cpu.registers.registers[13]);
	$display("\t\tR2 = %h\tR6 = %h\tR10 = %h\tR14 = %h", cpu.registers.registers[2], cpu.registers.registers[6], cpu.registers.registers[10], cpu.registers.registers[14]);
	$display("\t\tR3 = %h\tR7 = %h\tR11 = %h\tR15 = %h", cpu.registers.registers[3], cpu.registers.registers[7], cpu.registers.registers[11], cpu.registers.registers[15]);
	$display("\tMemory Values:");
	$display("\t\tmem[00] = %h\tmem[02] = %h",{cpu.data_memory.memory[0],cpu.data_memory.memory[1]}, {cpu.data_memory.memory[2],cpu.data_memory.memory[3]} );
	$display("\t\tmem[04] = %h\tmem[06] = %h",{cpu.data_memory.memory[4],cpu.data_memory.memory[5]}, {cpu.data_memory.memory[6],cpu.data_memory.memory[7]} );
	$display("\t\tmem[08] = %h\tmem[0A] = %h",{cpu.data_memory.memory[8],cpu.data_memory.memory[9]}, {cpu.data_memory.memory[10],cpu.data_memory.memory[11]} );
	end
end

initial
begin
	reset = 0;
	#5 reset = 1;
	#700 $finish;
end
endmodule