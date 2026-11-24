% Day 008 · Creating Vectors: Row, Column, Colon and linspace — linspace and logspace
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

x = linspace(0, 10, 6)                  % 6 points, both ends included
angles = linspace(0, 2*pi, 5)
f = logspace(1, 4, 4)                   % 10 100 1000 10000 Hz
n = length(linspace(-1, 1))             % default is 100 points
