set_app_var target_library "/nas/ei/home/ge78pav/stdlib_db/stdcells.db"
set_app_var link_library "* /nas/ei/home/ge78pav/stdlib_db/stdcells.db"

set_app_var power_enable_analysis true
set_app_var power_analysis_mode time_based

read_verilog "/nas/ei/home/ge78pav/TM_power/TM_openlane/TM_openlane_single_mid/TM_openlane_mid_ad/TM_openlane_mid_ad_max/netlist_1/low/netlist_1_post_par.v"
current_design netlist_1
link_design

read_vcd -strip_path "netlist_1_tb/uut" /nas/ei/home/ge78pav/TM_power/TM_openlane/TM_openlane_single_mid/TM_openlane_mid_ad/TM_openlane_mid_ad_max/netlist_1/low/data/netlist_1_sdf.vcd
read_parasitics -format spef "/nas/ei/home/ge78pav/TM_power/TM_openlane/TM_openlane_single_mid/TM_openlane_mid_ad/TM_openlane_mid_ad_max/netlist_1/low/netlist_1_post_par.spef"

check_activity [get_pins *]
set_power_analysis_options -include all_with_leaf -separate_power_waveform all -waveform_format out -waveform_output /nas/ei/home/ge78pav/TM_power/TM_openlane/TM_openlane_single_mid/TM_openlane_mid_ad/TM_openlane_mid_ad_max/netlist_1/low/data/netlist_1_sdf_p

update_power
report_power -net_power -nosplit -hierarchy > /nas/ei/home/ge78pav/TM_power/TM_openlane/TM_openlane_single_mid/TM_openlane_mid_ad/TM_openlane_mid_ad_max/netlist_1/low/data/netlist_1_SDF_p_report.txt

exit