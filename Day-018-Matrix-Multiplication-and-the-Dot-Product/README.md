# Day 018 · Matrix Multiplication and the Dot Product

_Mathematics with Arrays_

## The `*` operator is matrix multiplication
`C = A * B` follows the rules of **linear algebra**:
- The number of **columns of A** must equal the number of **rows of B**. (m×**n**) * (**n**×p) → m×p.
- Each element `C(i,j)` is the dot product of row i of A with column j of B.
- In general **A*B ≠ B*A**.

Special cases:
- row (1×n) * column (n×1) = a scalar (the **dot product**, also `dot(a, b)`)
- column (n×1) * row (1×n) = an n×n matrix (the **outer product**)
- `A * I = A` for the identity `I = eye(n)`
- `A^2` means `A*A` (A must be square). For the square of every element use `A.^2` (Day 20).

## Where it is used
Systems of equations, transformations (rotation, scaling), Markov chains, networks, and many formulas such as total cost = quantities * prices.

## Examples

### Example 1: Matrix multiplication rules  ([`example_1.m`](example_1.m))

```matlab
A = [1 2 3; 4 5 6];         % 2x3
B = [1 0; 0 1; 1 1];         % 3x2
C = A * B                    % 2x2
D = B * A                    % 3x3, a different result
try
    A * A                    % 2x3 * 2x3 is not allowed
catch err
    disp(err.message)
end
M = magic(3);
M^2                          % same as M*M
```

### Example 2: Dot product, outer product and cross product  ([`example_2.m`](example_2.m))

```matlab
a = [1 2 3]; b = [4 5 6];
a * b'                       % dot product = 32
dot(a, b)                    % same
a' * b                       % outer product, 3x3
cross(a, b)                  % perpendicular vector
% Work done by a force F along a displacement d
F = [10 0 5]; d = [3 4 0];
W = dot(F, d)
```

### Example 3: Shop bill and a 2-D rotation  ([`example_3.m`](example_3.m))

```matlab
% Bill: 3 shops x 4 items, quantities times prices
qty = [2 1 0 5; 1 3 2 0; 4 0 1 1];   % 3 customers x 4 items
price = [40; 25; 120; 10];           % 4 items x 1
bill = qty * price                   % 3x1 amount for each customer
% Rotate the point (1, 0) by 90 degrees
th = 90;
Rot = [cosd(th) -sind(th); sind(th) cosd(th)];
p = Rot * [1; 0]
```

## Practice

1. Is `[1 2; 3 4] * [5; 6]` valid? Work it out by hand, then check.
2. Show with an example that `A*B` and `B*A` differ.
3. Three items cost Rs 30, 45 and 60. Four customers buy different quantities. Use one matrix multiplication to find every bill.
4. Find the angle between vectors `[1 2 2]` and `[2 1 -2]` using `dot` and `norm`.

---

[⬅ Day 017](../Day-017-Addition-Subtraction-and-Operations-with-Scalars/README.md) · [🏠 Home](../README.md) · [Day 019 ➡](../Day-019-Array-Division-Inverse-Determinant-and-Solving-Linear-Equations/README.md)
