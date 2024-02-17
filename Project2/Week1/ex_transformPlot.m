
% create a sinusoidal reference path
xpath = linspace(0,4*pi,100);
ypath = sin(xpath);
plot(xpath,ypath,'.r');

hold on
%%
% 
%  PREFORMATTED
%  TEXT
% 

% start an animated line feature
h = animatedline;
axis([0 4*pi -1 1])

% create a "car" of width w and height 2w
w = 0.2;
car = [- w/2, - w; w/2, -w; w/2, w; -w/2, w]';
a = patch('XData',car(:,1),'YData',car(:,2));
a.EdgeColor = [0 0 0];
a.FaceColor = 'none';

% perform an animated "simulation" - no dynamics, just kinematics
for x = linspace(0,4*pi,80000)
    y = sin(x);
    addpoints(h,x,y)

    %generate un-rotated car at new location x,y
    car = [x - w/2, y - w; x + w/2, y-w; x+w/2, y+w; x-w/2, y+w];

    % rotate car according to slope of curve 
    car2 = rotate(car'-[x;y], pi/2 - cos(x))' + [x;y]';

    %update car image
    a.XData = car2(:,1);
    a.YData = car2(:,2);
    drawnow limitrate nocallbacks
end

hold off