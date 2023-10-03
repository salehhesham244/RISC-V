module CPU_wrapper #(

    parameter WIDTH=32

) (
    /*Inputs of The CPU*/
    input  logic [WIDTH-1:0] inst,
    input  logic [WIDTH-1:0] Read_DMem,
    input  bit clk,rst_n,

    /*Outputs of The CPU*/
    output logic [WIDTH-1:0] PC,
    output logic [WIDTH-1:0] address,
    output logic [WIDTH-1:0] Written_DMem,
    output logic MemRead,
    output logic MemWrite    
);
                        /*Wires Connect between Modules*/
    logic  [WIDTH-1:0] PC_wire,address_wire,Written_DMem_wire;
    logic  Equal,NEqual,Less_Than,Greater_Equal;
    logic  AluSrc,RegWrite,MemRead_wire,MemWrite_wire;
    logic  [1:0] MemtoReg,PCSrc;
    logic  [2:0] ImmSel,AluOp;
    logic  [3:0] opcode;

                        /*******************Instantiation********************/
CU_wrapper CU_DUT (inst,Equal,NEqual,Less_Than,Greater_Equal,
                       AluSrc,RegWrite,MemRead_wire,MemWrite_wire,MemtoReg,
                       PCSrc,ImmSel,AluOp,opcode);

data_Path Dpath_DUT (inst,Read_DMem,clk,rst_n,AluSrc,RegWrite,
                        MemRead_wire,MemWrite_wire,MemtoReg,PCSrc,ImmSel,
                        AluOp,opcode,PC_wire,address_wire,Written_DMem_wire,
                        Equal,NEqual,Less_Than,Greater_Equal);

                        /*Assign-The-used-Wires-To-The-Outputs*/
assign PC=PC_wire;
assign address=address_wire;
assign Written_DMem=Written_DMem_wire;
assign MemRead=MemRead_wire;
assign MemWrite=MemWrite_wire;

endmodule