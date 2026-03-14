module PC(clk,reset_n,pc_next,pc_out);
input wire clk,reset_n;
input wire [31:0]pc_next;
output reg [31:0]pc_out;
always@(posedge clk or negedge reset_n)
begin
if(!reset_n)
pc_out<=32'b0;
else
pc_out<=pc_next;
end
endmodule