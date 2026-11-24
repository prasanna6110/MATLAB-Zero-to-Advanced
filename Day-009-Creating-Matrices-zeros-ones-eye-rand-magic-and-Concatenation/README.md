# Day 009 · Creating Matrices: zeros, ones, eye, rand, magic and Concatenation

_Creating Arrays_

## Typing a matrix
Separate **elements** with spaces or commas and **rows** with semicolons (or Enter):
```matlab
A = [1 2 3; 4 5 6]        % 2x3 matrix
```
Every row must have the **same number of columns**, otherwise you get *"Dimensions of arrays being concatenated are not consistent"*.

Elements can be expressions, variables or even vectors: `[x; 2*x]`, `[1:4; linspace(0,1,4)]`.

## Special matrices
| Function | Creates |
|----------|---------|
| `zeros(m,n)` | m×n matrix of 0s (`zeros(n)` is n×n) |
| `ones(m,n)` | m×n matrix of 1s |
| `eye(n)` | n×n identity matrix |
| `rand(m,n)` / `randn(m,n)` / `randi(k,m,n)` | random numbers (Day 23) |
| `magic(n)` | n×n magic square (rows, columns and diagonals have the same sum) |
| `diag(v)` | a matrix with `v` on the diagonal; `diag(A)` extracts the diagonal |
| `repmat(A, r, c)` | tiles A r×c times |
| `NaN(m,n)`, `Inf(m,n)`, `true(m,n)`, `false(m,n)` | filled matrices |

## Concatenation
- `[A B]` joins **side by side** (same number of rows)
- `[A; B]` joins **one under the other** (same number of columns)
- `cat(dim, A, B)` does the same along any dimension; `cat(3, A, B)` builds a 3-D array

## Notes about variables in MATLAB
- Every variable is an array. There is **no declaration of type or size**.
- A variable's size and type can change when you reassign it.
- The **memory is allocated automatically**, but growing an array inside a loop is slow, so create it first with `zeros` (preallocation, Day 48).

## Examples

### Example 1: Typing matrices  ([`example_1.m`](example_1.m))

```matlab
A = [5 35 43; 4 76 81; 21 32 40]
B = [1 2 3
     4 5 6]                     % Enter also starts a new row
x = 2;
C = [x  x^2  x^3; sqrt(x) exp(x) 1/x]
D = [1:4; linspace(10, 40, 4); zeros(1, 4)]
size(D)
```

### Example 2: Special matrices  ([`example_2.m`](example_2.m))

```matlab
Z = zeros(2, 3)
O = ones(3)
I = eye(4)
M = magic(4)
sum(M)                          % every column adds to 34
sum(M, 2)'                      % every row too
D = diag([2 4 6])
diag(M)'                        % pull out the diagonal
R = repmat([1 2], 2, 3)
```

### Example 3: Building bigger matrices from smaller ones  ([`example_3.m`](example_3.m))

```matlab
A = [1 2; 3 4];
B = [5 6; 7 8];
side = [A B]                    % 2x4
stacked = [A; B]                % 4x2
block = [A zeros(2); zeros(2) B] % a block-diagonal 4x4 matrix
three_d = cat(3, A, B);         % a 2x2x2 array
size(three_d)
% Error example: rows of different length
try
    bad = [1 2 3; 4 5];
catch err
    disp(err.message)
end
```

## Practice

1. Create a 3×4 matrix whose rows are `1:4`, `5:8` and `9:12`.
2. Create a 5×5 matrix with 7 on the diagonal and 0 elsewhere (two ways: `7*eye(5)` and `diag(...)`).
3. Make a 4×6 matrix of ones with zeros in the middle 2×2 block.
4. Check that `magic(5)` really is magic: compare `sum`, `sum(..,2)`, `trace` and the anti-diagonal sum.

---

[⬅ Day 008](../Day-008-Creating-Vectors-Row-Column-Colon-and-linspace/README.md) · [🏠 Home](../README.md) · [Day 010 ➡](../Day-010-The-Transpose-Operator-and-Array-Addressing/README.md)
