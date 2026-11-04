`timescale 1ns / 1ps

module adder(
input wire [31:0] pc_out,
output wire [31:0] next_pc
);

assign next_pc = pc_out + 32'd4;

endmodule