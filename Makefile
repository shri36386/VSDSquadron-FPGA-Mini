# Project name and device specifications
TOP = top              # Top-level Verilog module
DEVICE = hx1k          # Device type (iCE40HX1K for iCEBreaker)
PACKAGE = tq144        # Package type (can be adjusted depending on your board)

# The generated files
JSON_FILE = $(TOP).json
ASC_FILE = $(TOP).asc
BIN_FILE = $(TOP).bin

# The PCF file (pin configuration)
PCF_FILE = project.pcf

# All targets
all: $(BIN_FILE)

# Step 1: Synthesis
$(JSON_FILE): $(TOP).v trigger_gen.v echo_timer.v led_ctrl.v
	yosys -p "synth_ice40 -top $(TOP) -json $(JSON_FILE)" $^

# Step 2: Place and Route
$(ASC_FILE): $(JSON_FILE) $(PCF_FILE)
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json $(JSON_FILE) --pcf $(PCF_FILE) --asc $(ASC_FILE)

# Step 3: Bitstream Generation
$(BIN_FILE): $(ASC_FILE)
	icepack $(ASC_FILE) $(BIN_FILE)

# Step 4: Programming the FPGA
prog: $(BIN_FILE)
	iceprog $(BIN_FILE)

# Clean up the generated files
clean:
	rm -f *.json *.asc *.bin
