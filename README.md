RISC-V Single Cycle Processor (RV32I)
A 32-bit single-cycle RISC-V processor implemented in Verilog, supporting a subset of the RV32I instruction set architecture.
The processor is designed, simulated, and verified using Verilog testbenches and GTKWave.
This project demonstrates the full datapath and control implementation of a basic RISC-V CPU including:
Arithmetic and logic instructions
Immediate instructions
Load and store instructions
Branch instructions
Jump instructions (jal, jalr)

Features
Implemented instructions include:
R-Type Instructions:
add
sub
and
or
slt
sltu
srl
sra

I-Type Instructions:
addi
andi
ori
slti
sltiu
srli
srai

Memory Instructions:
lw
sw

Branch Instructions:
beq
bne
blt
bge

Jump Instructions:
jal
jalr

Processor Architecture
The processor consists of the following modules:
Instruction Memory
Program Counter
Register File
Immediate Generator
ALU
Data Memory
Control Unit
ALU Control
Branch Logic
PC Control Logic
Datapath Overview

PC → Instruction Memory → Decoder
     ↓
Register File → ALU → Data Memory
     ↓
Writeback → Register File
Project Structure
Example project organization:

riscv-single-cycle/
│
├── src/
│   ├── ALU.v
│   ├── ControlUnit.v
│   ├── ALUControl.v
│   ├── ImmediateGenerator.v
│   ├── RegisterFile.v
│   ├── DataMemory.v
│   ├── InstructionMemory.v
│   ├── PC.v
│   └── CpuTop.v
│
├── testbench/
│   └── CpuTopTb.v
│
├── waveforms/
│   └── simulation.vcd
│
└── README.md
Simulation
The processor was tested using:

Icarus Verilog
GTKWave
Compile
Copy code

iverilog -o cpu CpuTop.v CpuTopTb.v
Run Simulation

View Waveforms
gtkwave simulation.vcd

Example Program
Example instructions loaded into instruction memory:
addi x1, x0, 10
addi x2, x0, 3
add  x3, x1, x2
sub  x4, x1, x2
sw   x1, 0(x10)
lw   x5, 0(x10)
beq  x1, x2, label
jal  x1, target
jalr x2, 0(x3)

Verification
The processor functionality was verified through:
Register writeback verification
ALU operation validation
Memory read/write correctness
Branch control logic
Jump instruction handling

Signals monitored in GTKWave:
pc_out
instruction
rs1
rs2
rd
ImmExt
ALU_result
MemWrite
MemRead
ResultSrc
RegWrite

Future Improvements
Possible extensions:
5-stage pipelined processor
Cache memory controller
Hazard detection
Forwarding unit
Branch prediction
Author
Arghya Pratim Biswas
Project developed as part of learning computer architecture and processor design.
