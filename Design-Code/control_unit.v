module control_unit (
    
    input [6:0]  opcode,
    input        Equal,
    input        NEqual,
    input        Less_Than,
    input        Greater_Equal,
    output reg   AluSrc,
    output reg   [1:0] MemtoReg,
    output reg   RegWrite,
    output reg   MemRead,
    output reg   MemWrite,
    output reg [1:0] PCSrc,
    output reg   [2:0] ImmSel,
    output reg   [2:0] AluOp
);

always @(*) begin
    case (opcode)
      7'b0110011:begin //R-Format
           AluSrc  =0    ;
           MemtoReg=2'h0 ;
           RegWrite=1    ;
           MemRead =0    ;
           MemWrite=0    ;
           PCSrc   =2'h0 ;
           ImmSel  =3'h5 ;
           AluOp   =3'h5 ;
      end 	
      7'b0000011:begin //ld-Format
           AluSrc  =1    ;
           MemtoReg=2'h1 ;
           RegWrite=1    ;
           MemRead =1    ;
           MemWrite=0    ;
           PCSrc   =2'h0 ;
           ImmSel  =3'h0 ;
           AluOp   =3'h0 ;  
      end
      7'b0010011:begin //I-Format
           AluSrc  =1    ;
           MemtoReg=2'h0 ;
           RegWrite=1    ;
           MemRead =0    ;
           MemWrite=0    ;
           PCSrc   =2'h0 ;
           ImmSel  =3'h0 ;
           AluOp   =3'h0 ;            
      end 
      7'b1100111:begin //jalr-Format
           AluSrc  =1    ;
           MemtoReg=2'h2 ;
           RegWrite=1    ;
           MemRead =0    ;
           MemWrite=0    ;
           PCSrc   =2'h2 ;
           ImmSel  =3'h0 ;
           AluOp   =3'h0 ;             
      end
      7'b0100011:begin //S-Format
           AluSrc  =1    ;
           MemtoReg=2'h1 ;//doesn't affect.
           RegWrite=0    ;
           MemRead =0    ;
           MemWrite=1    ;
           PCSrc   =2'h0 ;
           ImmSel  =3'h1 ;
           AluOp   =3'h1 ;     
      end 
      7'b1100011:begin //SB-Format
           AluSrc  =0    ;
           MemtoReg=2'h0 ;//doesn't affect.
           RegWrite=0    ;
           MemRead =0    ;
           MemWrite=0    ;
           if (Equal==1 || NEqual==1 || Greater_Equal==1 || Less_Than==1) begin
           PCSrc=1;
           end
           else
           PCSrc=0;

           ImmSel  =3'h2 ;
           AluOp   =3'h2 ;   
      end 
      7'b0110111:begin //U-Format
           AluSrc  =1    ;
           MemtoReg=2'h0 ;
           RegWrite=1    ;
           MemRead =0    ;
           MemWrite=0    ;
           PCSrc   =2'h0 ;
           ImmSel  =3'h4 ;
           AluOp   =3'h4 ;  
      end
      7'b1101111:begin //UJ-Format***
           AluSrc  =0    ;
           MemtoReg=2'h2 ;
           RegWrite=1    ;//to write pc+4 in the destination.
           MemRead =0    ;
           MemWrite=0    ;
           PCSrc   =2'h1 ;
           ImmSel  =3'h3 ;
           AluOp   =3'h3 ;  
      end      
    endcase
end

endmodule //control_unit