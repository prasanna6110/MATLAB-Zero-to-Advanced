% Day 089 · Plotting Symbolic Expressions and Numerical Calculations — subs, double and vpa
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x y
E = x^2*y + sqrt(x + y);
subs(E, x, 3)                           % still has y
v = subs(E, [x y], [3 1])               % exact: 9 + 2
double(v)
vpa(sym(pi)*sqrt(sym(2)), 25)
r = vpasolve(x^5 - x - 1 == 0, x, 1)   % no closed form: solve numerically near 1
double(r)
