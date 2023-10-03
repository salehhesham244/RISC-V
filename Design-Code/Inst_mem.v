module Inst_mem (

     input [31:0] addr,
     output reg  [31:0] instruction

);

reg [31:0] mem [1023:0];

initial begin
$readmemh ("rom_data.dat",mem);
end

always @(addr) begin
     instruction=mem[addr];
end


endmodule //I_ram