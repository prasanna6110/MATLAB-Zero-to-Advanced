% Day 083 · Symbolic Objects and Symbolic Expressions — Symbolic variables and expressions
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x y a b
E = a*x^2 + b*x + 5
F = (x + y)^2
G = E * F;
symvar(G)                   % all the variables, alphabetically
symvar(E, 1)                % the default variable (closest to x)
syms R L C w real
Z = R + 1i*w*L + 1/(1i*w*C)  % an impedance as a formula
