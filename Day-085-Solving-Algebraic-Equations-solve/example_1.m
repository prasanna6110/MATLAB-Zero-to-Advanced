% Day 085 · Solving Algebraic Equations: solve — Solving single equations
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x a b c
solve(x^2 - 5*x + 6 == 0, x)
solve(a*x^2 + b*x + c == 0, x)          % the quadratic formula
r = solve(x^3 + x - 1 == 0, x);         % roots that have no nice form
double(r)
solve(exp(2*x) == 7, x)
solve(sin(x) == 1/2, x)                 % the principal solution
