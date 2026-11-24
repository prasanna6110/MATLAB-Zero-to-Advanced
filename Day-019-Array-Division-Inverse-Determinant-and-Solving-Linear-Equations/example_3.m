% Day 019 · Array Division: Inverse, Determinant and Solving Linear Equations — Singular matrices and least squares
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

S = [1 2; 2 4];               % row 2 = 2 * row 1
det(S)                        % 0 -> singular
rank(S)                       % only 1 independent row
% More equations than unknowns (an overdetermined system):
% fit y = a + b*x through 4 noisy points in the least-squares sense
x = [0; 1; 2; 3];
y = [1.1; 2.9; 5.2; 6.8];
A = [ones(4, 1) x];
coeffs = A \ y                % best a and b
% Right division: solve x*M = c
M = [2 1; 1 3];
c = [5 10];
xr = c / M
xr * M                        % gives back c
