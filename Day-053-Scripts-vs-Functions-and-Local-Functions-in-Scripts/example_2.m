% Day 053 · Scripts vs Functions, and Local Functions in Scripts — The same task as a script and as a function
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Script style: works on whatever is in the workspace
R = [10 20 30];
R_series = sum(R);
R_parallel = 1 / sum(1 ./ R);
fprintf('Script:   series %.2f, parallel %.3f\n', R_series, R_parallel);
% Function style: inputs in, outputs out
[s, p] = resistor_combo([10 20 30]);
fprintf('Function: series %.2f, parallel %.3f\n', s, p);
[s2, p2] = resistor_combo([4.7 4.7]);
fprintf('Function: series %.2f, parallel %.3f\n', s2, p2);

function [Rs, Rp] = resistor_combo(R)
    Rs = sum(R);
    Rp = 1 / sum(1 ./ R);
end
