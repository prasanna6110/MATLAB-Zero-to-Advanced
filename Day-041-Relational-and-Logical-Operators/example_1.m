% Day 041 · Relational and Logical Operators — Comparisons give 0 or 1
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

5 > 8
5 ~= 8
a = 5 >= 5
class(a)                           % logical
v = [3 8 1 9 4];
v > 4                              % element by element
sum(v > 4)                         % how many
y = (6 < 10) + (7 > 8) + (5*3 == 60/4)   % true + false + true = 2
