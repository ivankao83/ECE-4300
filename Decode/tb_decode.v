`timescale 1ns / 1ps

module tb_decode;

    reg clk;
    reg rst;
    reg wb_reg_write;

    reg [4:0] wb_write_reg_location;
    reg [31:0] mem_wb_write_data;
    reg [31:0] if_id_instr;
    reg [31:0] if_id_npc;

    wire [1:0] id_ex_wb;
    wire [2:0] id_ex_mem;
    wire [3:0] id_ex_execute;

    wire [31:0] id_ex_npc;
    wire [31:0] id_ex_readdat1;
    wire [31:0] id_ex_readdat2;
    wire [31:0] id_ex_sign_ext;

    wire [4:0] id_ex_instr_bits_20_16;
    wire [4:0] id_ex_instr_bits_15_11;

    decode uut (
        .clk(clk),
        .rst(rst),
        .wb_reg_write(wb_reg_write),
        .wb_write_reg_location(wb_write_reg_location),
        .mem_wb_write_data(mem_wb_write_data),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_npc),

        .id_ex_wb(id_ex_wb),
        .id_ex_mem(id_ex_mem),
        .id_ex_execute(id_ex_execute),
        .id_ex_npc(id_ex_npc),
        .id_ex_readdat1(id_ex_readdat1),
        .id_ex_readdat2(id_ex_readdat2),
        .id_ex_sign_ext(id_ex_sign_ext),
        .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16),
        .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        wb_reg_write = 0;
        wb_write_reg_location = 0;
        mem_wb_write_data = 0;
        if_id_instr = 0;
        if_id_npc = 0;

        // reset off
        #20;
        rst = 0;

        // write 10 into register 1
        wb_reg_write = 1;
        wb_write_reg_location = 5'd1;
        mem_wb_write_data = 32'd10;

        // write 20 into register 2
        #10;
        wb_write_reg_location = 5'd2;
        mem_wb_write_data = 32'd20;

        //  write 30 into register 3
        #10;
        wb_write_reg_location = 5'd3;
        mem_wb_write_data = 32'd30;

        #10;
        wb_reg_write = 0;

        // read register 1 = 10 and register 2 = 20
        if_id_instr = 32'h00221820;
        if_id_npc = 32'd4;

        // LW: lw $2, 8($1)
        #20;
        if_id_instr = 32'h8C220008;
        if_id_npc = 32'd8;

        // SW: sw $3, 12($1)
        #20;
        if_id_instr = 32'hAC23000C;
        if_id_npc = 32'd12;

        // BEQ: beq $1, $2, -4
        #20;
        if_id_instr = 32'h1022FFFC;
        if_id_npc = 32'd16;

        // change register 1 to 99
        #20;
        wb_reg_write = 1;
        wb_write_reg_location = 5'd1;
        mem_wb_write_data = 32'd99;

        // read register 1 again using LW
        #10;
        wb_reg_write = 0;
        if_id_instr = 32'h8C22FFFC;
        if_id_npc = 32'd20;

        // reset
        #20;
        rst = 1;

        #20;
        $finish;
    end

endmodule