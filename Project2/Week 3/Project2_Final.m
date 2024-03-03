% Define parameters
radius = 200; % Radius of curved sections
straight_length = 900; % Length of straight sections
track_width = 15; % Width of the track

path = struct();
path.width = track_width;
path.l_st = straight_length;
path.radius = radius;

simout = sim("p2_demo.slx");
X = simout.X.Data;
Y = simout.Y.Data;
t = simout.tout;

RACE = raceStat(X,Y,t,path);

step = 0.05;

plot(X, Y, '.r');

hold on

x_min = -400;
x_max = 1300;

y_min = -400;
y_max = 800;

% Plot the green background
patch([x_min, x_max, x_max, x_min], [y_min, y_min, y_max, y_max], [0.5 0.8 0.5], 'EdgeColor', 'none');

% Plot the track in grey
plot(X, Y, 'Color', [0.5 0.5 0.5], 'LineWidth', track_width);
axis equal;
title('Racetrack');
xlabel('X');
ylabel('Y');
grid on;

% Set x and y limits
xlim([-400, 1300]);
ylim([-400, 800]);

% start an animated line feature
h = animatedline('Color', 'r', 'LineWidth', 1);
axis([-400 1300 -400 800])

% create a "car" of width w and height 2w
w = 10;
car = [- w*2, - w; w*2, -w; w*2, w; -w*2, w]';
a = patch('XData', car(:, 1), 'YData', car(:, 2));
a.EdgeColor = [0 0 0];
a.FaceColor = 'b';

% perform an animated "simulation" - no dynamics, just kinematics
for i = 1:length(X)-1
    x = X(i);
    y = Y(i);
   
    addpoints(h, x, y);

    % Calculate slope of the curve at current point
    slope = (Y(i+1) - Y(i)) / (X(i+1) - X(i));
    
    % Rotate car according to slope of curve 
    angle = atan(slope);
    car_centered = car - mean(car, 2);
    car_rotated = rotate(car_centered, angle);
    car_final = car_rotated + [x; y];
    
    % Update car image
    a.XData = car_final(1, :);
    a.YData = car_final(2, :);
    
    pause(step);
    
    drawnow limitrate nocallbacks
end

hold off


function xyt = rotate(xy, theta)
    R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    xyt = R * xy;
end
