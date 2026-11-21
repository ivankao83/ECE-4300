`timescale 1ns / 1ps

//Tests the complete MIPS pipeline
module mips_pipeline_tb;

    reg clk;
    reg rst;

    //connects the full pipeline
    mips_pipeline uut(
        .clk(clk),
        .rst(rst)
    );

    //clock changes every 5 ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        //resets the pipeline
        rst = 1;

        //releases reset between clock edges
        #12;
        rst = 0;

        //allows the instructions to run
        #1000;
        $finish;
    end

endmodule
