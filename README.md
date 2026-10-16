# VLSI AutoPilot
A starter multi-agent EDA automation framework for a four-bit ALU.

## Run
```bash
bash scripts/run_flow.sh
python main.py
python generate_report.py
```

## Implemented
- Exhaustive testbench over 1024 ALU input/operation combinations
- Icarus Verilog simulation and Yosys synthesis
- Python agent orchestration and JSON experiment record
- PDF report generation from recorded results

## Limitations
Timing, power, and foundry-specific physical area are not measured by the starter flow. They require compatible tools, libraries, constraints, and configuration.
