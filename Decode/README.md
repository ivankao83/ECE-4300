
# MIPS Instruction Decode (ID) Stage

## Design Scope and Assumptions

- **In scope:** The Decode (ID) stage takes the instruction from the Fetch stage and breaks it down to get the information needed for the next stage. It uses the Register File, Control, Sign Extend, and ID/EX Latch modules to do this.
- **Out of scope:** This stage does not execute instructions or access data memory. Those operations are handled by other stages.
- **Assumptions:** The instruction and NPC come from the Fetch stage. The clock, reset, and Write Back signals are also provided.
- **Limitations:** Only the first 10 registers have initial values.

## Requirements

| Requirement | Description | Verification Method |
|---|---|---|
| REQ-01 | Read and write data using 32 registers. | Simulation |
| REQ-02 | Generate control signals for R-format, LW, SW, and BEQ. | Simulation |
| REQ-03 | Extend 16-bit immediate values to 32 bits. | Simulation |
| REQ-04 | Store decoded values in the ID/EX Latch. | Simulation |
| REQ-05 | Connect all modules into the Decode stage. | Simulation |

## Architecture

The Decode stage uses four modules to process the instruction and pass the information to the next stage.

### Timing or Behavioral Summary

*To be added after testing.*

## Implementation

### Source Code

| File | Description |
|---|---|
| [signExtend.v](src/signExtend.v) | Extends immediate values to 32 bits. |
| [control.v](src/control.v) | Generates control signals. |
| [regfile.v](src/regfile.v) | Reads and writes register values. |
| [idExLatch.v](src/idExLatch.v) | Stores decoded information. |
| [decode.v](src/decode.v) | Connects all four modules. |

### Implementation Notes

The modules are written in Verilog and will be connected and tested using Vivado.

## Verification

### Verification Strategy

The Decode stage will be tested using Behavioral Simulation in Vivado to check if the outputs match the expected values.

### Testbench and Waveform

*To be added after testing.*

### Results

*To be added after testing.*

## Reproduction Instructions

### Tools and Versions

- **Tool:** Xilinx Vivado
- **Language:** Verilog HDL
- **Operating System:** Windows

### Build and Run

*To be added after completing the Decode stage.*

## Repository Organization

```text
Decode/
├── README.md
├── src/
│   ├── signExtend.v
│   ├── control.v
│   ├── regfile.v
│   ├── idExLatch.v
│   └── decode.v
├── testbench/
└── images/
```

## Known Issues and Future Improvements

*To be updated after testing.*
