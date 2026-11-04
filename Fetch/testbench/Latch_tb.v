`timescale 1ns / 1ps

module Latch_tb();

reg clk_tb;
reg rst_tb;
reg [31:0] next_pc_tb;
reg [31:0] instrmem_out_tb;

wire [31:0] pc_val_tb;
wire [31:0] instr_out_tb;

Latch DUT(
    .clk(clk_tb),
    .rst(rst_tb),
    .next_pc(next_pc_tb),
    .instrmem_out(instrmem_out_tb),
    .pc_val(pc_val_tb),
    .instr_out(instr_out_tb)
);

initial clk_tb = 0;
always #5 clk_tb = ~clk_tb;

initial begin

    rst_tb = 1;
    next_pc_tb = 32'd0;
    instrmem_out_tb = 32'h00000000;
    #10;

    rst_tb = 0;

    next_pc_tb = 32'd4;
    instrmem_out_tb = 32'hA00000AA;
    #10;

    next_pc_tb = 32'd8;
    instrmem_out_tb = 32'h10000011;
    #10;

    next_pc_tb = 32'd12;
    instrmem_out_tb = 32'h20000022;
    #10;

    next_pc_tb = 32'd16;
    instrmem_out_tb = 32'h30000033;
    #10;

    next_pc_tb = 32'd20;
    instrmem_out_tb = 32'h40000044;
    #10;

    next_pc_tb = 32'd24;
    instrmem_out_tb = 32'h50000055;
    #10;

    next_pc_tb = 32'd28;
    instrmem_out_tb = 32'h60000066;
    #10;

    next_pc_tb = 32'd32;
    instrmem_out_tb = 32'h70000077;
    #10;

    next_pc_tb = 32'd36;
    instrmem_out_tb = 32'h80000088;
    #10;

    $finish;

end

endmodule