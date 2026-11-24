% Day 026 · The Workspace and Input to a Script File — Inputs assigned in the script
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Change these numbers and run again
principal = 100000;     % Rs
rate = 8.5;             % % per year
years = 10;
amount = principal * (1 + rate/100)^years;
fprintf('After %d years, Rs %d grows to Rs %.2f\n', years, principal, amount);
