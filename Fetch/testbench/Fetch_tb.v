`timescale 1ns / 1ps

module Fetch_tb();

    reg clk_tb;
    reg rst_tb;
    reg PCSrc_tb;
    reg [31:0] pc_from_ExMem_tb;

    wire [31:0] if_id_instr_tb;
    wire [31:0] if_id_pc_tb;

    Fetch DUT(
        .clk(clk_tb),
        .rst(rst_tb),
        .PCSrc(PCSrc_tb),
        .pc_from_ExMem(pc_from_ExMem_tb),
        .if_id_instr(if_id_instr_tb),
        .if_id_pc(if_id_pc_tb)
    );

    initial clk_tb <= 0;
    always #1 clk_tb <= ~clk_tb;

    initial begin
        rst_tb <= 1;
        #2;
        rst_tb <= 0;
    end

    initial begin
        PCSrc_tb <= 0;
        pc_from_ExMem_tb <= 32'hFFFFFFFF;

        #20;

        pc_from_ExMem_tb <= 32'h00000000;
        PCSrc_tb <= 1;

        #50;

        PCSrc_tb <= 0;

        #20;

        $finish;
    end

endmodule