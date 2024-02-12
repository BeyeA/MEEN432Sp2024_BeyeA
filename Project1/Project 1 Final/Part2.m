% Initial Conditions

J1 = 100 ; % Rotational Inertia [kg-m^2]
J2 = 1; % Rotational Inertia [kg-m^2]
b1 = 1; % Damping Coefficient [N-m-s/rad]
b2 = 1; % Damping Coefficient [N-m-s/rad]
A = [1, 100]; % Constant Applied Torque [N-m]
k = [10,100,1000]; %Stiffness element
dT = [0.1, 1]; % Time Step [s]

solver = ["ode1", "ode4","ode45"]; % Solvers [Euler]

combo = combinations(J1,J2,b1,b2,A,k,dT,solver);
CPUCol_Option1 = zeros(height(combo),1);
CPUCol_Option2 = zeros(height(combo),1);
CPUCol_Option3 = zeros(height(combo),1);

count = 1;


for i = 1:length(k)
    k_current = k(i);

    for j = 1:length(solver)
        solver_current = solver(j);

        for x = 1:length(A)
            A_current = A(x);

            for y = 1:length(dT)
                dT_current = dT(y);
                
                if solver_current == "ode1" | solver_current == "ode4" 

                %Option 1
                simout = sim("Option_1.slx", "Solver", solver_current, "FixedStep", string(dT_current));
                W1 = simout.w1.Data;
                W2 = simout.w2.Data;
                T = simout.tout;
                Time_Cpu = cputime;
                CPUCol_Option1(count,1) = Time_Cpu; 
                
                figure; % Create a new figure for each simulation
                subplot(2, 2, 1);
                plot(T,W1,T,W2);
                xlabel('Time (s)');
                ylabel('Angular Velocity (rad/s)');
                title({ ...
                    ['Option 1: Angular Velocity for dT = ' num2str(dT_current)] ...
                    ['J1 = ' num2str(J1) ' J2 = ' num2str(J2) ' b1 = ' num2str(b1) ' b2 = ' num2str(b2)] ...
                    ['A = ' num2str(A_current) ' k = ' num2str(k_current)] ...
                    ['Solver = ' num2str(solver_current)] ...
                    });
                legend('w1', 'w2');

                %Option 2
                simout = sim("Option_2.slx", "Solver", solver_current, "FixedStep", string(dT_current));
                W = simout.w.Data;
                T = simout.tout;
                Time_Cpu = cputime;
                CPUCol_Option2(count,1) = Time_Cpu; 

                subplot(2, 2, 2);
                plot(T,W);
                xlabel('Time (s)');
                ylabel('Angular Velocity (rad/s)');
                title({ ...
                    ['Option 2: Angular Velocity for dT = ' num2str(dT_current)] ...
                    ['J1 = ' num2str(J1) ' J2 = ' num2str(J2) ' b1 = ' num2str(b1) ' b2 = ' num2str(b2)] ...
                    ['A = ' num2str(A_current)] ...
                    ['Solver = ' num2str(solver_current)] ...
                    });
               legend('w');

               %Option 3
                simout = sim("Option_3.slx", "Solver", solver_current, "FixedStep", string(dT_current));
                W = simout.w.Data;
                T = simout.tout;
                Time_Cpu = cputime;
                CPUCol_Option3(count,1) = Time_Cpu; 

                subplot(2, 2, 3);
                plot(T,W);
                xlabel('Time (s)');
                ylabel('Angular Velocity (rad/s)');
                title({ ...
                    ['Option 3: Angular Velocity for dT = ' num2str(dT_current)] ...
                    ['J1 = ' num2str(J1) ' J2 = ' num2str(J2) ' b1 = ' num2str(b1) ' b2 = ' num2str(b2)] ...
                    ['A = ' num2str(A_current)] ...
                    ['Solver = ' num2str(solver_current)] ...
                    });

               legend('w');

                else 

                %Option 1
                simout = sim("Option_1.slx", "Solver", solver_current);
                W1 = simout.w1.Data;
                W2 = simout.w2.Data;
                T = simout.tout;
                Time_Cpu = cputime;
                CPUCol_Option1(count,1) = Time_Cpu; 
                

                subplot(2, 2, 1);
                plot(T,W1,T,W2);
                xlabel('Time (s)');
                ylabel('Angular Velocity (rad/s)');
                title({ ...
                    ['Option 1: Angular Velocity for variable time step'] ...
                    ['J1 = ' num2str(J1) ' J2 = ' num2str(J2) ' b1 = ' num2str(b1) ' b2 = ' num2str(b2)] ...
                    ['A = ' num2str(A_current) ' k = ' num2str(k_current)] ...
                    ['Solver = ' num2str(solver_current)] ...
                    });
                legend('w1', 'w2');
                
                %Option 2
                simout = sim("Option_2.slx", "Solver", solver_current);
                W = simout.w.Data;
                T = simout.tout;
                Time_Cpu = cputime;
                CPUCol_Option2(count,1) = Time_Cpu; 

                subplot(2, 2, 2);
                plot(T,W);
                xlabel('Time (s)');
                ylabel('Angular Velocity (rad/s)');
                title({ ...
                    ['Option 2: Angular Velocity for varaible time step'] ...
                    ['J1 = ' num2str(J1) ' J2 = ' num2str(J2) ' b1 = ' num2str(b1) ' b2 = ' num2str(b2)] ...
                    ['A = ' num2str(A_current)] ...
                    ['Solver = ' num2str(solver_current)] ...
                    });
               legend('w');


                simout = sim("Option_3.slx", "Solver", solver_current);
                W = simout.w.Data;
                T = simout.tout;
                Time_Cpu = cputime;
                CPUCol_Option3(count,1) = Time_Cpu; 

                subplot(2, 2, 3);
                plot(T,W);
                xlabel('Time (s)');
                ylabel('Angular Velocity (rad/s)');
                title({ ...
                    ['Option 3: Angular Velocity for variable time step'] ...
                    ['J1 = ' num2str(J1) ' J2 = ' num2str(J2) ' b1 = ' num2str(b1) ' b2 = ' num2str(b2)] ...
                    ['A = ' num2str(A_current)] ...
                    ['Solver = ' num2str(solver_current)] ...
                    });

               
               end

             count = count + 1;


            end
        end 
    end
 end
 
combo.("CPU_Time_Option_1") = CPUCol_Option1;
combo.("CPU_Time_Option_2") = CPUCol_Option2;
combo.("CPU_Time_Option_3") = CPUCol_Option3;


%Table of CPU times. To view CPU times with varibales check combo table. 
CPU_Time_Table = table(CPUCol_Option1, CPUCol_Option2, CPUCol_Option3);
