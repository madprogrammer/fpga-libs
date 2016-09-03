`timescale 1ns/1ps
module bcdcount_tb;

reg clk;

wire [7:0] dig1;
wire [7:0] dig2;
wire [7:0] dig3;

wire carry12;
wire carry23;

bcdcount d1(.clk(clk), .digit(dig1), .carry(carry12));
bcdcount d2(.clk(carry12), .digit(dig2), .carry(carry23));
bcdcount d3(.clk(carry23), .digit(dig3));

always
begin
    #10 clk = ~clk;
end

initial
begin
    clk = 0;
end

initial
begin
    #10000 $finish;
end

initial
begin
    $dumpfile("bcdcount_tb.vcd");
    $dumpvars(0, bcdcount_tb);
end

endmodule
