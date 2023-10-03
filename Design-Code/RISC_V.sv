module RISC_V #(
    
    parameter WIDTH=32

) (
    input bit clk,
    input bit rst_n
);
                             /*Wires Connect between Modules*/
    logic MemRead,MemWrite;
    logic [WIDTH-1:0] data_in,address,data_out,PC_wire;
    logic [WIDTH-1:0] instruction;

                            /*****************Instantiation*****************/

CPU_wrapper cpu_DUT (instruction,data_out,clk,rst_n,PC_wire,address,data_in,MemRead,MemWrite);

data_mem Dmem_DUT (data_in,address,MemWrite,MemRead,clk,rst_n,data_out);

Inst_mem Imem_DUT (PC_wire,instruction);

endmodule