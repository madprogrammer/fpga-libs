`timescale 1ns/1ps
module uart_sender_tb;

reg [31:0] data_in = 32'h51427963;

reg clk, en;
wire dout, rdy;

uart_sender #(32) us(clk, en, data_in, dout, rdy);

always
begin
    #10 clk = ~clk;
end

initial
begin
    clk = 0;
    en = 0;

    @(posedge clk)
    en = 1;
    @(posedge clk)
    en = 0;
end

initial
begin
    #1000000 $finish;
end

initial
begin
    $dumpfile("uart_sender_tb.vcd");
    $dumpvars(0, uart_sender_tb);
end

endmodule
