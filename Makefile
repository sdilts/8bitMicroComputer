OUTPUT_FILE= output.ghw
WORK_DIR=work
GHDL_FLAGS= --workdir=$(WORK_DIR) --std=08

coputer_TB : init
	ghdl -m $(GHDL_FLAGS) computer_TB

test_memory : init
	ghdl -m $(GHDL_FLAGS) test_memory

init : $(WORK_DIR)/
	check_and_run $(WORK_DIR) ghdl -i $(GHDL_FLAGS) *.vhdl *.vhd

$(WORK_DIR)/ :
	mkdir $(WORK_DIR)

clean :
	ghdl --clean $(GHDL_FLAGS)
