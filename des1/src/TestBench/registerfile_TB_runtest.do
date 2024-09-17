SetActiveLib -work
comp -include "$dsn\src\registerfile.vhd" 
comp -include "$dsn\src\TestBench\registerfile_TB.vhd" 
asim +access +r TESTBENCH_FOR_registerfile 
wave 
wave -noreg clk_in
wave -noreg enable_in
wave -noreg write_enable_in
wave -noreg rM_data_out
wave -noreg rN_data_out
wave -noreg rD_data_in
wave -noreg sel_rM_in
wave -noreg sel_rN_in
wave -noreg sel_rD_in
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\registerfile_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_registerfile 
