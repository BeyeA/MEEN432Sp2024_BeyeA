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

