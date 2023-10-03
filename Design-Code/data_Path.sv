module data_Path #(
   
    parameter  WIDTH=32 

)(
    input  logic [WIDTH-1:0] inst,
    input  logic [WIDTH-1:0] Read_DMem,
    input  bit clk,rst_n,
    
    /*Control-Signals*/
    input  logic AluSrc,RegWrite,MemRead,MemWrite,
    input  logic [1:0] MemtoReg,PCSrc,
    input  logic [2:0] ImmSel,AluOp,
    
    /*ALU-Control-Signal*/
    input  logic [3:0] opcode,

    /*Output-Signals*/
    output logic [WIDTH-1:0] PC,
    output logic [WIDTH-1:0] address,
    output logic [WIDTH-1:0] Written_DMem,
    output logic Equal,NEqual,Less_Than,Greater_Equal
);

/*Used wires to connect Between Modules*/
logic [WIDTH-1:0] pc_input,pc_output,Read_data1,
                  Read_data2,Immmediate,ALU_input,ALU_output,
                  Adder_out1,Adder_out2,Reg_data;

                           /***********Instantiations*****************/

pc pc_dut (pc_input,clk,rst_n,pc_output);

/*The input address to the instruction Memory*/
assign PC =pc_output;

Imm_gen Immgen_dut (ImmSel,inst,Immmediate);

Reg_file RegFile_dut (clk,RegWrite,inst[11:7],inst[19:15],inst[24:20],Reg_data,Read_data1,Read_data2);

/*To choose the input data to the second operand of the ALU*/
MUX_2x1 mux_2x1_dut (Read_data2,Immmediate,AluSrc,ALU_input);

/*To add 4 to the current PC*/
adder adder_dut1 (32'h4,pc_output,Adder_out1);

/*To add the immediate to the current PC*/
adder adder_dut2 (Immmediate,pc_output,Adder_out2);


ALU alu_dut (opcode,Read_data1,ALU_input,ALU_output,Equal,NEqual,Less_Than,Greater_Equal);

/*To choose the input ot the PC */
MUX_3x1 mux_3x1_dut1 (Adder_out1,Adder_out2,ALU_output,PCSrc,pc_input);

/*The given address to the the Data Memory*/
assign address=ALU_output;
/*The data to be written to the Memory*/
assign Written_DMem=Read_data2;

/*To choose whice will be the input to the destination register*/
MUX_3x1 mux_3x1_dut2 (ALU_output,Read_DMem,Adder_out1,MemtoReg,Reg_data);

endmodule //data_Path