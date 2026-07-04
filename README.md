🚀 Single-Cycle RV32I RISC-V Processor


📖 Introduction
This project presents the RTL design and verification of a 32-bit Single-Cycle RISC-V processor implementing the RV32I Base Integer Instruction Set Architecture (ISA) in Verilog HDL. The processor executes each instruction in a single clock cycle, making it simple to understand and an excellent starting point for learning processor design.
The design follows a Harvard Architecture, using separate instruction and data memories, and consists of modular RTL blocks such as the Program Counter, Control Unit, Register File, Immediate Generator, ALU, Data Memory, and Write-Back Multiplexer. The processor has been functionally verified through simulation using Icarus Verilog and GTKWave.


✨ Features
✅ Complete RV32I Base Integer ISA
✅ 32-bit datapath
✅ Modular RTL design
✅ Harvard Architecture
✅ Byte-addressable data memory
✅ Word-aligned instruction memory
✅ Immediate generation for all instruction formats
✅ Branch and jump support
✅ Fully synthesizable Verilog HDL
✅ Functionally verified using simulation


🏛️ Processor Architecture
The processor is composed of the following functional blocks:
📍 Program Counter (PC)
📖 Instruction Memory
🎮 Main Control Unit
📚 Register File
🔢 Immediate Generator
➕ ALU & ALU Control
💾 Data Memory
🔀 Write-Back Multiplexer
🌿 Branch & Jump Logic
These modules work together to fetch, decode, execute, access memory, and write back the result of every instruction within a single clock cycle.


📋 Supported RV32I Instructions
R-Type
ADD
SUB
AND
OR
XOR
SLL
SRL
SRA
SLT
SLTU
I-Type
ADDI
ANDI
ORI
XORI
SLLI
SRLI
SRAI
SLTI
SLTIU
LW
JALR
S-Type
SW
B-Type
BEQ
BNE
BLT
BGE
BLTU
BGEU
U-Type
LUI
AUIPC
J-Type
JAL


⚙️ Instruction Execution
Every instruction passes through the following stages within one clock cycle:
Fetch instruction from Instruction Memory.
Decode the instruction and generate control signals.
Read operands from the Register File.
Generate the required immediate value.
Perform the ALU operation.
Access Data Memory (for load/store instructions).
Write the result back to the destination register.
Update the Program Counter for the next instruction.


🛠️ Development Tools
Verilog HDL
Icarus Verilog
GTKWave
Vivado


📸 Verification
The processor has been verified using custom Verilog testbenches covering:
Arithmetic operations
Logical operations
Shift operations
Load and Store instructions
Branch instructions
Jump instructions
Register write-back
Program Counter updates
Waveforms generated using GTKWave confirmed the correct execution of all supported instructions.


🚀 Future Work
Five-stage pipelined processor
Hazard Detection Unit
Forwarding Unit
Cache Controller
UART Interface
FPGA implementation
AXI bus interface