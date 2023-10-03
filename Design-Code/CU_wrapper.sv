module CU_wrapper #(
    
    parameter WIDTH=32

) (
    input  [WIDTH-1:0] inst,
    /*Branch-Comparator-Signals*/
    input logic Equal,NEqual,Less_Than,Greater_Equal,
    /*Control-Signals*/
    output  logic AluSrc,RegWrite,MemRead,MemWrite,
    output  logic [1:0] MemtoReg,PCSrc,
    output  logic [2:0] ImmSel,AluOp,
    output  logic [3:0] opcode
);

    logic AluSrc_wire,RegWrite_wire,MemRead_wire,MemWrite_wire;
    logic [1:0] MemtoReg_wire,PCSrc_wire;
    logic [2:0] ImmSel_wire,AluOp_wire;
    logic [3:0] opcode_wire;

                                    /*******************Instantiation********************/
control_unit dut (inst[6:0],Equal,NEqual,Less_Than,Greater_Equal,AluSrc_wire,MemtoReg_wire,RegWrite_wire,MemRead_wire,MemWrite_wire,PCSrc_wire,ImmSel_wire,AluOp_wire);

Alu_Control alu_control_dut (AluOp_wire,inst,opcode_wire);

                                    /*Assign-The-used-Wires-To-The-Outputs*/
assign AluSrc=AluSrc_wire;
assign RegWrite=RegWrite_wire;
assign MemRead=MemRead_wire;
assign MemWrite=MemWrite_wire;
assign MemtoReg=MemtoReg_wire;
assign PCSrc=PCSrc_wire;
assign ImmSel=ImmSel_wire;
assign AluOp=AluOp_wire;
assign opcode=opcode_wire;

endmodule