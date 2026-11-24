% Day 024 · Linear Algebra: rank, norm, eig, lu, qr and svd — LU, QR and SVD decompositions
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

A = [4 3 2; 2 1 3; 3 2 1];
[L, U, P] = lu(A);
disp(norm(P*A - L*U))           % ~0
[Q, R] = qr(A);
disp(norm(Q*R - A))             % ~0
[U2, S, V2] = svd(A);
singular_values = diag(S)'
B = [1 2; 2 4; 3 6];            % not square, rank 1
pinv(B)
