% Day 087 · Symbolic Integration: int — Area between curves and a double integral
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x y
f = x + 2;  g = x^2;
xs = solve(f == g, x)                         % intersection points
A = int(f - g, x, min(xs), max(xs))           % area between the curves
double(A)
V = int(int(x*y, y, 0, x), x, 0, 1)           % double integral over a triangle
