read_libs saed90nm_typ.lib
read_hdl "design"
elaborate

set_db dft_scan_style muxed_scan
define_shift_enable -active high scan_enable

define_test_mode -name rst -active low wb_rst_i
define_test_clock -name clk wb_clk_i

check_dft_rules

report_scan_registers

report_scan_setup 

syn_generic 
syn_map 
set_db dft_prefix DFT_

define_scan_chain -sdi scan_in -sdo scan_out -shared_output -shift_enable scan_enable
connect_scan_chains 

report_scan_chains > scan_chain_file.txt
report_scan_setup > scan_setup_file.txt
syn_opt 

write_hdl > scan_netlist.v

write_dft_atpg -library saed90nm.v
