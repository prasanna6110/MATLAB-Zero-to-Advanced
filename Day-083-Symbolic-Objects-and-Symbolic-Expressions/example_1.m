% Day 083 · Symbolic Objects and Symbolic Expressions — Exact vs numeric
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Symbolic Math Toolbox
a = sqrt(2)                 % a rounded number
b = sqrt(sym(2))            % exact
b^2                         % exactly 2
c = sym(1)/3 + sym(1)/6     % exact fraction 1/2
1/3 + 1/6                   % floating point 0.5000
d = sym(10)^25 + 1          % exact big integers
e = vpa(pi, 40)             % pi to 40 digits
