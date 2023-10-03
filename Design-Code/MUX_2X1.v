module MUX_2x1 #(
    parameter WIDTH=32
) (
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input   SEL,
    output reg [WIDTH-1:0] out 
);
    always @(*) begin
        if (SEL==1'b0) begin
            out<=A;
        end
        else begin 
            out<=B;
        end
    end



endmodule