vsim -t ps -novopt -sdfnoerror -sdfmax /uut=/nas/ei/home/ge78pav/TM_power/TM_openlane/TM_openlane_single_mid/TM_openlane_mid_ad/TM_openlane_mid_ad_max/netlist_1/low/netlist_1_post_par.sdf netlist_1_tb
vcd file /nas/ei/home/ge78pav/TM_power/TM_openlane/TM_openlane_single_mid/TM_openlane_mid_ad/TM_openlane_mid_ad_max/netlist_1/low/data/netlist_1_sdf.vcd
vcd add netlist_1_tb/uut/*
run 2002000000
echo [simstats]
quit
