module adder #(
    parameter WIDTH=32
) (
    input     [WIDTH-1:0] A,
    input     [WIDTH-1:0] B,
    output reg[WIDTH-1:0] Sum
);

always @(*) begin
    Sum=A+B;
end
    
endmodule