TOP = top
DEVICE = hx1k
PACKAGE = tq144

all: $(TOP).bin

$(TOP).json: $(TOP).v trigger_gen.v echo_timer.v buzzer_ctrl.v
	yosys -p "synth_ice40 -top $(TOP) -json $(TOP).json" $^

$(TOP).asc: $(TOP).json project.pcf
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json $(TOP).json --pcf project.pcf --asc $(TOP).asc

$(TOP).bin: $(TOP).asc
	icepack $(TOP).asc $(TOP).bin

prog: $(TOP).bin
	iceprog $(TOP).bin

clean:
	rm -f *.json *.asc *.bin