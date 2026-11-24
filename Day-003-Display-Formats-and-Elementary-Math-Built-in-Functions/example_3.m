% Day 003 · Display Formats and Elementary Math Built-in Functions — Trigonometry in radians and degrees
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

angle_deg = 60;
s1 = sin(angle_deg * pi / 180)   % convert to radians yourself
s2 = sind(angle_deg)             % or use the degree version
theta = atan2d(3, 4)             % angle of the point (4,3) in degrees
% Power factor angle from P and Q
P = 800; Q = 600;
phi = atand(Q / P)               % degrees
pf = cosd(phi)                   % power factor = 0.8
