module ALU #(
      
    parameter         WIDTH           =32,
    parameter 		    Add	           = 4'b0010, // A + B
    parameter 		    Sub	           = 4'b0110, // A - B
    parameter 		    OR	           = 4'b0001, // A | B
    parameter 		    AND             = 4'b0000, // A & B 
    parameter         XOR             = 4'b1000, // A ^ B
    parameter         SLT             = 4'b0100, // A < B
    parameter         SLL             = 4'b0011, // A << B
    parameter         SRL             = 4'b0101, // A >> B
    parameter         SRA             = 4'b0111, // A >> B
    parameter         bne             = 4'b1001,
    parameter         beq             = 4'b1010,
    parameter         blt             = 4'b1011,
    parameter         bge             = 4'b1100,
    parameter         LUI             = 4'b1101 
  ) 
  ( 
    input  [3:0] Opcode,	// The opcode
    input  signed [WIDTH-1:0] A,	// Input data A in 2's complement
    input  signed [WIDTH-1:0] B,	// Input data B in 2's complement
    output signed [WIDTH-1:0] C, // ALU output in 2's complement
    output wire      Equal,
    output wire      NEqual,
    output wire      Less_Than,
    output wire      Greater_Equal
	);

   reg  signed [WIDTH-1:0] 	    Alu_out; // ALU output in 2's complement


   // Do the operation
   always @(*) begin
      case (Opcode)
      	Add:            Alu_out = A + B;
      	Sub:            Alu_out = A - B;
      	OR :            Alu_out = A | B;
      	AND:            Alu_out = A & B;
         XOR:            Alu_out = A ^ B;
         SLT:            Alu_out =(A < B)?1'b1:1'b0;
         SLL:            Alu_out =A <<  B[4:0];
         SRL:            Alu_out =A >> B[4:0];
         SRA:            Alu_out =A >>>  B[4:0]; 
         bne:            Alu_out =A - B;
         beq:            Alu_out =A - B;
         blt:            Alu_out =A - B;
         bge:            Alu_out =A - B;
         LUI:            Alu_out ={B,12'h000};
      endcase
   end 

// Register output C
assign C=Alu_out;
//The Flag of Branch Operations. 
assign Equal         =(Opcode==beq && Alu_out==0)? 1'b1 : 1'b0 ;
assign NEqual        =(Opcode==bne && Alu_out!=0)? 1'b1 : 1'b0 ;
assign Less_Than     =(Opcode==blt && Alu_out<0 )? 1'b1 : 1'b0 ;
assign Greater_Equal =(Opcode==bge && (Alu_out>0 || Alu_out==0) )? 1'b1 : 1'b0 ;
endmodule
