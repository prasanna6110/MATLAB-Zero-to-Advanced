% Day 007 · Getting Help, Reading Errors and MATLAB Applications — Application: the projectile range formula
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

v0 = 25;                      % launch speed m/s
theta = 40;                   % launch angle in degrees
g = 9.81;
range = v0^2 * sind(2 * theta) / g;
h_max = (v0 * sind(theta))^2 / (2 * g);
t_flight = 2 * v0 * sind(theta) / g;
fprintf('Range %.2f m, max height %.2f m, flight time %.2f s\n', range, h_max, t_flight);
