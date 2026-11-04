`timescale 1ns / 1ps

module Fetch(
input wire clk,
input wire rst,
input wire PCSrc,
input wire [31:0] pc_from_ExMem,
output wire [31:0] if_id_instr,
output wire [31:0] if_id_pc
);

wire [31:0] pc_out;
wire [31:0] next_pc;
wire [31:0] pc_in;
wire [31:0] instrmem_out;

Mux mux0(
.PCSrc(PCSrc),
.pc_from_ExMem(pc_from_ExMem),
.next_pc(next_pc),
.pc_in(pc_in)
);

program_counter pc0(
.clk(clk),
.rst(rst),
.pc_in(pc_in),
.pc_out(pc_out)
);

adder add0(
.pc_out(pc_out),
.next_pc(next_pc)
);

instruction_mem im0(
.pc_out(pc_out),
.instrmem_out(instrmem_out)
);

Latch Latch0(
.clk(clk),
.rst(rst),
.next_pc(next_pc),
.instrmem_out(instrmem_out),
.pc_val(if_id_pc),
.instr_out(if_id_instr)
);

endmodule