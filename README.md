# 16-bit CPU Design

![GitHub](https://img.shields.io/github/license/saeedvft/16bit-CPU?style=flat-square)
![GitHub last commit](https://img.shields.io/github/last-commit/saeedvft/16bit-CPU?style=flat-square)

This repository contains the design and implementation of a 16-bit CPU. The project is intended for educational purposes and demonstrates the fundamental concepts of computer architecture, including instruction set design, datapath, control unit, and memory management.

---

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Instruction Set Architecture (ISA)](#instruction-set-architecture-isa)
4. [Hardware Design](#hardware-design)
   - [Datapath](#datapath)
   - [Control Unit](#control-unit)
   - [Memory Unit](#memory-unit)
5. [Contributing](#contributing)

---

## Overview
The 16-bit CPU is a simple yet functional processor designed to execute a custom instruction set. It is implemented using hardware description languages (HDLs) such as Verilog or VHDL. The project is suitable for students, hobbyists, and anyone interested in learning about CPU design and digital logic.

---

## Features
- **16-bit Architecture**: Supports 16-bit data and address buses.
- **Custom Instruction Set**: Designed with a minimal and efficient instruction set.
- **Modular Design**: Components like ALU, registers, and control units are modular and reusable.
- **Simulation Support**: Testbenches are provided to simulate and verify the design.
- **Educational Focus**: Clear documentation and comments to aid understanding.

---

## Instruction Set Architecture (ISA)
The CPU supports a custom ISA, including instructions for arithmetic operations, data movement, control flow, and memory access. Below is a summary of the instruction set:

| Instruction | Opcode | Description |
|-------------|--------|-------------|
| ADD         | 0000   | Add two registers |
| SUB         | 0001   | Subtract two registers |
| NOT         | 0010   | Bitwise NOT operation |
| AND         | 0011   | Bitwise AND operation |
| OR          | 0100   | Bitwise OR operation |
| XOR         | 0101   | Bitwise XOR operation |
| LSL         | 0110   | Logical Shift Left |
| LSR         | 0111   | Logical Shift Right |
| CMP         | 1000   | Compare two registers |
| BEQ         | 1010   | Branch if equal |
| IMM         | 1011   | Load immediate value |
| LD          | 1100   | Load from memory |
| ST          | 1101   | Store to memory |

For a detailed description of the ISA, refer to the [ISA Documentation](https://github.com/saeedvft/16bit-CPU/blob/main/ISA.md).

---

## Hardware Design
The CPU is composed of the following key components:

### Datapath
The datapath includes the Arithmetic Logic Unit (ALU), register file, and program counter (PC). It handles data processing and instruction execution.

### Control Unit
The control unit decodes instructions and generates control signals to manage the datapath and memory operations.

### Memory Unit
The memory unit consists of a 512-byte RAM module implemented as a 256x16 array. It supports read and write operations and is initialized with a predefined set of instructions and data for testing purposes.

#### RAM Module
The RAM module is synchronized with the clock and supports address-based read/write operations. Below is a snippet of the RAM initialization:

```vhdl
type ram_array is array (0 to 255) of STD_LOGIC_VECTOR (15 downto 0);
signal ram: ram_array := (
    '0' & "1011" & "000" & x"0A", -- imm r0 = 0x000A (580A)
    '0' & "1011" & "001" & x"AA", -- imm r1 = 0x00AA (59AA)
    '0' & "0010" & "000" & "000" & "00000", -- not r0 (1000)
    others => x"0000"
);
```
Waveforms:
![image](https://github.com/user-attachments/assets/f0f240cb-3fd7-427f-b978-610f7e1d117d)


Contributing
------------

Contributions are welcome! If you'd like to contribute, please follow these steps:

1.  Fork the repository.

2.  Create a new branch for your feature or bugfix.

3.  Submit a pull request with a detailed description of your changes.
