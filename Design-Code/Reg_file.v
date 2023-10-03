module Reg_file  #(

        parameter WIDTH=32, 
        parameter DEPTH=32
) 
(
     input clk,
     input reg_write,
     input [4:0] AddrD, 
     input [4:0] AddrA,
     input [4:0] AddrB,
     input [WIDTH-1:0] DataD,
     output  [WIDTH-1:0] DataA,
     output  [WIDTH-1:0] DataB
);

reg [WIDTH-1:0] regfile [DEPTH-1:0];

integer i;
initial begin
    for (i=0;i<DEPTH;i=i+1) begin
        regfile[i]<=32'h00000;
    end
end

always @(posedge clk) begin
    if (reg_write==1) begin
        regfile[AddrD]<=DataD;
    end
end

assign DataA=regfile[AddrA];
assign DataB=regfile[AddrB];

endmodule //Reg_file