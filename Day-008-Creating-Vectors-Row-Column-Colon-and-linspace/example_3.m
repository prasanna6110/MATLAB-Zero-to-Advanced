% Day 008 · Creating Vectors: Row, Column, Colon and linspace — Vectors built from formulas
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

t = 0:0.001:0.02;                       % one 50 Hz cycle, 1 ms steps
fprintf('%d samples\n', length(t));
v = 325 * sin(2*pi*50*t);               % instantaneous voltage
fprintf('First five samples: %s\n', mat2str(v(1:5), 4));
% A vector of the squares of 1..10 (element-wise power, Day 20)
squares = (1:10).^2
