`include "PC.v"
`include "InstructionMem.v"
`include "RegFile32.v"
`include "Control_Unit.v"
`include "ImmGen.v"
`include "ALU_Unit.v"
`include "DataMem.v"
module CpuTop(
    input clk,
    input reset
);
//=======================
// PC WIRES
//=======================
wire [31:0] pc_next;
wire [31:0] pc_out;
//=======================
// OTHER WIRES
//=======================
wire [31:0] Instr;
wire [31:0] RD1, RD2;
wire [31:0] WD3;
wire [31:0] ImmExt;
wire [31:0] SrcB;
wire [31:0] ALUResult;
wire [31:0] ReadData;
wire [31:0] Result;
wire [31:0] PC_Plus4;
wire [31:0] PC_Target;


//=======================
// CONTROL SIGNALS
//=======================

wire RegWrite;
wire MemWrite;
wire Z,L,LU,N,C,V;

wire [1:0] ResultSrc;
wire [1:0] PCSrc;
wire [1:0] ImmSrc;
wire [1:0]ALUSrc;

wire [2:0] ALUControl;


//=======================
// PC MODULE
//=======================

PC PC_REG(
    .clk(clk),
    .reset_n(reset),
    .pc_next(pc_next),
    .pc_out(pc_out)
);


//=======================
// INSTRUCTION MEMORY
//=======================

InstructionMem IM(
    .A(pc_out),
    .RD(Instr)
);


//=======================
// REGISTER FILE
//=======================

RegFile32 RF(
    .clk(clk),
    .A1(Instr[19:15]),
    .A2(Instr[24:20]),
    .A3(Instr[11:7]),
    .WD3(WD3),
    .WE3(RegWrite),
    .RD1(RD1),
    .RD2(RD2)
);


//=======================
// IMMEDIATE GENERATOR
//=======================

ImmGen IG(
    .instr(Instr),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt)
);


//=======================
// ALU SOURCE MUX
//=======================

assign SrcB = (ALUSrc[0]) ? ImmExt : RD2;


//=======================
// ALU
//=======================

ALU_Unit alu(
    .A(RD1),
    .B(SrcB),
    .ALU_Control(ALUControl),
    .R(ALUResult),
    .Z(Z),
    .N(N),
    .C(C),
    .V(V),
    .L(L),
    .LU(LU)
);


//=======================
// DATA MEMORY
//=======================

DataMem DM(
    .clk(clk),
    .A(ALUResult),
    .WD(RD2),
    .WE(MemWrite),
    .RD(ReadData)
);


//=======================
// WRITEBACK MUX
//=======================

assign Result =
        (ResultSrc == 2'b01) ? ALUResult :
        (ResultSrc == 2'b00) ? ReadData  :
                               PC_Plus4;

assign WD3 = Result;


//=======================
// PC ADDERS
//=======================

assign PC_Plus4 = pc_out + 32'd4;

assign PC_Target = (PCSrc == 2'b11) ? (RD1 + ImmExt) : (pc_out + ImmExt);


//=======================
// PC MUX
//=======================
assign pc_next =
        (PCSrc == 2'b00) ? PC_Plus4 :
        (PCSrc == 2'b01) ? PC_Target :
                           PC_Target;


//=======================
// CONTROL UNIT
//=======================

Control_Unit CU(
    .Op(Instr[6:0]),
    .funct3(Instr[14:12]),
    .funct7(Instr[31:25]),
    .Z(Z),
    .L(L),
    .LU(LU),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .ResultSrc(ResultSrc),
    .PCSrc(PCSrc),
    .ImmSrc(ImmSrc),
    .ALU_Control(ALUControl)
);

endmodule