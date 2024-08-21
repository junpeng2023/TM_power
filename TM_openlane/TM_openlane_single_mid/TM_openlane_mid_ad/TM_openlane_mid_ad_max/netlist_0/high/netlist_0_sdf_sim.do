vsim -t ps -novopt -sdfnoerror -sdfmax /uut=/nas/ei/home/ge78pav/TM_power/TM_openlane/TM_openlane_single_mid/TM_openlane_mid_ad/TM_openlane_mid_ad_max/netlist_0/high/netlist_0_post_par.sdf netlist_0_tb
vcd file /nas/ei/home/ge78pav/TM_power/TM_openlane/TM_openlane_single_mid/TM_openlane_mid_ad/TM_openlane_mid_ad_max/netlist_0/high/data/netlist_0_sdf.vcd
vcd add netlist_0_tb/uut/*
run 2002000000
echo [simstats]
quit
