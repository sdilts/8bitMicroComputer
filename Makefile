OUTPUT_FILE= output.ghw
WORK_DIR=work
GHDL_FLAGS= --workdir=$(WORK_DIR) --std=08

computer_TB : init
	ghdl -m $(GHDL_FLAGS) computer_TB

run_tests : test_memory
	./test_memory --wave=memory.ghw

test_memory : init
	ghdl -m $(GHDL_FLAGS) test_memory

run_computer : computer_TB
	./computer_tb --wave=computer.ghw --stop-time=500ns

init : $(WORK_DIR)/
	check_and_run $(WORK_DIR) ghdl -i $(GHDL_FLAGS) *.vhdl *.vhd

$(WORK_DIR)/ :
	mkdir $(WORK_DIR)

clean :
	ghdl --clean $(GHDL_FLAGS)
	rm *.o
	rm *.ghw
