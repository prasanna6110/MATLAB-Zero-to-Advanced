% Day 066 · Polynomial Arithmetic: conv, deconv, polyder, polyint and residue — Derivatives and integrals
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

f = [3 -2 4];                   % 3x^2 - 2x + 4
g = [1 5];                      % x + 5
df = polyder(f)                 % 6x - 2
d_fg = polyder(f, g)            % derivative of f*g
[n, d] = polyder(f, g)          % derivative of f/g = n/d
F = polyint(f)                  % x^3 - x^2 + 4x (+0)
area = polyval(F, 2) - polyval(F, 0)     % integral from 0 to 2
% Turning points of f(x) = x^3 - 6x^2 + 9x + 1
p = [1 -6 9 1];
crit = roots(polyder(p))'
values = polyval(p, crit)
