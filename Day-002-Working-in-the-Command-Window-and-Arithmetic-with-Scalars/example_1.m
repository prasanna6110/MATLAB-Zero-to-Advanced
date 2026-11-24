% Day 002 · Working in the Command Window and Arithmetic with Scalars — Operator precedence step by step
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

a = 8 + 4 / 2          % 10  (division first)
b = (8 + 4) / 2        % 6
c = 2 ^ 3 * 2          % 16  (power first)
d = 2 ^ (3 * 2)        % 64
e = -2 ^ 2             % -4  (power before the minus)
f = (-2) ^ 2           % 4
g = 27 ^ (1/3) + 32 ^ 0.2   % cube root of 27 + fifth root of 32 = 3 + 2
h = 10 \ 50            % left division: 50 / 10 = 5
