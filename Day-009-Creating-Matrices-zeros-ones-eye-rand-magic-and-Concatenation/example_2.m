% Day 009 · Creating Matrices: zeros, ones, eye, rand, magic and Concatenation — Special matrices
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

Z = zeros(2, 3)
O = ones(3)
I = eye(4)
M = magic(4)
sum(M)                          % every column adds to 34
sum(M, 2)'                      % every row too
D = diag([2 4 6])
diag(M)'                        % pull out the diagonal
R = repmat([1 2], 2, 3)
