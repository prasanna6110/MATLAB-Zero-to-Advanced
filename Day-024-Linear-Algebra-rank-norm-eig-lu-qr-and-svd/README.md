# Day 024 · Linear Algebra: rank, norm, eig, lu, qr and svd

_Mathematics with Arrays_

## More matrix functions
| Function | Gives |
|----------|-------|
| `rank(A)` | the number of independent rows / columns |
| `norm(v)` | length of a vector (2-norm); `norm(v, 1)`, `norm(v, Inf)` |
| `norm(A)` | the largest singular value of a matrix |
| `cond(A)` | the condition number; a big value means the system is sensitive to small errors |
| `trace(A)` | the sum of the diagonal |
| `[V, D] = eig(A)` | eigenvalues (diagonal of D) and eigenvectors (columns of V): `A*V = V*D` |
| `[L, U, P] = lu(A)` | LU decomposition, `P*A = L*U` |
| `[Q, R] = qr(A)` | QR decomposition, Q orthogonal, R upper triangular |
| `chol(A)` | Cholesky, `A = R'*R` for symmetric positive-definite A |
| `[U, S, V] = svd(A)` | singular value decomposition `A = U*S*V'` |
| `pinv(A)` | the pseudo-inverse (works for non-square or singular A) |
| `null(A)`, `orth(A)` | bases of the null space and the column space |
| `expm(A)` | the matrix exponential (used for linear ODE systems) |
| `kron(A, B)` | Kronecker product |

Eigenvalues tell you about stability in control systems (all real parts negative → stable), natural frequencies of vibrating systems, and principal components in data.

## Examples

### Example 1: Rank, norm, condition number  ([`example_1.m`](example_1.m))

```matlab
A = [2 1 1; 1 3 2; 1 0 0];
rank(A)
v = [3 4];
norm(v)                         % 5
norm([1 -2 3], 1)               % sum of absolute values = 6
cond(A)
H = hilb(6);                    % a famous badly conditioned matrix
fprintf('cond(hilb(6)) = %.3g -> results can lose many digits\n', cond(H));
```

### Example 2: Eigenvalues and eigenvectors  ([`example_2.m`](example_2.m))

```matlab
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
```

### Example 3: LU, QR and SVD decompositions  ([`example_3.m`](example_3.m))

```matlab
A = [4 3 2; 2 1 3; 3 2 1];
[L, U, P] = lu(A);
disp(norm(P*A - L*U))           % ~0
[Q, R] = qr(A);
disp(norm(Q*R - A))             % ~0
[U2, S, V2] = svd(A);
singular_values = diag(S)'
B = [1 2; 2 4; 3 6];            % not square, rank 1
pinv(B)
```

## Practice

1. Find the eigenvalues of `[2 0 0; 0 3 4; 0 4 9]` and check `A*V = V*D`.
2. Show that `det(A)` equals the product of the eigenvalues for a 3×3 matrix of your choice.
3. Use `chol` on `[4 2; 2 3]` and verify `R'*R`.
4. Compute the angle between two vectors using `norm` and `dot`.

---

[⬅ Day 023](../Day-023-Generation-of-Random-Numbers/README.md) · [🏠 Home](../README.md) · [Day 025 ➡](../Day-025-Complex-Numbers-and-Phasors/README.md)
