module reset #(parameter COUNT = 8) (
    input wire clk,
    input wire en,
    output wire reset
);

reg [COUNT-1:0] counter = {COUNT{1'b1}};

always @ (posedge clk)
begin
    counter <= {1'b1, counter[COUNT-1:1]};
    if (en)
    begin
        counter <= {COUNT{1'b0}};
    end
end

assign reset = counter[0];

endmodule
