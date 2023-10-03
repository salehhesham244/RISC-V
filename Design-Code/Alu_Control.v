module Alu_Control #(
    parameter WIDTH=32
) (  
input [2:0] AluOp,
input [WIDTH-1:0] inst,
output reg [3:0] Alu_Control_Lines 
);

reg [9:0] Field;


/*ALU-Control*/
always @(*) begin
case (AluOp)
    3'b000:begin//I-Format
        if (inst[14:12]==3'b010) begin
            Alu_Control_Lines=4'b0010;//Addition for lw.
        end
        else if (inst[14:12]==3'b000) begin
            Alu_Control_Lines=4'b0010;//Addition for Addi / jalr.
        end
        if (inst[14:12]==3'b001) begin
            Alu_Control_Lines=4'b0011;// SLLI.
        end
        else if (inst[14:12]==3'b100) begin
            Alu_Control_Lines=4'b1000;// XORI.
        end       
        if (inst[14:12]==3'b101) begin
            Alu_Control_Lines=4'b0111;// SRLI / SRAI.            
        end
        else if (inst[14:12]==3'b110) begin
            Alu_Control_Lines=4'b0001;// ORI.
        end      
        if (inst[14:12]==3'b111) begin
            Alu_Control_Lines=4'b0000;// ANDI
        end  
    end
    3'b001:begin //S-Format.
            Alu_Control_Lines=4'b0010;//Addition for SW.
    end
    3'b010:begin //SB-Format.
        if (inst[14:12]==3'b001) begin
            Alu_Control_Lines=4'b1001;//Subtraction For bne. 
        end
        else if (inst[14:12]==3'b000) begin
            Alu_Control_Lines=4'b1010;//sub For beq.
        end
        if (inst[14:12]==3'b100) begin
            Alu_Control_Lines=4'b1011;//Subtraction For blt.
        end
        else if (inst[14:12]==3'b101) begin
            Alu_Control_Lines=4'b1100;//Subtraction For bge.
        end
    end
    3'b101:begin //R-Format.
        Field={inst[31:25],inst[14:12]};
        if (Field==10'h000) begin
            Alu_Control_Lines=4'b0010;//For Addition.    
        end
        else if (Field==10'h100) begin
            Alu_Control_Lines=4'b0110;//For Subtruction.
        end
        else if (Field==10'h007) begin
            Alu_Control_Lines=4'b0000;//For And.
        end
        else if (Field==10'h006) begin
            Alu_Control_Lines=4'b0001;//For OR.
        end
        else if (Field==10'h001) begin
            Alu_Control_Lines=4'b0011;//For Shift-Left-Logic.          
        end
        else if (Field==10'h002) begin
            Alu_Control_Lines=4'b1000;//For Set-Less-Than.            
        end
        else if (Field==10'h005) begin
            Alu_Control_Lines=4'b0101;//For Shift-Right-Logic.            
        end 
        else if (Field==10'h105) begin
            Alu_Control_Lines=4'b0111;//For Shift-Right-Arithmatic.            
        end
        else if (Field==10'h004) begin
            Alu_Control_Lines=4'b1000;//For XOR.            
        end
    end
    3'b100:begin //U-Format
        Alu_Control_Lines=4'b1101;
    end
    // 3'b011:begin //UJ-Format
    //     Alu_Control_Lines=4'b;
    // end
endcase
end

endmodule //TOP