`timescale 1ns / 1ps

module instruction_mem(
input wire [31:0] pc_out,
output wire [31:0] instrmem_out
);

reg [31:0] memory [0:36];

initial begin
memory[0]  = 32'hA00000AA;
memory[4]  = 32'h10000011;
memory[8]  = 32'h20000022;
memory[12] = 32'h30000033;
memory[16] = 32'h40000044;
memory[20] = 32'h50000055;
memory[24] = 32'h60000066;
memory[28] = 32'h70000077;
memory[32] = 32'h80000088;
memory[36] = 32'h90000099;
end

assign instrmem_out = memory[pc_out];

endmodule