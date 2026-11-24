% Day 084 · Changing the Form of an Expression: expand, factor, collect, simplify, pretty — simplify, pretty and latex
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x
simplify(sin(x)^2 + cos(x)^2)
simplify((x^2 - 1)/(x - 1))
simplify(cos(x)^4 - sin(x)^4)
S = (x^2 + 3*x)/(x^3 - x);
pretty(S)
pretty(simplify(S))
latex(x^2/(1 + sqrt(x)))
syms p positive
simplify(sqrt(p^2))                % = p, because p > 0
