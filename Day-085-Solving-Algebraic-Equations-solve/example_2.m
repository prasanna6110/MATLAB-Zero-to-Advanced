% Day 085 · Solving Algebraic Equations: solve — Systems of equations
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x y z
[sx, sy] = solve(x + y == 10, x - y == 2, x, y)
[px, py] = solve(x^2 + y^2 == 25, x + y == 7, x, y)      % two solutions
[I1, I2, I3] = solve(6*x - 4*y == 12, -4*x + 13*y - 3*z == 0, -3*y + 8*z == -6, x, y, z);
fprintf('Mesh currents: %s A\n', mat2str(double([I1 I2 I3]), 5));
