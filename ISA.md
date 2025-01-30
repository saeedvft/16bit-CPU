# Instruction Set Architecture (ISA)

This document describes the Instruction Set Architecture (ISA) for the 16-bit CPU. The ISA includes instructions for arithmetic operations, data movement, control flow, and memory access. Each instruction is 16 bits wide and follows a specific format.

---

## Instruction Format
The general format for instructions is as follows:

- **Opcode (4 bits)**: Specifies the operation to be performed.
- **Operands (12 bits)**: Specifies the registers, immediate values, or memory addresses used in the operation.

The exact layout of the operands depends on the instruction type.

---

## Instruction Set Summary

| Instruction | Opcode | Description | Operand Format |
|-------------|--------|-------------|----------------|
| ADD         | 0000   | Add two registers | `Rd, Rs1, Rs2` |
| SUB         | 0001   | Subtract two registers | `Rd, Rs1, Rs2` |
| NOT         | 0010   | Bitwise NOT operation | `Rd, Rs` |
| AND         | 0011   | Bitwise AND operation | `Rd, Rs1, Rs2` |
| OR          | 0100   | Bitwise OR operation | `Rd, Rs1, Rs2` |
| XOR         | 0101   | Bitwise XOR operation | `Rd, Rs1, Rs2` |
| LSL         | 0110   | Logical Shift Left | `Rd, Rs, Shamt` |
| LSR         | 0111   | Logical Shift Right | `Rd, Rs, Shamt` |
| CMP         | 1000   | Compare two registers | `Rd, Rs1, Rs2` |
| BEQ         | 1010   | Branch if equal | `Rs1, Rs2, Offset` |
| IMM         | 1011   | Load immediate value | `Rd, Imm` |
| LD          | 1100   | Load from memory | `Rd, Rs` |
| ST          | 1101   | Store to memory | `Rs, Rd` |

---

## Detailed Instruction Descriptions

### 1. ADD (Addition)
- **Opcode**: `0000`
- **Format**: `ADD Rd, Rs1, Rs2`
- **Description**: Adds the values in registers `Rs1` and `Rs2` and stores the result in `Rd`.
- **Example**: `ADD R2, R1, R0` (R2 = R1 + R0)

### 2. SUB (Subtraction)
- **Opcode**: `0001`
- **Format**: `SUB Rd, Rs1, Rs2`
- **Description**: Subtracts the value in `Rs2` from `Rs1` and stores the result in `Rd`.
- **Example**: `SUB R3, R2, R1` (R3 = R2 - R1)

### 3. NOT (Bitwise NOT)
- **Opcode**: `0010`
- **Format**: `NOT Rd, Rs`
- **Description**: Performs a bitwise NOT operation on the value in `Rs` and stores the result in `Rd`.
- **Example**: `NOT R1, R0` (R1 = ~R0)

### 4. AND (Bitwise AND)
- **Opcode**: `0011`
- **Format**: `AND Rd, Rs1, Rs2`
- **Description**: Performs a bitwise AND operation on the values in `Rs1` and `Rs2` and stores the result in `Rd`.
- **Example**: `AND R2, R1, R0` (R2 = R1 & R0)

### 5. OR (Bitwise OR)
- **Opcode**: `0100`
- **Format**: `OR Rd, Rs1, Rs2`
- **Description**: Performs a bitwise OR operation on the values in `Rs1` and `Rs2` and stores the result in `Rd`.
- **Example**: `OR R3, R2, R1` (R3 = R2 | R1)

### 6. XOR (Bitwise XOR)
- **Opcode**: `0101`
- **Format**: `XOR Rd, Rs1, Rs2`
- **Description**: Performs a bitwise XOR operation on the values in `Rs1` and `Rs2` and stores the result in `Rd`.
- **Example**: `XOR R4, R3, R2` (R4 = R3 ^ R2)

### 7. LSL (Logical Shift Left)
- **Opcode**: `0110`
- **Format**: `LSL Rd, Rs, Shamt`
- **Description**: Logically shifts the value in `Rs` left by `Shamt` bits and stores the result in `Rd`.
- **Example**: `LSL R2, R1, 3` (R2 = R1 << 3)

### 8. LSR (Logical Shift Right)
- **Opcode**: `0111`
- **Format**: `LSR Rd, Rs, Shamt`
- **Description**: Logically shifts the value in `Rs` right by `Shamt` bits and stores the result in `Rd`.
- **Example**: `LSR R3, R2, 2` (R3 = R2 >> 2)

### 9. CMP (Compare)
- **Opcode**: `1000`
- **Format**: `CMP Rd, Rs1, Rs2`
- **Description**: Compares the values in `Rs1` and `Rs2` and sets the flags in `Rd` based on the result.
- **Example**: `CMP R0, R1, R2` (R0 = flags(R1 - R2))

### 10. BEQ (Branch if Equal)
- **Opcode**: `1010`
- **Format**: `BEQ Rs1, Rs2, Offset`
- **Description**: Branches to the address `PC + Offset` if the values in `Rs1` and `Rs2` are equal.
- **Example**: `BEQ R1, R2, 4` (Branch to PC + 4 if R1 == R2)

### 11. IMM (Load Immediate)
- **Opcode**: `1011`
- **Format**: `IMM Rd, Imm`
- **Description**: Loads the immediate value `Imm` into register `Rd`.
- **Example**: `IMM R0, 0x0A` (R0 = 0x0A)

### 12. LD (Load from Memory)
- **Opcode**: `1100`
- **Format**: `LD Rd, Rs`
- **Description**: Loads the value from memory at the address in `Rs` into register `Rd`.
- **Example**: `LD R1, R0` (R1 = MEM[R0])

### 13. ST (Store to Memory)
- **Opcode**: `1101`
- **Format**: `ST Rs, Rd`
- **Description**: Stores the value in `Rs` into memory at the address in `Rd`.
- **Example**: `ST R1, R0` (MEM[R0] = R1)

---

## Example Program
Below is an example program that demonstrates the use of some instructions:

```assembly
IMM R0, 0x0A    ; R0 = 0x0A
IMM R1, 0xAA    ; R1 = 0xAA
NOT R0, R0      ; R0 = ~R0
ADD R2, R1, R0  ; R2 = R1 + R0
ST R2, R0       ; MEM[R0] = R2
