% Day 021 · Using Arrays in Built-in Math Functions (Vectorisation) — A full table of values in one line each
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

theta = 0:15:90;
table = [theta; sind(theta); cosd(theta); tand(theta)]';
fprintf(' angle    sin      cos      tan\n');
fprintf('%5d %8.4f %8.4f %10.4f\n', table');
