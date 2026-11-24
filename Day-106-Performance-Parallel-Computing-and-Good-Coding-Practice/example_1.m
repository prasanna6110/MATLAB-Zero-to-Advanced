% Day 106 · Performance, Parallel Computing and Good Coding Practice — Sparse matrices: memory and speed
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

n = 2000;
e = ones(n, 1);
A_sparse = spdiags([-e 2*e -e], -1:1, n, n);     % a tridiagonal matrix
A_full = full(A_sparse);
b = ones(n, 1);
tic; x1 = A_full \ b;  t_full = toc;
tic; x2 = A_sparse \ b; t_sparse = toc;
s1 = whos('A_full'); s2 = whos('A_sparse');
fprintf('Full  : %8.0f kB, solve %.4f s\n', s1.bytes/1024, t_full);
fprintf('Sparse: %8.0f kB, solve %.4f s\n', s2.bytes/1024, t_sparse);
fprintf('Same answer: %d, non-zeros %d of %d\n', norm(x1 - x2) < 1e-6*norm(x1), nnz(A_sparse), n^2);
