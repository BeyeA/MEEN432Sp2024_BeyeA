% Highway Drive Cycle
run('init.m');
run('init_HWY_DriveCycle.m');
DriveData = DriveData_Hwy;
HWY_T = 765;
simout_hwy = sim("P3_model.slx",'StopTime', num2str(HWY_T));
sim_vel_hwy = simout_hwy.vel.Data;
sim_time_hwy = simout_hwy.tout;

figure;
plot(sim_time_hwy, sim_vel_hwy*(1/mph2mps), 'b') % Remember, drive cycles are mph
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
clearvars -except simout_hwy  sim_vel_hwy sim_time_hwy;
run('init_URB_DriveCycle.m');
run('init.m');

DriveData = DriveData_urban;
URB_T = 1369;

simout_urb = sim("P3_model.slx",'StopTime', num2str(URB_T));
sim_vel_urb = simout_urb.vel.Data;
sim_time_urb = simout_urb.tout;

figure;
plot(sim_time_urb, sim_vel_urb*(1/mph2mps), 'b') % Remember, drive cycles are mph
hold on
plot(Time, DriveData, '--r') 
plot(Time, (DriveData)+3, 'k') 
plot(Time, (DriveData)-3, 'k') 







xlabel("Time (s)")
ylabel("Velocity (mph)") 
legend("Sim Velocity", "Drive Cycle Velocity", "3 mph Error Band")
title(" Urban Cycle: Simulated Vehicle Velocity vs. Time")
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