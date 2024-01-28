% Initial Conditions

w_0 = 1.0; % Initial Angular Velocity [rad/s]
J = 1; % Rotational Inertia [kg-m^2]
b = 1; % Damping Coefficient [N-m-s/rad]
A = 1; % Constant Applied Torque [N-m]


dT = [0.001, 0.1, 1]; % Time Step [s]
solver = ["ode1", "ode4"]; % Fixed Time Step Solver [Euler]

for i = 1:length(dT)
    dT_current = dT(i)    

    for j = 1:length(solver)
        solver_current = solver(j)

        simout = sim("Week1.slx", "Solver", solver_current, "FixedStep", string(dT_current));
        W = simout.w.Data;
        W_DOT = simout.w_dot.Data;
        T = simout.tout;
        
        figure; % Create a new figure for each simulation
        subplot(2, 1, 1);
        plot(T, W);
        xlabel('Time (s)');
        ylabel('Angular Velocity');
        title(['Angular Velocity for dT = ' num2str(dT_current) 'Solver = ' solver_current]);

        subplot(2, 1, 2);
        plot(T, W_DOT);
        xlabel('Time (s)');
        ylabel('Angular Acceleration');
        title(['Angular Acceleration for dT = ' num2str(dT_current) 'Solver = ' solver_current]);

    end
end
