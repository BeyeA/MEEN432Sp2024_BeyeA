This file explains how to run the Final Project Deliverables.


Part 1: Download the Part1.m (Matlab) file and the Week2.slx (Simulink Block) file. Open the downloaded files using the Matlab R2023b application. Click the "run" button on the Matlab application. The expected output from running the program is set up for 8 simulations as outlined in the Week 2 deliverables. This is so that the computational load of running all 256 simulations is limited at first. 

If all 256 simulations are wanted to be run, the file has commented-out line code that can easily replace the current line code. 

Part 2: Download the Part2.m (Matlab) File, the Option1.slx (Simulink Block) file, the Option2.slx (Simulink Block) file, and the Option3.slx (Simulink Block).  file. Click the "run" button on the Matlab application. The expected output is 36 figures with 3 plots of angular velocity vs. time. The CPU time can be viewed either in the combo table or the CPU_Time_Table. 

## Final Week Feedback
- Part 1: 
1) There is no logic that considers whether the applied torque is constant or sinusoidal in either the Simulink model or MATLAB script.
2) The EOM currently only contains constant torque based on the how the equation was setup and never runs through a sinusoidal case.
3) The only plots that needed to be plotted were the Max Error vs Timestep, Max Error vs CPU Time, and CPU Time vs Timestep, there is no need to plot the angular accel/vel. There is also no need to generate plots. It is best if the simulation data for similar cases (ode1, ode4, etc) are plotted together with legends that way the number of plots is greatly reduced.
- Part 2:
1) In the Option 1 model, the S1 EOM has the spring torque being added to the equation, which is fine if spring torque is negative. However, in the spring equation block, you set tau_sp1 as negative, but never made it an ouput of the block so instead, the spring torque going to S1 is actually positive and adding to the EOM which makes the numerical results wrong for Option 1. 
