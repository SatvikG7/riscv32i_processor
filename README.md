# RV32I RISC-V Processor (SystemVerilog Implementation)

A 32-bit RISC-V Processor designed using SystemVerilog based on the **RV32I Instruction Set Architecture**, implemented and tested on Intel Quartus. This project follows the architectural principles from *Digital Design and Computer Architecture - RISC-V Edition* by Sarah Harris and David Harris.

---

## 📦 Project Structure
```
riscv32i_processor/
├── src/ # RTL Design Sources
│ ├── top/ # Top-level integration module
│ ├── fetch/ # Instruction Fetch stage
│ ├── decode/ # Instruction Decode and Control Unit
│ ├── execute/ # ALU and Immediate Generator
│ ├── mem/ # Data Memory
│ └── wb/ # Write-Back Logic
│
├── tb/ # Testbenches
```
---

## 🚀 Features

✅ Implements **RV32I Base Integer Instruction Set**  
✅ Modular, pipelined architecture with clear stage separation  
✅ Fully synthesizable for FPGA platforms (Intel Quartus)  
✅ Includes instruction fetch, decode, ALU execution, memory, and write-back stages  
✅ Register file with 32 general-purpose registers (`x0` hardwired to 0)  
✅ Supports arithmetic, logical, load/store, and control-flow instructions  
✅ Comprehensive testbenches for individual modules and top-level processor  

---

## 🛠️ Development Environment

- **Language:** SystemVerilog (IEEE 1800)
- **Toolchain:** Intel Quartus Prime
- **Target ISA:** RV32I (32-bit Integer Instructions)
- **Simulation:** Quartus Native Simulator
- **Reference Book:**  
  *Digital Design and Computer Architecture: RISC-V Edition*  
  Sarah Harris & David Money Harris

---

## 🧩 Major Modules

| Module          | Description                                  |
|-----------------|----------------------------------------------|
| `fetch.sv`      | Program Counter and Instruction Fetch logic  |
| `decode.sv`     | Instruction decoding and field extraction    |
| `main_decoder_cu.sv` | Generates control signals based on opcode  |
| `alu_decoder_cu.sv` | Generates control signals based on opcode  |
| `imm_gen.sv`    | Immediate value generator for all types      |
| `reg_file.sv`   | 32x32-bit general-purpose register file      |
| `alu.sv`        | Arithmetic Logic Unit (ADD, SUB, AND, OR, etc.) |
| `data_mem.sv`   | Data Memory (RAM interface)                  |
| `wb.sv`         | Write-back stage for result storage          |
| `riscv_top.sv`  | Top-level module integrating all components  |

---

## 🧪 Testing Strategy

- **Unit Testbenches** for each core module (ALU, Decode, etc.)
- **Top-Level Simulation** with `.hex` instruction memory initialization
- Instruction test programs verifying:
  - ALU operations (`add`, `sub`, `and`, `or`, `xor`, `sll`, `srl`, `sra`)
  - Immediate instructions (`addi`, `andi`, etc.)
  - Load/Store operations (`lw`, `sw`)
  - Branch and Jump instructions (`beq`, `bne`, `jal`)

---

## ⚙️ How to Run (Simulation)

1. Open the Quartus project from `quartus_project/`
2. Compile the design hierarchy
3. Run simulations:
   - Individual module tests under `tb/`
   - Full processor test with `tb_riscv_top.sv`
4. Load `.hex` files for instruction/data memory during simulation
5. Observe signal behavior using Quartus Waveform Viewer

---

## 🎯 Future Improvements (Optional)

- Pipeline enhancements (multi-cycle or pipelined version)  
- Support for additional RISC-V extensions (e.g., `RV32M` for multiplication)  
- Integration with UART for I/O  
- Hardware deployment on Intel FPGA board with interactive output  

---

## 📝 Author

- **[Satvik Gaikwad]**  
- Student, Electronics & Telecommunication  
- Project completed as part of academic coursework  

---


