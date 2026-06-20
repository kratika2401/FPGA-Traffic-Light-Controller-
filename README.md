# FPGA-Based Traffic Light Controller

## Project Overview

This project implements a Traffic Light Controller using Verilog HDL and Finite State Machine (FSM) design on FPGA.

The controller supports:

- North-South and East-West traffic control
- Pedestrian crossing request
- Emergency mode
- Night mode operation
- Safe state transitions using FSM
- Debounced input handling
- Simulation using Icarus Verilog

---

## Project Structure

FPGA_Traffic_Light_Controller

├── constraints

├── include

├── rtl

├── tb

├── reports

└── README.md

---

## FSM States

- S_NS_G
- S_NS_Y
- S_ALL_RED1
- S_EW_G
- S_EW_Y
- S_ALL_RED2
- S_PED_WALK
- S_EMERG_ALL_RED
- S_NIGHT

---

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- VS Code

---

## Simulation

Simulation executed successfully using:

```bash
iverilog -g2012 ...
vvp traffic_sim
```

Output waveform:

```text
traffic.vcd
```

---

## Author

Kratika Chauhan
