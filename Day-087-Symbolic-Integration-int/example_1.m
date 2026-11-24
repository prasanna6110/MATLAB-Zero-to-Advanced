% Day 087 · Symbolic Integration: int — Indefinite and definite integrals
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x t a
int(x^2 + 3*x)
int(x*exp(x))                      % integration by parts
int(1/(1 + x^2))
int(cos(a*t), t)
int(x^2, 0, 2)
int(x^2, 0, a)                     % a symbolic limit
int(exp(-x), 0, Inf)               % improper
int(exp(-x^2), -Inf, Inf)          % sqrt(pi)
