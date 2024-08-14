# RISC-V Single Cycle Processor Design

This repository contains the implementation of a RISC-V single-cycle processor designed using SystemVerilog. The processor supports a subset of the RISC-V ISA, focusing on integer operations, memory access, and control flow instructions. 

## Supported Instructions

The processor is capable of executing the following instructions:

### Arithmetic Operations:
- **add**: Add
- **sub**: Subtract
- **xor**: Bitwise XOR
- **or**: Bitwise OR
- **and**: Bitwise AND
- **sll**: Shift Left Logical
- **srl**: Shift Right Logical
- **sra**: Shift Right Arithmetic
- **slt**: Set Less Than
- **sltu**: Set Less Than Unsigned

### Immediate Arithmetic Operations:
- **addi**: Add Immediate
- **xori**: XOR Immediate
- **ori**: OR Immediate
- **andi**: AND Immediate
- **slli**: Shift Left Logical Immediate
- **srli**: Shift Right Logical Immediate
- **srai**: Shift Right Arithmetic Immediate
- **slti**: Set Less Than Immediate
- **sltiu**: Set Less Than Unsigned Immediate

### Load/Store Instructions:
- **lb**: Load Byte
- **lh**: Load Halfword
- **lw**: Load Word
- **lbu**: Load Byte Unsigned
- **lhu**: Load Halfword Unsigned
- **sb**: Store Byte
- **sh**: Store Halfword
- **sw**: Store Word

### Control Flow Instructions:
- **beq**: Branch if Equal
- **bne**: Branch if Not Equal
- **blt**: Branch if Less Than
- **bge**: Branch if Greater or Equal
- **bltu**: Branch if Less Than Unsigned
- **bgeu**: Branch if Greater or Equal Unsigned
- **jal**: Jump and Link
- **jalr**: Jump and Link Register
- **lui**: Load Upper Immediate
- **auipc**: Add Upper Immediate to PC

## Repository Structure

- **/src**: Contains all SystemVerilog source files.
- **/testbench**: Contains testbench files for simulation and verification.
- **/docs**: Includes any design documentation and specifications.

## Simulation and Verification

The processor has been verified using a custom testbench in SystemVerilog.

### Tools Used:
- **Simulator**: [QuestaSim]
- **Verification Methodology**: [self-checking testbenches]


## Future Improvements

Some potential improvements and future work for this project include:
- Pipeline implementation for better performance.
- Support for additional instructions (e.g., multiplication, division).
- Integration with a memory hierarchy (caches).
- Testing with real-world RISC-V benchmarks.


## Acknowledgements

This project was inspired by the RISC-V ISA and various open-source processor design resources.
