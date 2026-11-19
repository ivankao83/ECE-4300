# MIPS Instruction Execute (EX) Stage

## Design Scope and Assumptions

- **In scope:** The Execute (EX) stage takes the information from the Decode stage and performs the operations needed for the instruction. It uses the ALU, ALU Control, Adder, two Muxes, and EX/MEM Latch to do this.
- **Out of scope:** This stage does not fetch or decode instructions, and it does not read or write data memory. Those operations are handled by other stages.
- **Assumptions:** The register values, control signals, NPC, immediate value, and instruction fields come from the Decode stage. The clock is also provided.
- **Limitations:** The Execute stage is tested separately from the other pipeline stages.

## Requirements

| Requirement | Description | Verification Method |
|---|---|---|
| REQ-01 | Perform arithmetic and logical operations using the ALU. | Simulation |
| REQ-02 | Generate the correct ALU control signals. | Simulation |
| REQ-03 | Calculate addresses using the Adder. | Simulation |
| REQ-04 | Select the correct ALU input and destination register using the Muxes. | Simulation |
| REQ-05 | Store the results and control signals in the EX/MEM Latch. | Simulation |
| REQ-06 | Connect all modules into the Execute stage. | Simulation |

## Architecture

The Execute stage uses six modules to perform calculations and pass the results to the next stage: ALU, ALU Control, Adder, Top Mux, Bottom Mux, and EX/MEM Latch. The main Execute module connects them together.

### Timing or Behavioral Summary

The ALU Control uses ALUOp and the funct field to determine which operation the ALU should perform. The top Mux selects between the second register value and the sign-extended immediate, while the bottom Mux selects the destination register. The Adder calculates an address using NPC and the extended immediate value. The EX/MEM Latch stores the results and control signals on the rising clock edge.

## Implementation

### Source Code

| File | Description |
|---|---|
| [alu.v](src/alu.v) | Performs ADD, SUB, AND, OR, and SLT operations. |
| [alu_control.v](src/alu_control.v) | Selects the ALU operation using ALUOp and the funct field. |
| [adder.v](src/adder.v) | Adds the NPC and extended immediate value. |
| [top_mux.v](src/top_mux.v) | Selects the second ALU input. |
| [bottom_mux.v](src/bottom_mux.v) | Selects the destination register. |
| [ex_mem.v](src/ex_mem.v) | Stores the Execute results and control signals. |
| [execute.v](src/execute.v) | Connects all six modules. |

### Implementation Notes

The modules are written in Verilog and connected in Vivado to create the complete Execute stage. The ALU performs arithmetic and logical operations, while ALU Control determines which operation is needed. The Muxes select the correct values, and the EX/MEM Latch stores the results so they can be passed to the Memory stage.

## Verification

### Verification Strategy

We tested the Execute stage using Behavioral Simulation in Vivado. The updated testbench checks ADD, SUB, BEQ, LW, SW, AND, OR, and SLT. We also tested the ALU and ALU Control separately to check the other operations.

### Testbench and Waveform

The timing diagram below shows the Execute stage testing all eight instructions: ADD, SUB, BEQ, LW, SW, AND, OR, and SLT.

![Execute Stage Timing Diagram](images/ExecuteUpdated.png)

The testbenches can be found here:

- [Execute Testbench](testbench/executeTB.v)
- [ALU Testbench](testbench/alu_tb.v)
- [ALU Control Testbench](testbench/alu_control_tb.v)

### Results

| Test Case | Expected Result | Observed Result | Status |
|---|---|---|---|
| ADD | Adds the selected inputs. | 10 + 4 = 14. | Pass |
| SUB | Subtracts the selected inputs. | 10 - 20 = -10. | Pass |
| BEQ | Sets Zero to 1 when the values are equal. | 10 - 10 = 0, Zero = 1. | Pass |
| LW | Calculates the memory address and passes MemRead. | ALU result = 18, MEM = 010. | Pass |
| SW | Calculates the memory address and passes MemWrite. | ALU result = 18, MEM = 001. | Pass |
| AND | Performs a bitwise AND operation. | 10 AND 20 = 0. | Pass |
| OR | Performs a bitwise OR operation. | 10 OR 20 = 30. | Pass |
| SLT | Sets the result to 1 when the first value is less than the second. | 10 < 20, result = 1. | Pass |
| ALU Control | Generates the correct ALU control values. | Values matched the expected operations. | Pass |
| ALU | Performs arithmetic and logical operations. | ADD, SUB, AND, OR, and SLT gave the expected results. | Pass |
| EX/MEM Latch | Stores results on the rising clock edge. | Outputs updated with the clock. | Pass |

## Reproduction Instructions

### Tools and Versions

- **Tool:** Xilinx Vivado 2025.2
- **Language:** Verilog HDL
- **Operating System:** Windows

### Build and Run

1. Open Vivado and create an RTL project.
2. Add the Verilog files from the `src` folder under Design Sources.
3. Set `execute.v` as the top design module.
4. Add `executeTB.v` under Simulation Sources.
5. Set `executeTB` as the simulation top.
6. Run Behavioral Simulation and check the timing diagram for all eight tests.
7. Run the separate ALU and ALU Control testbenches to check their outputs.

## Repository Organization

```text
Execute/
├── README.md
├── src/
│   ├── alu.v
│   ├── alu_control.v
│   ├── adder.v
│   ├── top_mux.v
│   ├── bottom_mux.v
│   ├── ex_mem.v
│   └── execute.v
├── testbench/
│   ├── executeTB.v
│   ├── alu_tb.v
│   └── alu_control_tb.v
└── images/
    └── ExecuteUpdated.png
```

## Known Issues and Future Improvements

The Execute stage was tested separately from Fetch and Decode. The stages still need to be connected, including passing the six-bit funct field from Decode to Execute through the ID/EX Latch. More testing could also be done once the full pipeline is connected.
