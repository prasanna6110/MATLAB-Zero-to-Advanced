% Day 054 · Anonymous Functions — Captured variables
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

a = 2; b = 3;
line_fn = @(x) a*x + b;
line_fn(10)                        % 23
a = 100;                           % change a afterwards...
line_fn(10)                        % ...still 23: a = 2 was captured
line_fn = @(x) a*x + b;            % re-create it to use the new a
line_fn(10)                        % 1003
