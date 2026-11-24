% Day 009 · Creating Matrices: zeros, ones, eye, rand, magic and Concatenation — Typing matrices
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

A = [5 35 43; 4 76 81; 21 32 40]
B = [1 2 3
     4 5 6]                     % Enter also starts a new row
x = 2;
C = [x  x^2  x^3; sqrt(x) exp(x) 1/x]
D = [1:4; linspace(10, 40, 4); zeros(1, 4)]
size(D)
