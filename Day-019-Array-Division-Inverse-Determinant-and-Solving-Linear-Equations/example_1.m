% Day 019 · Array Division: Inverse, Determinant and Solving Linear Equations — Solving three equations with three unknowns
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

A = [4 -2 6; 2 8 2; 6 10 3];
b = [8; 4; 0];
x = A \ b                     % left division
x_inv = inv(A) * b            % same answer
check = A * x - b             % should be (almost) zero
det(A)
