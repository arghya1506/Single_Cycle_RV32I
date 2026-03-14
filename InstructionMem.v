module InstructionMem(A,RD);
input wire [31:0]A;
output wire[31:0]RD;
reg [31:0]mem [1023:0];
assign RD=mem[A[11:2]];
initial 
begin
mem[0] = 32'h01400093; // addi x1,x0,20
mem[1] = 32'h00500113; // addi x2,x0,5
mem[2] = 32'h000082E7; // jalr x5,0(x1)
mem[3] = 32'h06F00193; // skipped
mem[5] = 32'h0DE00213; // addi x4,x0,222
end
endmodule