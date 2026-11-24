% Day 088 · Solving Ordinary Differential Equations Symbolically: dsolve — First-order ODEs
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Symbolic Math Toolbox
syms y(t)
dsolve(diff(y, t) == -2*y)                       % general solution
dsolve(diff(y, t) == -2*y + 4, y(0) == 1)        % with an initial value
syms v(t) R C Vs
vC = dsolve(diff(v, t) == (Vs - v)/(R*C), v(0) == 0)   % RC charging
