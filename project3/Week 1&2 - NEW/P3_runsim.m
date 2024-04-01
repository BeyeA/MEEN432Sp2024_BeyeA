% Highway Drive Cycle
%--------------------------------------------------------------------------

run('init.m');
run('init_HWY_DriveCycle.m');
DriveData = DriveData_Hwy;
HWY_T = 765;
simout_hwy = sim("P3_model.slx",'StopTime', num2str(HWY_T));
sim_vel_hwy = simout_hwy.vel.Data;
sim_time_hwy = simout_hwy.tout;
energy_hwy = simout_hwy.energy;

sim_torque = simout_hwy.torque.Data; 
sim_angularvelocity = simout_hwy.AV.Data; 

power = zeros(size(sim_time_hwy));

for i = 1:length(sim_time_hwy)
    angularvelocity_rads = (sim_angularvelocity(i) * ((2*pi) / 60)); 
    power(i) = sim_torque(i)*angularvelocity_rads; 
end

energy = sum(power)*0.001; 
disp(['Total Energy consumed for Highway EPA Cycle: ' num2str(energy) ' Joules']);

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

figure;
plot(sim_time_hwy,power, 'r')
hold on
xlabel("Time (s)")
ylabel("Energy (Joules)") 
title("Highway Cycle: Energy vs. Time")
hold off

% Urban Drive Cycle
%--------------------------------------------------------------------------

clearvars -except simout_hwy  sim_vel_hwy sim_time_hwy energy_hwy;
run('init_URB_DriveCycle.m');
run('init.m');

DriveData = DriveData_urban;
URB_T = 1369;

simout_urb = sim("P3_model.slx",'StopTime', num2str(URB_T));
sim_vel_urb = simout_urb.vel.Data;
sim_time_urb = simout_urb.tout;
energy_urb = simout_urb.energy;

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

sim_torque = simout_urb.torque.Data; 
sim_angularvelocity = simout_urb.AV.Data; 

power = zeros(size(sim_time_urb));

for i = 1:length(sim_time_urb)
    angularvelocity_rads = (sim_angularvelocity(i) * ((2*pi) / 60)); 
    power(i) = sim_torque(i)*angularvelocity_rads; 
end

energy = sum(power)*0.001; 
disp(['Total Energy consumed for Urban EPA Cycle: ' num2str(energy) ' Joules ']);


figure;
plot(sim_time_urb,power, 'r')
hold on
xlabel("Time (s)")
ylabel("Energy (Joules)") 
title("Urban Cycle: Energy vs. Time")
hold off


% For seeing how large the errors are
% error = zeros(length(Time),1);
% for j = 1:length(Time)
%     time_dc = Time(j);
%     vel_dc = DriveData(j);
%     for i = 1:length(sim_time)
%         time_s = sim_time(i);
%         vel_s = sim_vel(i);
% 
%         if time_s == time_dc
%             err = vel_dc - vel_s;
%             error(j) = err;
%         else
%         end
%     end
% end