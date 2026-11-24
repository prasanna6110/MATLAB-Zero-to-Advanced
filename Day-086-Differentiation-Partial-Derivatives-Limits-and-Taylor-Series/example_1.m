% Day 086 · Differentiation, Partial Derivatives, Limits and Taylor Series — Derivatives
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x t
diff(x^3 + 2*x^2 - 5)
diff(sin(x)*x^2)
diff(exp(-2*t)*cos(5*t), t)
diff(x^5, 3)                       % third derivative
f = x^3 - 6*x^2 + 9*x + 1;
crit = solve(diff(f) == 0, x)      % turning points
d2 = subs(diff(f, 2), x, crit)     % positive -> minimum, negative -> maximum
