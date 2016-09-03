`default_nettype none

module bcdcount #(parameter START = 8'h30, STOP = 8'h39) (
    input wire clk,
    output wire [7:0] digit,
    output reg carry
);

reg [7:0] cnt = START;

always @ (posedge clk)
begin
    carry <= 1'b0;
    if (cnt == STOP)
    begin
        cnt <= START;
        carry <= 1'b1;
    end
    else
    begin
        cnt <= (cnt + 8'd1);
    end
end

assign digit = cnt;

endmodule
