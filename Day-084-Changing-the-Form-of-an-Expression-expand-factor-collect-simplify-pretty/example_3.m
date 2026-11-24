% Day 084 · Changing the Form of an Expression: expand, factor, collect, simplify, pretty — collect and partfrac
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% MATLAB-ONLY: collect and partfrac are not in GNU Octave's symbolic package
syms x y s
collect((x + y)^2*(x - 1), x)
collect((x + y)^2*(x - 1), y)
F = (2*s + 3)/(s^2 + 3*s + 2);
partfrac(F, s)
[n, d] = numden(F)
