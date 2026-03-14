module Control_Unit(Z,L,LU,Op,funct3,funct7,PCSrc,ResultSrc,ALUSrc,ImmSrc,MemWrite,RegWrite,ALU_Control);
input wire Z,L,LU;
input wire [6:0]funct7;
input wire [6:0]Op;
input wire [2:0]funct3;
output wire [1:0]PCSrc,ResultSrc,ALUSrc;
output wire MemWrite,RegWrite;
output wire [1:0]ImmSrc;
output wire [2:0]ALU_Control;
wire branch,jal,jalr;
wire BEQ_instr, BNE_instr, BLT_instr, BGE_instr, BLTU_instr, BGEU_instr;
wire take_branch;
wire [1:0]ALUOp;
assign BEQ_instr  = branch & (funct3 == 3'b000);
assign BNE_instr  = branch & (funct3 == 3'b001);
assign BLT_instr  = branch & (funct3 == 3'b100);
assign BGE_instr  = branch & (funct3 == 3'b101);
assign BLTU_instr = branch & (funct3 == 3'b110);
assign BGEU_instr = branch & (funct3 == 3'b111);
assign take_branch =
       (BEQ_instr  &  Z ) |
       (BNE_instr  & ~Z ) |
       (BLT_instr  &  L ) |
       (BGE_instr  & ~L ) |
       (BLTU_instr &  LU) |
       (BGEU_instr & ~LU);
assign PCSrc[0] = take_branch | jalr;
assign PCSrc[1]=jal;
assign RegWrite=(Op==7'b0000011||Op==7'b0110011||Op==7'b1101111||Op==7'b1100111||Op==7'b0010011)?1'b1:1'b0;
assign ImmSrc=(Op==7'b0000011||Op==7'b0110011||Op==7'b1100111||Op==7'b0010011)?2'b00:
              (Op==7'b0100011)?2'b01:
              (Op==7'b1100011)?2'b10:2'b11;
assign ALUSrc=(Op==7'b0000011||Op==7'b0100011||Op==7'b1100111)?2'b01:
              (Op==7'b0110011)?2'b00:
              (Op==7'b1100011)?2'b10:2'b11;
assign MemWrite=(Op==7'b0100011)?1'b1:1'b0;
assign ResultSrc=(Op==7'b0000011||Op==7'b0100011||Op==7'b1100011)?2'b00:
                 (Op==7'b0110011||Op==7'b0010011)?2'b01:2'b10;
assign branch=(Op==7'b1100011)?1'b1:1'b0;
assign jal=(Op==7'b1101111||Op==7'b1100111)?1'b1:1'b0;
assign jalr=(Op==7'b1100111)?1'b1:1'b0;
assign ALUOp=(Op==7'b0000011||Op==7'b0100011||Op==7'b1101111||Op==7'b1100111)?2'b00:
             (Op==7'b1100011)?2'b01:2'b10;
assign ALU_Control=(ALUOp==2'b00)||((ALUOp==2'b10)&&(funct3==3'b000)&&({Op[5],funct7[5]}!=2'b11))?3'b000:
                   (ALUOp==2'b01) ? 3'b001 : 
                   ((ALUOp==2'b10)&&(funct3==3'b000)&&({Op[5],funct7[5]}==2'b11))?3'b001:
                   ((ALUOp==2'b10)&&(funct3==3'b010))?3'b101:
                   ((ALUOp==2'b10)&&(funct3==3'b110))?3'b011:
                   ((ALUOp==2'b10)&&(funct3==3'b111))?3'b010:
                   ((ALUOp==2'b10)&&(funct3==3'b011))?3'b100:
                   ((ALUOp==2'b10)&&(funct3==3'b101)&&({funct7[5]}==1'b0))?3'b110:3'b111;

endmodule