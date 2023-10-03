module MUX_3x1 #(
    parameter WIDTH=32
) (
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [WIDTH-1:0] C,
    input  [1:0] SEL,
    output reg [WIDTH-1:0] out 
);
    always @(*) begin
        if (SEL==1'b0) begin
            out<=A;
        end
        else if (SEL==1'b1) begin
            out<=B;
        end
        else if (SEL==2'b10) begin
            out<=C;
        end
    end



endmodule