`timescale 1ns / 1ps

module executeTB;

    reg clk;
    reg [1:0] ctlwb_in;
    reg [2:0] ctlm_in;
    reg [31:0] npc, rdata1, rdata2, s_extend;
    reg [4:0] instr_2016, instr_1511;
    reg [1:0] alu_op;
    reg [5:0] funct;
    reg alusrc, regdst;

    wire [1:0] ctlwb_out;
    wire zero;
    wire [2:0] ctlm_out;
    wire [31:0] adder_out, alu_result_out, rdata2_out;
    wire [4:0] muxout_out;

    //connects the Execute stage
    execute uut(
        .clk(clk),
        .zero(zero),
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

    //clock changes every 5 ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("execute.vcd");
        $dumpvars(0, executeTB);

        // Test 1 - ADD
        ctlwb_in = 2'b10;
        ctlm_in = 3'b000;
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
        $display("Test 1 - ADD: ALU = %h", alu_result_out);

        // Test 2 - SUB
        @(negedge clk);
        alusrc = 0;
        regdst = 0;
        s_extend = 32'd8;
        alu_op = 2'b01;
        funct = 6'b100010;

        #15;
        $display("Test 2 - SUB: ALU = %h", alu_result_out);

        // Test 3 - BEQ
        @(negedge clk);
        ctlwb_in = 2'b00;
        ctlm_in = 3'b100;
        rdata1 = 32'd10;
        rdata2 = 32'd10;
        alu_op = 2'b01;
        alusrc = 0;

        #15;
        $display("Test 3 - BEQ: ALU = %h, Zero = %b",
                 alu_result_out, zero);

        // Test 4 - LW
        @(negedge clk);
        ctlwb_in = 2'b11;
        ctlm_in = 3'b010;
        rdata1 = 32'd10;
        s_extend = 32'd8;
        alu_op = 2'b00;
        alusrc = 1;
        regdst = 0;

        #15;
        $display("Test 4 - LW: ALU = %h", alu_result_out);


        // Test 5 - SW
        @(negedge clk);
        ctlwb_in = 2'b00;
        ctlm_in = 3'b001;
        alu_op = 2'b00;
        alusrc = 1;

        #15;
        $display("Test 5 - SW: ALU = %h", alu_result_out);

        // Test 6 - R-type AND
        @(negedge clk);
        ctlwb_in = 2'b10;
        ctlm_in = 3'b000;
        rdata1 = 32'd10;
        rdata2 = 32'd20;
        alu_op = 2'b10;
        funct = 6'b100100;
        alusrc = 0;
        regdst = 1;

        #15;
        $display("Test 6 - AND: ALU = %h", alu_result_out);

        // Test 7 - R-type OR
        @(negedge clk);
        funct = 6'b100101;

        #15;
        $display("Test 7 - OR: ALU = %h", alu_result_out);

        // Test 8 - R-type SLT
        @(negedge clk);
        funct = 6'b101010;

        #15;
        $display("Test 8 - SLT: ALU = %h", alu_result_out);

        $finish;
    end

endmodule
