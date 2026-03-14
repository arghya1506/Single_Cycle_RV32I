module ALU_Unit(A,B,ALU_Control,R,Z,N,C,V,L,LU);
input wire [31:0]A,B;
input wire [2:0]ALU_Control;
output wire Z,N,C,V,L,LU;
output wire [31:0]R;
wire [31:0]Or,And,SLT,SLTU,SRL,SRA,w1,sum;
wire cout;
assign Or=A|B;
assign And=A&B;
assign L=sum[31]^V;
assign LU=~cout;
assign SLT={{31{1'b0}},sum[31]^V};
assign SLTU={{31{1'b0}},~cout};
assign SRL=A>>B[4:0];
assign SRA=$signed(A) >>> B[4:0];
assign w1=(ALU_Control[0]==0)? B:~B;
assign {cout,sum}=A+w1+ALU_Control[0];
assign R=(ALU_Control==3'b000)||(ALU_Control==3'b001)? sum:
         (ALU_Control==3'b010)? And: 
         (ALU_Control==3'b011)? Or:
         (ALU_Control==3'b101)? SLT:
         (ALU_Control==3'b100)? SLTU:
         (ALU_Control==3'b110)? SRL:SRA;
        
assign Z=&(~R);
assign N=R[31];
assign C=(~(ALU_Control[1]))&cout;
assign V=~(ALU_Control[0]^A[31]^B[31])&(A[31]^sum[31])&(~(ALU_Control[1]));
endmodule
