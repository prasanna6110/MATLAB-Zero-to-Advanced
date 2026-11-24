% Day 024 · Linear Algebra: rank, norm, eig, lu, qr and svd — Eigenvalues and eigenvectors
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

A = [4 1; 2 3];
[V, D] = eig(A)
lambda = diag(D)'
A * V - V * D                   % ~0, the definition
% Stability of a system x' = M x: stable if all real parts are negative
M = [0 1; -5 -2];
ev = eig(M)
if all(real(ev) < 0)
    disp('The system is stable')
end
