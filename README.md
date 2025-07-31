# 🚦 4-Way Traffic Light Controller (Verilog Simulation)

This project implements a realistic **4-phase traffic light controller** for a 4-way road junction using Verilog. It simulates real-world traffic signal logic with independent lights for each directional movement (left, straight, right) for Roads R1 to R4.

---

## 🛣️ Junction Layout

Each road (R1 to R4) supports:
- Left Turn (`R?_L`)
- Straight (`R?_S`)
- Right Turn (`R?_R`)

Each movement is controlled by a separate set of:
- Red, Yellow, and Green signals

There are **12 independent traffic directions**, resulting in **36 traffic lights** (12 × 3 colors).

---

## 🔄 Signal Phases

The controller cycles through **4 phases**:

| Phase | Green Movements                      | Duration (ns) | Rationale                               |
|-------|--------------------------------------|---------------|------------------------------------------|
| 1     | R1_L, R1_S, R3_S, R3_L               | 200           | Safe parallel movement North–South       |
| 2     | R1_R, R2_R                           | 200           | Right-turns that don’t conflict          |
| 3     | R2_L, R2_S, R4_S, R4_L               | 200           | East–West Straight/Left safe movement    |
| 4     | R3_R, R4_R                           | 200           | Right-turns from South/West              |
| Y/B   | Yellow + All Red Buffers             | 50 each       | To ensure safety during phase switching  |

Each green phase is followed by a yellow and buffer period.

---

## 📁 File Structure

| File              | Description                                     |
|-------------------|-------------------------------------------------|
| `traffic_lights.v` | Verilog module for traffic light FSM logic     |
| `tb_traffic.v`     | Testbench for simulating and generating VCD    |
| `traffic_lights.vcd` | Waveform generated for GTKWave                |
| `dump.gtkw`        | GTKWave save file (preloaded signals)          |

---

## 🧪 How to Run

### 1. Compile Verilog Code

```bash
iverilog -o traffic_tb traffic_lights.v tb_traffic.v
