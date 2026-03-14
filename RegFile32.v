module RegFile32(clk,A1,A2,A3,WE3,WD3,RD1,RD2);
input wire clk,WE3;
input wire [4:0]A1,A2,A3;
input wire [31:0]WD3;
output wire [31:0]RD1,RD2;
reg [31:0]file [31:0];
integer i;
initial 
begin 
    for(i=0;i<32;i=i+1)
          file[i]=32'b0;
end
assign RD1 = (A1==0)?0:file[A1];
assign RD2 = (A2==0)?0:file[A2];
always @(posedge clk)
begin
if (WE3 && A3 != 5'b00000)
file[A3] <= WD3;
end
endmodule