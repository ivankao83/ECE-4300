
# MIPS Instruction Fetch (IF) Stage

## Design Scope and Assumptions

- **In scope:** The Fetch (IF) stage gets instructions from instruction memory and passes them to the Decode stage. It uses the Program Counter, Adder, Mux, Instruction Memory, and IF/ID Latch modules to do this.
- **Out of scope:** This stage does not decode or execute instructions. Those operations are handled by other pipeline stages.
- **Assumptions:** The clock and reset signals are provided, and instruction memory already contains instructions. The stage also receives the branch control signal and branch address.
- **Limitations:** Only the instructions initialized in instruction memory can be fetched.

## Requirements

| Requirement | Description | Verification Method |
|---|---|---|
| REQ-01 | Keep track of the instruction address using the Program Counter. | Simulation |
| REQ-02 | Increment the PC by 4 for the next instruction. | Simulation |
| REQ-03 | Read instructions from Instruction Memory. | Simulation |
| REQ-04 | Select the next PC based on the branch control signal. | Simulation |
| REQ-05 | Store the instruction and NPC in the IF/ID Latch. | Simulation |

## Architecture

The Fetch stage uses five main modules to get instructions and prepare them for the next stage.

### Timing or Behavioral Summary

The Program Counter keeps track of the current address, and the Adder calculates the next address by adding 4. The Mux selects the next PC depending on the branch signal. Instruction Memory provides the instruction, and the IF/ID Latch stores the instruction and NPC.

## Implementation

### Source Code

| File | Description |
|---|---|
| [adder.v](src/adder.v) | Adds 4 to the Program Counter. |
| [Fetch.v](src/Fetch.v) | Connects all the Fetch modules. |
| [instruction_mem.v](src/instruction_mem.v) | Stores and provides instructions. |
| [Latch.v](src/Latch.v) | Stores the instruction and NPC. |
| [Mux.v](src/Mux.v) | Selects the next PC address. |
| [program_counter.v](src/program_counter.v) | Keeps track of the instruction address. |
| [Fetch_tb.v](testbench/Fetch_tb.v) | Tests the complete Fetch stage. |

### Implementation Notes

The modules are written in Verilog and connected in Vivado to create the complete Fetch stage.

## Verification

### Verification Strategy

We tested the Fetch stage using Behavioral Simulation in Vivado. The testbench checks how the PC changes, how instructions are fetched, and how the stage responds to branch and reset signals.

### Testbench and Waveform

The first timing diagram shows the Fetch stage moving through instructions as the PC increases by 4.

![Fetch Timing Diagram 1](images/Screenshot%202026-10-16%20180853.png)

The second timing diagram shows how the Fetch stage responds to changes in the branch control signal.

![Fetch Timing Diagram 2](images/Screenshot%202026-10-16%20181332.png)

The testbench can be found [here](testbench/Fetch_tb.v).

### Results

| Test Case | Expected Result | Observed Result | Status |
|---|---|---|---|
| Program Counter | Moves to the next instruction address. | The PC increased by 4. | Pass |
| Instruction Memory | Provides instructions based on the address. | Instructions changed as the PC moved. | Pass |
| Mux | Selects the next PC based on PCSrc. | The Fetch outputs responded when PCSrc changed. | Pass |
| IF/ID Latch | Stores the instruction and NPC. | Outputs updated with the clock. | Pass |
| Fetch Stage | Connects all the modules. | Expected outputs appeared in the timing diagram. | Pass |

## Reproduction Instructions

### Tools and Versions

- **Tool:** Xilinx Vivado 2025.2
- **Language:** Verilog HDL
- **Operating System:** Windows

### Build and Run

1. Open Vivado and create an RTL project.
2. Add the Verilog files from the `src` folder under Design Sources.
3. Set `Fetch.v` as the top design module.
4. Add `Fetch_tb.v` under Simulation Sources.
5. Run Behavioral Simulation and check the timing diagram.

## Repository Organization

```text
Fetch/
├── README.md
├── src/
│   ├── adder.v
│   ├── Fetch.v
│   ├── instruction_mem.v
│   ├── Latch.v
│   ├── Mux.v
│   └── program_counter.v
├── testbench/
│   ├── adder_tb.v
│   ├── Fetch_tb.v
│   ├── instruction_mem_tb.v
│   ├── Latch_tb.v
│   ├── Mux_tb.v
│   └── program_counter_tb.v
└── images/
    ├── Screenshot 2026-10-16 180853.png
    └── Screenshot 2026-10-16 181332.png
```

## Known Issues and Future Improvements

The instruction memory only contains the instructions initialized for testing. More instructions could be added in the future to test additional program behavior.
