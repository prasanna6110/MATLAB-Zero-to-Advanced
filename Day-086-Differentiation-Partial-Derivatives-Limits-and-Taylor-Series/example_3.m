% Day 086 · Differentiation, Partial Derivatives, Limits and Taylor Series — Limits and Taylor series
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x n
limit(sin(x)/x, x, 0)
limit((1 + 1/n)^n, n, Inf)         % e
limit(1/x, x, 0, 'right')
limit(1/x, x, 0, 'left')
T = taylor(exp(x), x, 0, 'Order', 5)
T_sin = taylor(sin(x), x, 0, 'Order', 8)
err = double(subs(sin(x) - T_sin, x, 0.5))
