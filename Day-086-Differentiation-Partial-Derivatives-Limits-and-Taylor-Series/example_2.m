% Day 086 · Differentiation, Partial Derivatives, Limits and Taylor Series — Partial derivatives and the Jacobian
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x y
g = x^2*y^3 + sin(x*y);
gx = diff(g, x)
gy = diff(g, y)
gxy = diff(diff(g, x), y)
gyx = diff(diff(g, y), x);
simplify(gxy - gyx)                % mixed partials are equal
F = [x^2 + y^2 - 4; exp(x) + y - 1];
J = jacobian(F, [x y])             % used by Newton-Raphson (Day 76)
