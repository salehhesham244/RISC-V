module data_mem #(

    parameter MEM_WIDTH=32,
    parameter MEM_DEPTH=1024,
    parameter ADDR_SIZE=32

) (
    input [MEM_WIDTH-1:0]  din,
    input [ADDR_SIZE-1:0] addr,
    input w_en,
    input R_en,
    input clk,
    input rst,
    output [MEM_WIDTH-1:0] dout 
);


//create the memory.
reg [MEM_WIDTH-1:0] ram [MEM_DEPTH-1:0];
integer i;
always @(posedge clk) begin
        if (!rst) begin
            for (i=0;i<1023;i=i+1) begin
                ram[i]<=0;
            end
        end
        else if (w_en==1) begin
            ram[addr]<=din;
        end
end 

assign dout=(R_en==1)?ram[addr]:32'h00000;

endmodule //syn_ram