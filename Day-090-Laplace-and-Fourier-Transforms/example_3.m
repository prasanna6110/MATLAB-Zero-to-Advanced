% Day 090 · Laplace and Fourier Transforms — Solving an ODE with the Laplace transform
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Needs: Symbolic Math Toolbox
% y'' + 3y' + 2y = 4,  y(0) = 0, y'(0) = 0
syms s t Y
eq = s^2*Y + 3*s*Y + 2*Y == 4/s;     % the transformed equation (zero initial conditions)
Ys = solve(eq, Y)
y_t = ilaplace(Ys, s, t)
check = double(subs(y_t, t, 10))     % approaches the steady value 2
