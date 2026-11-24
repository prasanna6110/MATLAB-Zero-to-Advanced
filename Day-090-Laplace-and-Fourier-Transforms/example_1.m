% Day 090 · Laplace and Fourier Transforms — Laplace and inverse Laplace transforms
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Symbolic Math Toolbox
syms t s a w positive
laplace(sym(1), t, s)
laplace(exp(-a*t), t, s)
laplace(sin(w*t), t, s)
laplace(t^2*exp(-3*t), t, s)
ilaplace(1/(s*(s + 2)), s, t)
ilaplace((s + 3)/(s^2 + 4*s + 13), s, t)
