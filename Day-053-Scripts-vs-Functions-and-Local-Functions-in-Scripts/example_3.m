% Day 053 · Scripts vs Functions, and Local Functions in Scripts — Which file runs? which and exist
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

which sin
which mean
fprintf('exist sin: %d (5 = built-in, 2 = file)\n', exist('sin'));
fprintf('exist mean: %d\n', exist('mean'));
mean = 7;                        % a variable now hides the function
fprintf('exist mean after "mean = 7": %d (1 = variable)\n', exist('mean'));
clear mean
fprintf('mean([2 4 6]) works again: %g\n', mean([2 4 6]));
