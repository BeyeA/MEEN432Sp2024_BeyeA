% Initial Conditions

w_0 = [10, 0]; % Initial Angular Velocity [rad/s]
J = [100, 0.1]; % Rotational Inertia [kg-m^2]
b = [10, 0.1]; % Damping Coefficient [N-m-s/rad]
A = [0, 100]; % Constant Applied Torque [N-m]
freq = [0.1, 100]; % Freq
dT = [0.001, 0.1, 1]; % Time Step [s]

solver = ["ode1", "ode4",]; % Fixed Time Step Solver [Euler]
variable_solver = ["ode45", "ode23tb"]; %Variable Time Step Solver 

combo = combinations(w_0,J,b,A,freq,dT,solver);
combo_variable = combinations(w_0,J,b,A,freq,variable_solver);

newErrorCol = zeros(height(combo),1);
newCPUCol = zeros(height(combo),1);

newErrorCol_V = zeros(height(combo_variable),1);
newCPUCol_V = zeros(height(combo_variable),1);

x = 1;
y = x+2;
 
x1 = 1;
y1 = x1+2;

%Fixed Time Step
%for i = 1:size(combo,1)

for i = 1:6
    current_values = combo(i,:);
    w_0_current = current_values.(1);
    J_current = current_values.(2);
    b_current = current_values.(3);
    A_current = current_values.(4);
    freq_current = current_values.(5);
    dT_current = current_values.(6);
    solver_current = current_values.(7);

    simout = sim("Week2.slx", "Solver", solver_current, "FixedStep", string(dT_current));
    W = simout.w.Data;
    W_DOT = simout.w_dot.Data;
    T = simout.tout;

    Time_Cpu = cputime;
    
    Theoretical_Rotational = zeros(length(T),1);

        for j = 1:size(T)
            TR_Current = (A_current/b_current)*(1-exp((-b_current/J_current)*T(j,1)))+w_0_current*exp(((-b_current/J_current)*T(j,1)));
            Theoretical_Rotational(1:j) = TR_Current;
            Error = W_DOT(1:j) - Theoretical_Rotational(1:j);
        end

    Time_Cpu = cputime;
    Max_Error = max(Error);

    newErrorCol(i,1) = Max_Error;
    newCPUCol(i,1) = Time_Cpu; 

    combo.("Max_Error") = newErrorCol;
    combo.("CPU_Time") = newCPUCol;
end 

for i = 1:6
    current_values = combo(i,:);
    w_0_current = current_values.(1);
    J_current = current_values.(2);
    b_current = current_values.(3);
    A_current = current_values.(4);
    freq_current = current_values.(5);
    dT_current = current_values.(6);
    solver_current = current_values.(7);

    simout = sim("Week2.slx", "Solver", solver_current, "FixedStep", string(dT_current));
    W = simout.w.Data;
    W_DOT = simout.w_dot.Data;
    T = simout.tout;

    ode1 = combo.solver == "ode1";
    ode1_values = combo(ode1,:); 
    
    ode4 = combo.solver == "ode4";
    ode4_values = combo(ode4,:);  
   
    if solver_current == "ode1"
        while x < 4
            % Create a new figure for each simulation
            figure; 
            subplot(3, 2, 1);
            plot(T, W);
            xlabel('Time (s)');
            ylabel('Angular Velocity');
            title({ ...
            ['Angular Velocity for dT = ' num2str(dT_current)]
            ['Solver = ' num2str(solver_current)]
            ['w0 = ' num2str(w_0_current) ' J = ' num2str(J_current) ' b = ' num2str(b_current)]
            ['A = ' num2str(A_current) ' Freq =' num2str(freq_current)]
            });
            
            subplot(3, 2, 2);
            plot(T, W_DOT);
            xlabel('Time (s)');
            ylabel('Angular Acceleration');
            title({ ...
            ['Angular Acceleration for dT = ' num2str(dT_current)]
            ['Solver = ' num2str(solver_current)]
            ['w0 = ' num2str(w_0_current) ' J = ' num2str(J_current) ' b = ' num2str(b_current)]
            ['A = ' num2str(A_current) ' Freq =' num2str(freq_current)]
            });  

            plot_array = ode1_values{x:y,["dT","Max_Error", "CPU_Time"]};
            subplot(3, 2, 3);
            plot(plot_array(:,1), plot_array(:,2));
            xlabel('Time Step (s)');
            ylabel('Max Simulation Error');
            title({ ...
            ["Max Simulation Error vs. Time Step for Ode1"]
            });  
            
            subplot(3, 2, 4);
            plot(plot_array(:,1), plot_array(:,3));
            xlabel('Time Step (s)');
            ylabel('CPU Time');
            title({ ...
            ["CPU Time vs. Time Step for Ode1"]
            }); 
            
            subplot(3, 2, 5);
            plot(plot_array(:,3), plot_array(:,2));
            xlabel('CPU Time (s)');
            ylabel('Max Simulation Error');
            title({ ...
            ["Max Simulation Error vs CPU Time for Ode1"]
            }); 

            x = x+3;
            y = x+2;
        end

    else 
        while x1 < 4
            figure; 
            subplot(3, 2, 1);
            plot(T, W);
            xlabel('Time (s)');
            ylabel('Angular Velocity');
            title({ ...
            ['Angular Velocity for dT = ' num2str(dT_current)]
            ['Solver = ' num2str(solver_current)]
            ['w0 = ' num2str(w_0_current) ' J = ' num2str(J_current) ' b = ' num2str(b_current)]
            ['A = ' num2str(A_current) ' Freq =' num2str(freq_current)]
            });
            
            subplot(3, 2, 2);
            plot(T, W_DOT);
            xlabel('Time (s)');
            ylabel('Angular Acceleration');
            title({ ...
            ['Angular Acceleration for dT = ' num2str(dT_current)]
            ['Solver = ' num2str(solver_current)]
            ['w0 = ' num2str(w_0_current) ' J = ' num2str(J_current) ' b = ' num2str(b_current)]
            ['A = ' num2str(A_current) ' Freq =' num2str(freq_current)]
            });  

            plot_array = ode4_values{x1:y1,["dT","Max_Error", "CPU_Time"]};
            x1 = x1+3;
            y1 = x1+2;
            
            subplot(3, 2, 3);
            plot(plot_array(:,1), plot_array(:,2));
            xlabel('Time Step (s)');
            ylabel('Max Simulation Error');
            title({ ...
            ["Max Simulation Error vs. Time Step for Ode4"]
            });  
            
            subplot(3, 2, 4);
            plot(plot_array(:,1), plot_array(:,3));
            xlabel('Time Step (s)');
            ylabel('CPU Time');
            title({ ...
            ["CPU Time vs. Time Step for Ode4"]
            }); 
            
            subplot(3, 2, 5);
            plot(plot_array(:,3), plot_array(:,2));
            xlabel('CPU Time (s)');
            ylabel('Max Simulation Error');
            title({ ...
            ["Max Simulation Error vs CPU Time for Ode4"]
            }); 
        end
    end
end
%}


%Variable Time Step
for i = 1:2
    current_values = combo_variable(i,:);
    w_0_current = current_values.(1);
    J_current = current_values.(2);
    b_current = current_values.(3);
    A_current = current_values.(4);
    freq_current = current_values.(5);   
    solver_current = current_values.(6);


    simout = sim("Week2.slx", "Solver", solver_current);
    W = simout.w.Data;
    W_DOT = simout.w_dot.Data;
    T = simout.tout;
   
    
    %Solution from Runge Kutta 4th order, DT=0.001
    solver_compare = "ode4";
    dt_current = 0.001;
    simout = sim("Week2.slx", "Solver", solver_compare, "FixedStep", string(dt_current));
    W_compare = simout.w.Data;
    W_DOT_compare = simout.w_dot.Data;
    T_compare = simout.tout;

    Theoretical_Rotational = zeros(length(T),1);
    Error = zeros(length(T),1);

    for j = 1:size(T)
        TR_Current = (A_current/b_current)*(1-exp((-b_current/J_current)*T(j,1)))+w_0_current*exp(((-b_current/J_current)*T(j,1)));
        Theoretical_Rotational(1:j) = TR_Current;
        Error = W_DOT_compare(1:j) - Theoretical_Rotational(1:j);
    end

    Time_Cpu = cputime;
    Max_Error = max(Error);

    newErrorCol_V(i,1) = Max_Error;
    newCPUCol_V(i,1) = Time_Cpu;

    combo_variable.("Max Error") = newErrorCol_V;
    combo_variable.("CPU Time") = newCPUCol_V;
end


   for i = 1:2
    current_values = combo_variable(i,:);
    w_0_current = current_values.(1);
    J_current = current_values.(2);
    b_current = current_values.(3);
    A_current = current_values.(4);
    freq_current = current_values.(5);   
    solver_current = current_values.(6);


    simout = sim("Week2.slx", "Solver", solver_current);
    W = simout.w.Data;
    W_DOT = simout.w_dot.Data;
    T = simout.tout;

    ode45 = combo_variable.variable_solver == "ode45";
    ode45_values = combo_variable(ode45,:); 
    
    ode23tb = combo_variable.variable_solver == "ode23tb";
    ode23tb_values = combo_variable(ode23tb,:);  
   
    if solver_current == "ode45"
            % Create a new figure for each simulation
            figure; 
            subplot(2, 2, 1);
            plot(T, W);
            xlabel('Time (s)');
            ylabel('Angular Velocity');
            title({ ...
            ['Angular Velocity for Variable Time Step']
            ['Solver = ' num2str(solver_current)]
            ['w0 = ' num2str(w_0_current) ' J = ' num2str(J_current) ' b = ' num2str(b_current)]
            ['A = ' num2str(A_current) ' Freq =' num2str(freq_current)]
            });
            
            subplot(2, 2, 2);
            plot(T, W_DOT);
            xlabel('Time (s)');
            ylabel('Angular Acceleration');
            title({ ...
            ['Angular Velocity for Variable Time Step']
            ['Solver = ' num2str(solver_current)]
            ['w0 = ' num2str(w_0_current) ' J = ' num2str(J_current) ' b = ' num2str(b_current)]
            ['A = ' num2str(A_current) ' Freq =' num2str(freq_current)]
            }); 
            
            subplot(2, 2, 3);
            plot(ode45_values,"CPU Time","Max Error");
            xlabel('CPU Time (s)');
            ylabel('Max Simulation Error');
            title({ ...
            ["Max Simulation Error vs CPU Time for Ode45"]
            }); 

    else 
            figure; 
            subplot(2, 2, 1);
            plot(T, W);
            xlabel('Time (s)');
            ylabel('Angular Velocity');
            title({ ...
            ['Angular Velocity for dT = ' num2str(dT_current)]
            ['Solver = ' num2str(solver_current)]
            ['w0 = ' num2str(w_0_current) ' J = ' num2str(J_current) ' b = ' num2str(b_current)]
            ['A = ' num2str(A_current) ' Freq =' num2str(freq_current)]
            });
            
            subplot(2, 2, 2);
            plot(T, W_DOT);
            xlabel('Time (s)');
            ylabel('Angular Acceleration');
            title({ ...
            ['Angular Acceleration for dT = ' num2str(dT_current)]
            ['Solver = ' num2str(solver_current)]
            ['w0 = ' num2str(w_0_current) ' J = ' num2str(J_current) ' b = ' num2str(b_current)]
            ['A = ' num2str(A_current) ' Freq =' num2str(freq_current)]
            });  

            plot_array = ode4_values{x1:y1,["dT","Max_Error", "CPU_Time"]};
            
            subplot(4, 2, 5);
            plot(ode23tb_values,"CPU Time","Max Error");
            xlabel('CPU Time (s)');
            ylabel('Max Simulation Error');
            title({ ...
            ["Max Simulation Error vs CPU Time for Ode23tb"]
            }); 
    end
   end 
