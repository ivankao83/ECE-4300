`timescale 1ns / 1ps

module Latch(
input wire clk,
input wire rst,
input wire [31:0] next_pc,
input wire [31:0] instrmem_out,
output reg [31:0] pc_val,
output reg [31:0] instr_out
);

always @(posedge clk or posedge rst) begin
if (rst) begin
pc_val <= 32'd0;
instr_out <= 32'd0;
end
else begin
pc_val <= next_pc;
instr_out <= instrmem_out;
end
end

endmodule