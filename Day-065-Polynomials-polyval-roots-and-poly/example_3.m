% Day 065 · Polynomials: polyval, roots and poly — The characteristic polynomial of a matrix
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

A = [2 1 0; 1 3 1; 0 1 4];
cp = poly(A)               % det(lambda*I - A)
lambda = roots(cp)'
eig(A)'                    % the same numbers
% Natural frequencies of a 2-mass spring system (k/m = 100)
K = [200 -100; -100 100];
w = sqrt(roots(poly(K)))'  % rad/s
