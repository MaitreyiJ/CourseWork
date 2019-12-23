# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog FSM2.v

#load simulation using mux as the top level simulation module
vsim FSM2


#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets


force {CLOCK_50} 0 0ns, 1 {10ns} -r 20ns

force {KEY[0]} 0
force {KEY[1]} 1
run 1000ns
force {KEY[0]} 1
force {SW[0]} 1
 force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0

run 1000ns
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns



force {SW[0]} 1
 force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns
 

force {SW[0]} 1
 force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns
 

force {SW[0]} 1
 force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns
 



force {SW[0]} 1
 force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns
 
force {SW[0]} 1
 force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns
 
force {SW[0]} 1
 force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns
 
force {SW[0]} 0
 force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns



force {SW[0]} 1
 force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns
 
force {SW[0]} 0
 force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns
 
force {SW[0]} 1
 force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns
 
force {SW[0]} 1
 force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[1]} 0
run 1000ns
force {KEY[1]} 1
run 1000ns
 
 

    

    
