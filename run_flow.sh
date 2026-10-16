#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p logs reports
command -v iverilog >/dev/null || { echo "ERROR: iverilog missing"; exit 2; }
command -v yosys >/dev/null || { echo "ERROR: yosys missing"; exit 2; }
iverilog -g2012 -o logs/alu4_sim rtl/alu4.v testbench/alu4_tb.v 2>&1 | tee logs/compile.log
vvp logs/alu4_sim 2>&1 | tee logs/simulation.log
grep -q "PASS: 1024 ALU input/operation combinations passed" logs/simulation.log || { echo "ERROR: verification did not pass"; exit 3; }
yosys -p 'read_verilog rtl/alu4.v; hierarchy -check -top alu4; proc; opt; check; synth -top alu4; stat; write_verilog reports/alu4_netlist.v' 2>&1 | tee logs/synthesis.log
test -s reports/alu4_netlist.v
echo "FLOW_STATUS=PASS"
