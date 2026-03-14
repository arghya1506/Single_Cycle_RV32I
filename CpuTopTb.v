`include "CpuTop.v"
module CpuTopTb();
reg clk,rst;
CpuTop Risc_5(.clk(clk),.reset(rst));
initial 
begin
    $dumpfile("SingleCycle.vcd");
    $dumpvars(0);
end
initial 
begin
    clk=0;


    rst=1'b0;
    #20;
    rst=1'b1;
    #1500;
    $finish;
end
always
begin
    #20 clk=~clk;
    
end

endmodule


