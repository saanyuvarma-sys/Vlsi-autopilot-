from pathlib import Path
def run(root):
    ok=(Path(root)/"reports/alu4_netlist.v").exists() and (Path(root)/"logs/synthesis.log").exists()
    return {"agent":"Synthesis","status":"PASS" if ok else "FAIL/NOT CONFIRMED","details":"Checks netlist and synthesis log"}
