% Day 084 · Changing the Form of an Expression: expand, factor, collect, simplify, pretty — expand and factor
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x y a
expand((x + 2)^3)
expand((x - y)*(x + y))
expand(sin(x + y))                 % trig identity
expand(exp(a + x))
factor(x^2 - 5*x + 6)
factor(x^3 - 8)
factor(sym(360))                   % prime factors of a number
