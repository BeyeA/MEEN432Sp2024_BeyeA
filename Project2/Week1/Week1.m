% Define parameters
radius = 200; % Radius of curved sections
straight_length = 900; % Length of straight sections
track_width = 15; % Width of the track

% First Curve
theta1 = linspace(3*pi/2, pi/2, 100);
x1 = radius * cos(theta1);
y1 = radius * sin(theta1);

% Second Curve
theta2 = linspace(-pi/2, -3*pi/2, 100);
x2 = -radius * cos(theta2) + straight_length;
y2 = -radius * sin(theta2);

% First Straight
x3 = linspace(0, straight_length, 100);
y3 = -200 * ones(size(x3));

% Second Straight
x4 = linspace(straight_length, 0, 100);
y4 = 200 * ones(size(x4));

% Combine
xpath = [x3, fliplr(x2), (x4), fliplr(x1)];
ypath = [y3, fliplr(y2), (y4), fliplr(y1)];
xpath = xpath - xpath(1);
ypath = ypath - ypath(1);

plot(xpath, ypath, '.r');

hold on

x_min = -400;
x_max = 1300;

y_min = -400;
y_max = 800;

% Plot the green background
patch([x_min, x_max, x_max, x_min], [y_min, y_min, y_max, y_max], [0.5 0.8 0.5], 'EdgeColor', 'none');

% Plot the track in grey
plot(xpath, ypath, 'Color', [0.5 0.5 0.5], 'LineWidth', track_width);
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
w = 20;
car = [- w*2, - w; w*2, -w; w*2, w; -w*2, w]';
a = patch('XData', car(:, 1), 'YData', car(:, 2));
a.EdgeColor = [0 0 0];
a.FaceColor = 'b';

% perform an animated "simulation" - no dynamics, just kinematics
for i = 1:length(xpath)-1
    x = xpath(i);
    y = ypath(i);
   
    addpoints(h, x, y);

    % Calculate slope of the curve at current point
    slope = (ypath(i+1) - ypath(i)) / (xpath(i+1) - xpath(i));
    
    % Rotate car according to slope of curve 
    angle = atan(slope);
    car_centered = car - mean(car, 2);
    car_rotated = rotate(car_centered, angle);
    car_final = car_rotated + [x; y];
    
    % Update car image
    a.XData = car_final(1, :);
    a.YData = car_final(2, :);
    
    pause(0.05);
    
    drawnow limitrate nocallbacks
end

hold off

function xyt = rotate(xy, theta)
    R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    xyt = R * xy;
end

