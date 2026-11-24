% Day 024 · Linear Algebra: rank, norm, eig, lu, qr and svd — Rank, norm, condition number
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

A = [2 1 1; 1 3 2; 1 0 0];
rank(A)
v = [3 4];
norm(v)                         % 5
norm([1 -2 3], 1)               % sum of absolute values = 6
cond(A)
H = hilb(6);                    % a famous badly conditioned matrix
fprintf('cond(hilb(6)) = %.3g -> results can lose many digits\n', cond(H));
