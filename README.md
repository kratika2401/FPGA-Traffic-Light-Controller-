# FPGA-Based Traffic Light Controller

## Project Overview

This project implements a 4-Way Traffic Light Controller using Verilog HDL and Finite State Machine (FSM) design methodology.

The controller manages North-South and East-West traffic flow while supporting:

- Vehicle traffic control
- Pedestrian crossing requests
- Emergency vehicle override
- Night flashing mode
- Timer-based state transitions
- Debounced input handling

The design is suitable for FPGA implementation and simulation-based verification.

---

## Objectives

- Design a safe traffic signal controller using FSM concepts.
- Implement parameterized timing control.
- Support pedestrian and emergency requests.
- Demonstrate FPGA and VLSI design principles.
- Verify functionality through simulation.

---

## Features

- Moore FSM Architecture
- North-South and East-West Signal Control
- Pedestrian Walk Request
- Emergency All-Red Mode
- Night Flashing Mode
- Debounced Inputs
- Timer-Based State Control
- FPGA Ready Design
- Simulation Verification

---

## Project Architecture

Clock Input
↓
Clock Enable Generator
↓
Input Conditioning (Debounce + Synchronizer)
↓
Traffic FSM Controller
↓
Timer Control Logic
↓
Traffic Signal Outputs
↓
Simulation / FPGA LEDs

---

## FSM States

| State | Description |
|---------|------------|
| S_NS_G | North-South Green |
| S_NS_Y | North-South Yellow |
| S_ALL_RED1 | All Red Transition |
| S_EW_G | East-West Green |
| S_EW_Y | East-West Yellow |
| S_ALL_RED2 | All Red Transition |
| S_PED_WALK | Pedestrian Walk |
| S_EMERG_ALL_RED | Emergency Override |
| S_NIGHT | Night Flashing Mode |

---

## Folder Structure

```text
FPGA_Traffic_Light_Controller
│
├── constraints
│   ├── traffic_top.pcf
│   └── traffic_top.xdc
│
├── docs
├── images
│
├── include
│   └── params.vh
│
├── reports
│   └── Project_Report.txt
│
├── rtl
│   ├── clk_en.v
│   ├── debounce_sync.v
│   ├── timer.v
│   ├── traffic_fsm.v
│   └── top.v
│
├── scripts
├── tb
│   └── traffic_tb.v
│
├── waveforms
│
├── traffic_sim
├── traffic.vcd
└── README.md
```

---

## Tools Used

- Verilog HDL
- Visual Studio Code
- Icarus Verilog
- GTKWave (Optional)
- Yosys (Optional)
- FPGA Development Boards

---

## Simulation Steps

### Compile

```bash
iverilog -g2012 -I include -o traffic_sim rtl/clk_en.v rtl/debounce_sync.v rtl/timer.v rtl/traffic_fsm.v rtl/top.v tb/traffic_tb.v
```

### Run Simulation

```bash
vvp traffic_sim
```

### Output

```text
traffic.vcd
```

Waveform file generated successfully after simulation.

---

## FPGA Implementation

1. Add RTL files to FPGA project.
2. Add XDC/PCF constraints.
3. Run synthesis.
4. Run implementation.
5. Generate bitstream.
6. Program FPGA board.
7. Verify LEDs and inputs.

---

## Applications

- Smart Traffic Control Systems
- Smart City Infrastructure
- Industrial Automation
- Embedded Control Systems
- FPGA Education Projects
- VLSI Academic Projects

---

## Learning Outcomes

This project demonstrates:

- Finite State Machine Design
- Sequential Logic Design
- Combinational Logic Design
- FPGA Development Flow
- RTL Coding
- Functional Verification
- Traffic Control System Design

---

## Simulation Status

✅ RTL Compilation Successful

✅ Simulation Successful

✅ VCD File Generated

✅ FPGA Constraints Added

---

## Author

Kratika Chauhan

B.Tech Project – FPGA Based Traffic Light Controller