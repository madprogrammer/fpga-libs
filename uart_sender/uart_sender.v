`default_nettype none

module uart_sender #(parameter WIDTH = 8) (
    input wire clk,
    input wire en,
    input wire [WIDTH-1:0] data_in, 
    output wire dout,
    output reg rdy
);

reg [3:0] idx = 4'd0;
reg [7:0] tx_data;

reg tx_enable = 1'b0;
reg tx_reset = 1'b1;
wire tx_ready;


uart_tx tx(.clk(clk), .rst(tx_reset), .dout(dout), .data_in(tx_data), .en(tx_enable), .rdy(tx_ready));

always @ (posedge clk)
begin
    // clear global ready flag
    rdy <= 1'b0;
    tx_reset <= 1'b0;

    if (en)
    begin
        // how many bytes to send
        idx <= WIDTH >> 3;
        tx_reset <= 1'b1;
    end
    if (idx != 0 && tx_ready == 1'b1)
    begin
        // still have data to send
        tx_data <= data_in[8 * idx - 1 -: 8];
        tx_enable <= 1'b1;
    end
    if (tx_enable && tx_ready == 1'b0)
    begin
        // transmission of next byte started
        tx_enable <= 1'b0;
        idx <= (idx - 4'd1);
    end
    if (idx == 0 && tx_ready == 1'b1)
    begin
        // transmission of last byte ended;
        // this is also the idle state
        rdy <= 1'b1;
    end
end

endmodule
