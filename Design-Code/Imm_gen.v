module Imm_gen #(
    parameter WIDTH=32
) (  
    input [2:0] ImmSel,
    input [WIDTH-1:0] inst,
    output reg [WIDTH-1:0] out_imm 
);

    reg [19:0] Field;


    /*ALU-Control*/
    always @(*) begin
        case (ImmSel)
            3'b000:begin//I-Format
            Field=inst[31:20];
            out_imm={{20{Field[11]}},Field[11:0]};
            end
            3'b001:begin //S-Format.
            Field={inst[31:25],inst[11:7]};
            out_imm={{20{Field[11]}},Field[11:0]};
            end
            3'b010:begin //SB-Format.
            Field={inst[31],inst[7],inst[30:25],inst[11:8],1'b0};
            out_imm={{19{Field[12]}},Field[12:0]};
            end
            3'b100:begin //U-Format
            Field=inst[31:12];
            out_imm=Field;
            end
            3'b011:begin //UJ-Format
            Field={inst[19:12],inst[20],inst[30:25],inst[24:21],1'b0};
            out_imm={{12{Field[19]}},Field};
            end
        endcase
    end
endmodule