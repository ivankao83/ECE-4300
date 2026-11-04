`timescale 1ns / 1ps

module Mux_tb();

reg PCSrc_tb;
reg [31:0] pc_from_ExMem_tb;
reg [31:0] next_pc_tb;

wire [31:0] pc_in_tb;

Mux DUT(
    .PCSrc(PCSrc_tb),
    .pc_from_ExMem(pc_from_ExMem_tb),
    .next_pc(next_pc_tb),
    .pc_in(pc_in_tb)
);

initial begin

    pc_from_ExMem_tb = 32'd100;
    next_pc_tb = 32'd4;
    PCSrc_tb = 0;
    #10;

    pc_from_ExMem_tb = 32'd100;
    next_pc_tb = 32'd8;
    PCSrc_tb = 1;
    #10;

    pc_from_ExMem_tb = 32'd200;
    next_pc_tb = 32'd12;
    PCSrc_tb = 0;
    #10;

    pc_from_ExMem_tb = 32'd200;
    next_pc_tb = 32'd16;
    PCSrc_tb = 1;
    #10;

    pc_from_ExMem_tb = 32'd300;
    next_pc_tb = 32'd20;
    PCSrc_tb = 0;
    #10;

    pc_from_ExMem_tb = 32'd300;
    next_pc_tb = 32'd24;
    PCSrc_tb = 1;
    #10;

    $finish;

end

endmodule