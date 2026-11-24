% Day 079 · Mesh and Surface Plots: meshgrid, mesh and surf — What meshgrid really makes
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

[X, Y] = meshgrid(1:4, 10:10:30)
Z = X + Y                         % the value at every combination
% The same with implicit expansion (no meshgrid needed for calculation):
Z2 = (1:4) + (10:10:30)'
