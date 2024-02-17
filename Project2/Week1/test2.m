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
x = [x3, fliplr(x2), (x4), fliplr(x1)];
y = [y3, fliplr(y2), (y4), fliplr(y1)];
x = x - x(1);
y = y - y(1);

figure;
hold on

x_min = -400;
x_max = 1300;

y_min = -400;
y_max = 800;

% Plot the green background
patch([x_min, x_max, x_max, x_min], [y_min, y_min, y_max, y_max], [0.5 0.8 0.5], 'EdgeColor', 'none');

% Plot the track in grey
plot(x, y, 'Color', [0.5 0.5 0.5], 'LineWidth', track_width);
axis equal;
title('Racetrack');
xlabel('X');
ylabel('Y');
grid on;

% Set x and y limits
xlim([-400, 1300]);
ylim([-400, 800]);

% Create a patch for the vehicle (rectangle with width 10 and length 20)
car_width = 20;
car_length = 10;
car_x = [-car_width/2, car_width/2, car_width/2, -car_width/2];
car_y = [-car_length/2, -car_length/2, car_length/2, car_length/2];
h_car = patch('XData', car_x, 'YData', car_y, 'EdgeColor', [0 0 0], 'FaceColor', 'none');

% Create an animated line for the vehicle's path
h_path = animatedline('Color', 'r', 'LineWidth', 1);

% Animate the vehicle following waypoints
for i = 1:length(x)
    x_vehicle = x(i);
    y_vehicle = y(i);
   
    % Update vehicle's path
    addpoints(h_path, x_vehicle, y_vehicle);
    
    % Calculate tangent angle
    if i <= length(x3) || i > length(x3) + length(x2) + length(x4)
        tangent_angle = 0; % No rotation needed for straight sections
    elseif i > length(x3) && i <= length(x3) + length(x2)
        % First curve
        slope = -1 / ((x2(end) - x2(1)) / (y2(end) - y2(1))); % Calculate slope of tangent
        tangent_angle = atan(slope); % Calculate tangent angle
    else
        % Second curve
        slope = -1 / ((x1(end) - x1(1)) / (y1(end) - y1(1))); % Calculate slope of tangent
        tangent_angle = atan(slope); % Calculate tangent angle
    end
    
    % Update vehicle patch position with rotation
    car_rotated = rotate([car_x; car_y], tangent_angle); % Rotate car
    h_car.XData = car_rotated(1,:) + x_vehicle;
    h_car.YData = car_rotated(2,:) + y_vehicle;
    
    % Pause to control animation speed
    pause(0.05);
    
    % Force drawing to update the plot
    drawnow;
end

hold off

% Rotation function
function xy_rotated = rotate(xy, theta)
    % Rotation matrix
    R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    % Rotate xy
    xy_rotated = R * xy;
end
