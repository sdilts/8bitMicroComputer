OUTPUT_FILE= output.ghw
WORK_DIR=work
GHDL_FLAGS= --workdir=$(WORK_DIR) --std=08

build : init
	ghdl -m $(GHDL_FLAGS) computer_TB

init : $(WORK_DIR)/
	check_and_run $(WORK_DIR) ghdl -i $(GHDL_FLAGS) *.vhdl *.vhd

$(WORK_DIR)/ :
	mkdir $(WORK_DIR)

clean :
	ghdl --clean $(GHDL_FLAGS)
