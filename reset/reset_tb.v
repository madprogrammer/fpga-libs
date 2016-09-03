`timescale 1ns/1ps
module reset_tb;

reg clk;
reg en;

wire rst_out;

reset rst(clk, en, rst_out);

always
    #10 clk = ~clk;

initial
begin
    clk = 0;
    en = 0;
    @(posedge clk);
    en = 1;
    @(posedge clk);
    en = 0;
end

initial
begin
    #400 $finish;
end

initial
begin
    $dumpfile("reset_tb.vcd");
    $dumpvars(0, reset_tb);
end

endmodule
