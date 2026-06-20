module clk_en
#(
    parameter CLK_HZ  = 50000000,
    parameter TICK_HZ = 10
)
(
    input  wire clk,
    input  wire rst_n,
    output reg  tick
);

localparam integer DIV = CLK_HZ / TICK_HZ;

reg [31:0] count;

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        count <= 0;
        tick  <= 1'b0;
    end
    else
    begin
        tick <= 1'b0;

        if(count == DIV-1)
        begin
            count <= 0;
            tick  <= 1'b1;
        end
        else
        begin
            count <= count + 1;
        end
    end
end

endmodule