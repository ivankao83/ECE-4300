`timescale 1ns / 1ps

module Mux(
input wire PCSrc,
input wire [31:0] pc_from_ExMem,
input wire [31:0] next_pc,
output wire [31:0] pc_in
);

assign pc_in = PCSrc ? pc_from_ExMem : next_pc;

endmodule