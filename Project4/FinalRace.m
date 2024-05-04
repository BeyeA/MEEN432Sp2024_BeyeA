% Simulates the model for 60 minutes
GenTrack;
P4init;
simout = sim("P4_Model_2.slx", "StopTime", "3600");
carX = simout.X.Data;
carY = simout.Y.Data;
tout = simout.tout;

% Race Statistics
race = raceStat(carX, carY, tout, path, simout);
disp(race)



