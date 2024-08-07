#!/usr/bin/env python3

import numpy as np, getopt, logging, os, sys, pyDOE, pandas as pnd, seaborn as sns, pylab as plt, json
from pathlib import Path
from sklearn import linear_model
from functionality.simulation.pd_simulation import *
from functionality.simulation.node import GetSignal
from functionality.design.design import Design
from unit_simulation import delay_simulation
from functionality.design.path_extraction.path_extraction import PathExtractor
import progressbar
from multiprocessing import Process
import time

logging.basicConfig(level=logging.INFO);

def usage() :
    print("""usage:
LHS.py [flags] <design file>
    -h              give this help
    -n <nmc>        number of MC samples to do for each LHS point [1000]
    -m <lhs>        number of latin hypercube samples to do [1000]
    -p <pd>         enables power dissipation modeling [False]
    -t <total>      enables complete switching activity tracking  [False]
 """);
    sys.exit();

try:
    opts, args = getopt.getopt(sys.argv[1:], "hn:m:c:p:t:i:");
except getopt.GetoptError as err:
    raise Exception(str(err));

# defaults
NMC = 1000
NLHS = 1000
LO = 1
HI = 50
PD = False
TOTAL = False
plot_file = None
CLK = "clock"

# process flags
for o, a in opts :
    if o == "-h" :
        usage();
    elif o == "-n" :
        NMC = int(a);
    elif o == "-m" :
        NLHS = int(a);
    elif o == "-p":
        if a == 'True':
            PD=True
    elif o == "-t":
        if a == 'True':
            TOTAL=True

if len(args) != 1 :
    raise Exception("Expected one netlist file name")
input_file = args[0]

# generate file paths
DESIGN=input_file.split("/")[-1].replace(".v", "")
if not os.path.exists(input_file.split(DESIGN+".v")[0]+"data"):
    os.makedirs(input_file.split(DESIGN+".v")[0]+"data")
DATA_FILES=input_file.split(DESIGN+".v")[0]+"data/"+DESIGN+".v"
RUNTIME_SCRIPT=open(DATA_FILES.replace(".v","_runtime.txt"), 'w')

# load the post-pd circuit design from json
ud_post_pd_vcd_file=DATA_FILES.replace(".v", "_ud_post_pd.vcd")
json_design=input_file.replace(".v", "_post_par.json")
with open(json_design, 'r') as fp:
    post_pd_circuit_design=Design(json.load(fp), input_file.replace(".v", "_post_par.v"), DESIGN)

# get longest path for post-pd SDF circuit design
sdf_file=input_file.replace(".v", "_post_par.sdf")
SDF_extractor=PathExtractor(sdf_file=sdf_file)
SDF_extractor.graph_generation(post_pd_circuit_design) 
SDF_maximum_delay=SDF_extractor.longest_path_extraction()
# SDF_maximum_delay=2000

print(f"Using Post-PD SDF Delay: {SDF_maximum_delay}")

NIN = 0
for name, bits in post_pd_circuit_design.get_inputs().items():
    NIN += len(bits)


NOUT = 0
for name, bits in post_pd_circuit_design.get_outputs().items():
    NOUT += len(bits)

#prepare data storage for Zero-Delay Simulation (ZD), Unit-Delay Simulation (UD) and Multiple-Delay Simulation (SDF)
R_ZD = np.zeros((NIN+NOUT, NLHS))
R_ZD_TOTAL = None
TOTAL_SIGNALS_ZD = []

R_SDF = np.zeros((NIN+NOUT, NLHS))
R_SDF_TOTAL = None
TOTAL_SIGNALS_SDF = []

R_SDF_P_SWITCHING = None
R_SDF_P_TOGGLE = None
R_SDF_P_STATIC = None
R_SDF_P_LOAD = None
R_SDF_P_VDD = None
TOTAL_SIGNALS_SDF_P = []

#prepare the simulation runs for ZD and SDF:
PD_Simulation.prepare_testbench(post_pd_circuit_design, input_file, NMC, (int((0.5)*SDF_maximum_delay)+1))
PD_Simulation.prepare_simulation(post_pd_circuit_design,  input_file, DATA_FILES, NMC, (int((0.5)*SDF_maximum_delay)+1), PD, TOTAL, behavioral=False)
if PD:
    PD_Simulation.prepare_power_estimation(post_pd_circuit_design, DATA_FILES)

#generate Latin Hypercube samples
INPUTS = 0.01 * (LO + (HI-LO)*pyDOE.lhs(NIN, NLHS, "center"))

# perform the experiments
bar= progressbar.ProgressBar(maxval=NLHS)
bar.start()
for M in range(NLHS):

    # generate the input activities
    ACTIVITY = INPUTS[M,:]
    INPUT_PATTERN = np.zeros((NIN,NMC))
    UD_VECTORS={}
    index=0
    for input, bits in post_pd_circuit_design.get_inputs().items():
        input_signal=input
        bit_length=len(bits)
        if input_signal == CLK:
            ACTIVITY[index]= 0.5
            INPUT_VECTOR= np.zeros((NMC,), dtype=np.int8)
            INPUT_VECTOR[::2] = 1
            INPUT_PATTERN[index]=INPUT_VECTOR
            if bit_length > 1:
                input_signal=input+"["+str(idx)+"]"
            UD_VECTORS[input_signal]=INPUT_VECTOR
            index += 1
            continue
        for idx, bit in enumerate(bits):
            INPUT_VECTOR=GetSignal(NMC, ACTIVITY[index])
            INPUT_PATTERN[index]=INPUT_VECTOR
            if bit_length > 1:
                input_signal=input+"["+str(idx)+"]"
            UD_VECTORS[input_signal]=INPUT_VECTOR
            index += 1
    PD_Simulation.input_vector_generation(INPUT_PATTERN, input_file)
        
    # store the input activities:
    R_SDF[0:NIN,M] = ACTIVITY

    # performing SDF simulation
    runtime=PD_Simulation.run_simulation(input_file, behavioral=False)
    RUNTIME_SCRIPT.write(f"{DESIGN}: ZD SIM (TOTAL): {runtime}\n")
    R_SDF, R_SDF_TOTAL, TOTAL_SIGNALS_SDF = PD_Simulation.extract_outputs(post_pd_circuit_design, DATA_FILES, NMC, NIN, M, R_SDF, TOTAL, R_SDF_TOTAL, TOTAL_SIGNALS_SDF, NLHS, kind='sdf')

    # performing Power analysis
    if PD:
        PD_Simulation.run_power_estimation(post_pd_circuit_design)
        R_SDF_P_SWITCHING, R_SDF_P_TOGGLE, R_SDF_P_STATIC, R_SDF_P_LOAD, R_SDF_P_VDD, TOTAL_SIGNALS_SDF_P = PD_Simulation.extract_power_estimation(DATA_FILES, TOTAL_SIGNALS_SDF_P, R_SDF_P_SWITCHING, R_SDF_P_TOGGLE, R_SDF_P_STATIC, R_SDF_P_LOAD, R_SDF_P_VDD, M, NLHS)

    bar.update(M)

bar.finish()

RUNTIME_SCRIPT.close()

# clear ZD and SDF simulation runs
PD_Simulation.clear_simulation(behavioral=False)
if PD:
    PD_Simulation.clear_power_estimation()

# write the output files

header=list()
for N in post_pd_circuit_design.get_inputs():
    header.append(f"I({N})")
for N in post_pd_circuit_design.get_outputs():
    header.append(f"O({N})")

np.savetxt(DATA_FILES.replace(".v", "_R_SDF.csv"), R_SDF, fmt="%.4f", header=','.join(header), delimiter=',')


if TOTAL:
    header=list()
    for N in TOTAL_SIGNALS_SDF:
        header.append(f"S({N})")
    np.savetxt(DATA_FILES.replace(".v", "_R_SDF_TOTAL.csv"), R_SDF_TOTAL, fmt="%.4f", header=','.join(header), delimiter=',')

# power data:
if PD:
    header=list()
    for N in TOTAL_SIGNALS_SDF_P :
        header.append(f"S({N})")
    np.savetxt(DATA_FILES.replace(".v", "_R_SDF_P_SWITCHING.csv"), R_SDF_P_SWITCHING, fmt="%.12f", header=','.join(header), delimiter=',')
    np.savetxt(DATA_FILES.replace(".v", "_R_SDF_P_TOGGLE.csv"), R_SDF_P_TOGGLE, fmt="%.12f", header=','.join(header), delimiter=',')
    np.savetxt(DATA_FILES.replace(".v", "_R_SDF_P_STATIC.csv"), R_SDF_P_STATIC, fmt="%.12f", header=','.join(header), delimiter=',')
    np.savetxt(DATA_FILES.replace(".v", "_R_SDF_P_LOAD.csv"), R_SDF_P_LOAD, fmt="%.12f", header=','.join(header), delimiter=',')
    np.savetxt(DATA_FILES.replace(".v", "_R_SDF_P_VDD.csv"), R_SDF_P_VDD, fmt="%.12f", header=','.join(header), delimiter=',')



