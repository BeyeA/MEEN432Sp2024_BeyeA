run('Finalinit.m');
run('init_HWY_DriveCycle.m');
DriveData = DriveData_Hwy;
HWY_T = 765;
simout_hwy = sim("P3_Model_Final_V2.slx",'StopTime', num2str(HWY_T));
sim_vel_hwy = simout_hwy.vel.Data;
sim_time_hwy = simout_hwy.tout;

sim_torque = simout_hwy.torque.Data; 
sim_angularvelocity = simout_hwy.AV.Data; 

figure;
plot(sim_time_hwy, sim_vel_hwy*(1/mph2mps), 'b')
hold on
plot(Time, DriveData, '--r') 
plot(Time, (DriveData)+3, 'k') 
plot(Time, (DriveData)-3, 'k') 
xlabel("Time (s)")
ylabel("Velocity (mph)") 
legend("Sim Velocity", "Drive Cycle Velocity", "3 mph Error Band")
title("Highway Cycle: Simulated Vehicle Velocity vs. Time")
hold off

% Urban Drive Cycle
%--------------------------------------------------------------------------

clearvars -except simout_hwy  sim_vel_hwy sim_time_hwy energy_hwy;
run('init_URB_DriveCycle.m');
run('Finalinit.m');

DriveData = DriveData_urban;
URB_T = 1369;

simout_urb = sim("P3_Model_Final_V2.slx",'StopTime', num2str(URB_T));
sim_vel_urb = simout_urb.vel.Data;
sim_time_urb = simout_urb.tout;

figure;
plot(sim_time_urb, sim_vel_urb*(1/mph2mps), 'b') 
hold on
plot(Time, DriveData, '--r') 
plot(Time, (DriveData)+3, 'k') 
plot(Time, (DriveData)-3, 'k') 


xlabel("Time (s)")
ylabel("Velocity (mph)") 
legend("Sim Velocity", "Drive Cycle Velocity", "3 mph Error Band")
title("Urban Cycle: Simulated Vehicle Velocity vs. Time")
hold off

