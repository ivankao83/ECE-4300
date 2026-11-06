`timescale 1ns / 1ps

module executeTB;

    reg clk;
    reg [1:0] ctlwb_in, ctlm_in;
    reg [31:0] npc, rdata1, rdata2, s_extend;
    reg [4:0] instr_2016, instr_1511;
    reg [1:0] alu_op;
    reg [5:0] funct;
    reg alusrc, regdst;

    wire [1:0] ctlwb_out, ctlm_out;
    wire [31:0] adder_out, alu_result_out, rdata2_out;
    wire [4:0] muxout_out;

    execute uut (
        .clk(clk),
        .ctlwb_in(ctlwb_in),
        .ctlm_in(ctlm_in),
        .npc(npc),
        .rdata1(rdata1),
        .rdata2(rdata2),
        .s_extend(s_extend),
        .instr_2016(instr_2016),
        .instr_1511(instr_1511),
        .alu_op(alu_op),
        .funct(funct),
        .alusrc(alusrc),
        .regdst(regdst),

        .ctlwb_out(ctlwb_out),
        .ctlm_out(ctlm_out),
        .adder_out(adder_out),
        .alu_result_out(alu_result_out),
        .rdata2_out(rdata2_out),
        .muxout_out(muxout_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("execute.vcd");
        $dumpvars(0, executeTB);

        // Test 1 - add
        ctlwb_in = 2'b10;
        ctlm_in = 2'b01;

        npc = 32'd100;
        rdata1 = 32'd10;
        rdata2 = 32'd20;
        s_extend = 32'd4;

        instr_2016 = 5'd5;
        instr_1511 = 5'd10;

        alu_op = 2'b10;
        funct = 6'b100000;

        alusrc = 1;
        regdst = 1;

        #15;

        $display("Test 1: ADD");
        $display("Adder Result = %d", adder_out);
        $display("ALU Result = %d", alu_result_out);
        $display("MUX Result = %d", muxout_out);

        // Test 2 - sub
        @(negedge clk);

        alusrc = 0;
        regdst = 0;
        s_extend = 32'd8;

        alu_op = 2'b01;
        funct = 6'b100010;

        #15;

        $display("Test 2: SUB");
        $display("Adder Result = %d", adder_out);
        $display("ALU Result = %d", $signed(alu_result_out));
        $display("MUX Result = %d", muxout_out);

        $finish;
    end

endmodule
