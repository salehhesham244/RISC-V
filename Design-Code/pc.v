module pc #(

    parameter WIDTH =32
 
)(
    
    input [WIDTH-1:0] D,
    input clk,
    input rst,
    output  reg [WIDTH-1:0] out
);

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        out<=0;
    end
    else begin
        out<=D;
    end
end

endmodule //pc