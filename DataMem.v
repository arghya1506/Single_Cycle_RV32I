module DataMem(clk,WE,A,WD,RD);
input wire clk;
input wire WE;              
input wire [31:0] A;        
input wire [31:0] WD;       
output wire [31:0] RD;      
reg [31:0] mem [1023:0];
initial
begin
    mem[1023]=32'hFFC4A303;
end
assign RD = mem[A[11:2]];
always @(posedge clk)
begin
if (WE)
mem[A[11:2]] <= WD;
end
endmodule