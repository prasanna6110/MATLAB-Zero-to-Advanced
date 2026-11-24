# Day 019 · Array Division: Inverse, Determinant and Solving Linear Equations

_Mathematics with Arrays_

## Identity, inverse and determinant
- `eye(n)`: the identity matrix, `A * eye(n) = A`.
- `inv(A)`: the inverse, with `A * inv(A) = eye(n)`. Only for **square, non-singular** matrices.
- `det(A)`: the determinant. If `det(A) = 0` the matrix is **singular** (no inverse).
- `A^-1` is the same as `inv(A)`.

## Left division `\` and right division `/`
To solve the linear system **A x = b** for x:
```matlab
x = A \ b        % left division (recommended)
x = inv(A) * b   % works, but slower and less accurate
```
`\` uses Gaussian elimination (LU decomposition), so it is **faster and more accurate** than `inv`. It also gives the least-squares answer when there are more equations than unknowns.

For **x A = b** (x and b are rows), use right division: `x = b / A`.

## Writing equations in matrix form
```
 4x - 2y + 6z = 8
 2x + 8y + 2z = 4      →   A = [4 -2 6; 2 8 2; 6 10 3],  b = [8; 4; 0]
 6x + 10y + 3z = 0
```
Each row of A holds the coefficients of one equation, in the same variable order.

## Examples

### Example 1: Solving three equations with three unknowns  ([`example_1.m`](example_1.m))

```matlab
A = [4 -2 6; 2 8 2; 6 10 3];
b = [8; 4; 0];
x = A \ b                     % left division
x_inv = inv(A) * b            % same answer
check = A * x - b             % should be (almost) zero
det(A)
```

### Example 2: Mesh analysis of a DC circuit  ([`example_2.m`](example_2.m))

```matlab
% Three meshes. Write KVL for each mesh as R * I = V
%   mesh 1: (2+4)I1 - 4 I2         = 12
%   mesh 2: -4 I1 + (4+6+3)I2 - 3 I3 = 0
%   mesh 3:        -3 I2 + (3+5) I3 = -6
R = [ 6 -4  0
     -4 13 -3
      0 -3  8];
V = [12; 0; -6];
I = R \ V;
fprintf('I1 = %.4f A, I2 = %.4f A, I3 = %.4f A\n', I);
fprintf('Current in the 4 ohm resistor (I1 - I2) = %.4f A\n', I(1) - I(2));
```

### Example 3: Singular matrices and least squares  ([`example_3.m`](example_3.m))

```matlab
S = [1 2; 2 4];               % row 2 = 2 * row 1
det(S)                        % 0 -> singular
rank(S)                       % only 1 independent row
% More equations than unknowns (an overdetermined system):
% fit y = a + b*x through 4 noisy points in the least-squares sense
x = [0; 1; 2; 3];
y = [1.1; 2.9; 5.2; 6.8];
A = [ones(4, 1) x];
coeffs = A \ y                % best a and b
% Right division: solve x*M = c
M = [2 1; 1 3];
c = [5 10];
xr = c / M
xr * M                        % gives back c
```

## Practice

1. Solve: `x + y + z = 6`, `2y + 5z = -4`, `2x + 5y - z = 27`.
2. Check your answer by computing `A*x - b`.
3. Compare the time of `A\b` and `inv(A)*b` for a 2000×2000 random matrix using `tic`/`toc`.
4. Write node-voltage equations for a 2-node circuit of your choice and solve them.

---

[⬅ Day 018](../Day-018-Matrix-Multiplication-and-the-Dot-Product/README.md) · [🏠 Home](../README.md) · [Day 020 ➡](../Day-020-Element-by-Element-Operations/README.md)
