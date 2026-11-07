`timescale 1ns / 1ps

//Takes the values from Decode and passes the results to EX/MEM

module execute(
    input wire clk,
    input wire [1:0] ctlwb_in,
    input wire [2:0] ctlm_in,
    input wire [31:0] npc, rdata1, rdata2, s_extend,
    input wire [4:0] instr_2016, instr_1511,
    input wire [1:0] alu_op,
    input wire [5:0] funct,
    input wire alusrc, regdst,

    output wire [1:0] ctlwb_out,
    output wire [2:0] ctlm_out,
    output wire [31:0] adder_out, alu_result_out, rdata2_out,
    output wire [4:0] muxout_out,
    output wire zero
);

    //internal wires to connect the modules
    wire [31:0] b, aluout;
    wire [31:0] adder_internal;
    wire [4:0] muxout;
    wire [2:0] control;
    wire aluzero;

    //adds npc and the sign extended value
    adder adder3(
        .add_in1(npc),
        .add_in2(s_extend),
        .add_out(adder_internal)
    );

    //chooses the destination register
    bottom_mux bottom_mux3(
        .a(instr_1511),
        .b(instr_2016),
        .sel(regdst),
        .y(muxout)
    );

    //uses aluop and funct to select the alu operation
    alu_control alu_control3(
        .funct(funct),
        .aluop(alu_op),
        .select(control)
    );

    //performs the selected operation
    alu alu3(
        .a(rdata1),
        .b(b),
        .control(control),
        .result(aluout),
        .zero(aluzero)
    );


    //chooses between register data and immediate value
    top_mux top_mux3(
        .y(b),
        .a(s_extend),
        .b(rdata2),
        .alusrc(alusrc)
    );

    //stores the results for the next stage
    ex_mem ex_mem3(
        .clk(clk),
        .rst(1'b0),
        .ctlwb_out(ctlwb_in),
        .ctlm_out(ctlm_in),
        .adder_out(adder_internal),
        .aluzero(aluzero),
        .aluout(aluout),
        .readdat2(rdata2),
        .muxout(muxout),

        //outputs
        .wb_ctlout(ctlwb_out),
        .branch(ctlm_out[2]),
        .memread(ctlm_out[1]),
        .memwrite(ctlm_out[0]),
        .add_result(adder_out),
        .zero(zero),
        .alu_result(alu_result_out),
        .rdata2out(rdata2_out),
        .five_bit_muxout(muxout_out)
    );

endmodule
