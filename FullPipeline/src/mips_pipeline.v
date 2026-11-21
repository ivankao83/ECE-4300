`timescale 1ns / 1ps
//Connects all five stages of the MIPS pipeline
module mips_pipeline(
    input wire clk,
    input wire rst
);

    //Fetch outputs
    wire [31:0] if_id_instr;
    wire [31:0] if_id_pc;

    //Decode outputs
    wire [1:0] id_ex_wb;
    wire [2:0] id_ex_mem;
    wire [3:0] id_ex_execute;
    wire [31:0] id_ex_npc;
    wire [31:0] id_ex_readdat1;
    wire [31:0] id_ex_readdat2;
    wire [31:0] id_ex_sign_ext;
    wire [4:0] id_ex_instr_bits_20_16;
    wire [4:0] id_ex_instr_bits_15_11;
    wire [5:0] id_ex_funct;

    //Execute outputs
    wire [1:0] ex_mem_wb;
    wire [2:0] ex_mem_control;
    wire [31:0] ex_mem_branch_addr;
    wire [31:0] ex_mem_alu_result;
    wire [31:0] ex_mem_write_data;
    wire [4:0] ex_mem_write_reg;
    wire ex_mem_zero;

    //Memory outputs
    wire [31:0] mem_wb_read_data;
    wire [31:0] mem_wb_alu_result;
    wire [4:0] mem_wb_write_reg;
    wire [1:0] mem_wb_control;
    wire PCSrc;

    //Writeback outputs
    wire [31:0] wb_write_data;
    wire [4:0] wb_write_reg;
    wire wb_regwrite;

    //Stage 1 - Fetch
    Fetch fetch0(
        .clk(clk),
        .rst(rst),
        .PCSrc(PCSrc),
        .pc_from_ExMem(ex_mem_branch_addr),
        .if_id_instr(if_id_instr),
        .if_id_pc(if_id_pc)
    );

    //Stage 2 - Decode
    decode decode0(
        .clk(clk),
        .rst(rst),
        .wb_reg_write(wb_regwrite),
        .wb_write_reg_location(wb_write_reg),
        .mem_wb_write_data(wb_write_data),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_pc),

        .id_ex_wb(id_ex_wb),
        .id_ex_mem(id_ex_mem),
        .id_ex_execute(id_ex_execute),
        .id_ex_npc(id_ex_npc),
        .id_ex_readdat1(id_ex_readdat1),
        .id_ex_readdat2(id_ex_readdat2),
        .id_ex_sign_ext(id_ex_sign_ext),
        .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16),
        .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11),
        .id_ex_funct(id_ex_funct)
    );

    //Stage 3 - Execute
    execute execute0(
        .clk(clk),
        .rst(rst),
        .ctlwb_in(id_ex_wb),
        .ctlm_in(id_ex_mem),
        .npc(id_ex_npc),
        .rdata1(id_ex_readdat1),
        .rdata2(id_ex_readdat2),
        .s_extend(id_ex_sign_ext),
        .instr_2016(id_ex_instr_bits_20_16),
        .instr_1511(id_ex_instr_bits_15_11),
        .alu_op(id_ex_execute[2:1]),
        .funct(id_ex_funct),
        .alusrc(id_ex_execute[0]),
        .regdst(id_ex_execute[3]),

        .ctlwb_out(ex_mem_wb),
        .ctlm_out(ex_mem_control),
        .adder_out(ex_mem_branch_addr),
        .alu_result_out(ex_mem_alu_result),
        .rdata2_out(ex_mem_write_data),
        .muxout_out(ex_mem_write_reg),
        .zero(ex_mem_zero)
    );

    //Stage 4 - Memory
    mem_stage memory0(
        .clk(clk),
        .ALUResult(ex_mem_alu_result),
        .WriteData(ex_mem_write_data),
        .WriteReg(ex_mem_write_reg),
        .WBControl(ex_mem_wb),
        .MemWrite(ex_mem_control[0]),
        .MemRead(ex_mem_control[1]),
        .Branch(ex_mem_control[2]),
        .Zero(ex_mem_zero),

        .ReadData(mem_wb_read_data),
        .ALUResult_out(mem_wb_alu_result),
        .WriteReg_out(mem_wb_write_reg),
        .WBControl_out(mem_wb_control),
        .PCSrc(PCSrc)
    );

    //Stage 5 - Writeback
    writeback writeback0(
        .ReadData(mem_wb_read_data),
        .ALUResult(mem_wb_alu_result),
        .WriteReg(mem_wb_write_reg),
        .WBControl(mem_wb_control),

        .WriteData(wb_write_data),
        .WriteReg_out(wb_write_reg),
        .RegWrite(wb_regwrite)
    );

endmodule
