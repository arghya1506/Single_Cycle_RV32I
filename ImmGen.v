module ImmGen(
    input  wire [31:0] instr,
    input  wire [1:0]  ImmSrc,
    output wire [31:0] ImmExt
);
wire [31:0] imm_I;
wire [31:0] imm_S;
wire [31:0] imm_B;
wire [31:0] imm_J;
// I-type immediate
assign imm_I = {{20{instr[31]}}, instr[31:20]};
// S-type immediate
assign imm_S = {{20{instr[31]}}, instr[31:25], instr[11:7]};
// B-type immediate
assign imm_B = {{19{instr[31]}},
                instr[31],
                instr[7],
                instr[30:25],
                instr[11:8],
                1'b0};
// J-type immediate
assign imm_J = {{11{instr[31]}},
                instr[31],
                instr[19:12],
                instr[20],
                instr[30:21],
                1'b0};
// Select immediate based on control signal
assign ImmExt = (ImmSrc == 2'b00) ? imm_I :
                (ImmSrc == 2'b01) ? imm_S :
                (ImmSrc == 2'b10) ? imm_B :
                                   imm_J;

endmodule