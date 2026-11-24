# Day 020 · Element-by-Element Operations

_Mathematics with Arrays_

## The dot operators
To multiply, divide or raise to a power **element by element**, put a **dot** before the operator:

| Operator | Meaning | Example |
|----------|---------|---------|
| `.*` | element-wise multiply | `[1 2 3] .* [4 5 6]` → `[4 10 18]` |
| `./` | element-wise right divide | `[4 9] ./ [2 3]` → `[2 3]` |
| `.\` | element-wise left divide | `[2 3] .\ [4 9]` → `[2 3]` |
| `.^` | element-wise power | `[1 2 3] .^ 2` → `[1 4 9]` |

`+` and `-` are always element by element, so they have no dot version.

## When you need it
Whenever you evaluate a **formula at many points**:
```matlab
x = 0:0.1:2;
y = x.^2 .* exp(-x) ./ (1 + x);
```
Without the dots, MATLAB tries matrix operations and fails (or silently gives a different answer for square matrices).

> **Rule of thumb:** if `x` is a vector of points, use `.*`, `./` and `.^` between terms that contain `x`. Multiplying or dividing by a plain scalar needs no dot.

## Examples

### Example 1: The dot makes the difference  ([`example_1.m`](example_1.m))

```matlab
a = [1 2 3];
b = [4 5 6];
a .* b
a ./ b
a .^ 2
2 .^ a                      % 2^1, 2^2, 2^3
try
    a * b                   % matrix multiply of two 1x3 -> error
catch err
    disp(err.message)
end
A = [1 2; 3 4];
A * A                       % matrix product
A .* A                      % squares of the elements: a different result
```

### Example 2: Evaluating a formula at many points  ([`example_2.m`](example_2.m))

```matlab
x = 1:5;
y = (x.^2 + 1) ./ (x + 3)
% Same thing with a loop (slower, longer):
y_loop = zeros(1, 5);
for k = 1:5
    y_loop(k) = (x(k)^2 + 1) / (x(k) + 3);
end
y_loop
isequal(y, y_loop)
```

### Example 3: Power dissipated in a set of resistors  ([`example_3.m`](example_3.m))

```matlab
R = [10 22 47 100 220];         % ohms
V = 12;                         % volts across each (all in parallel)
I = V ./ R                      % current in each
P = V^2 ./ R                    % power in each
P_check = I.^2 .* R             % same answer, a different formula
fprintf('Total current %.3f A, total power %.2f W\n', sum(I), sum(P));
```

## Practice

1. Evaluate `y = x.^3 - 2*x + 1` for `x = -2:0.5:2`.
2. For `t = 0:0.5:3`, compute the distance `d = 0.5*9.81*t.^2`.
3. Explain why `[1 2; 3 4]^2` and `[1 2; 3 4].^2` are different.
4. Compute `z = (x.*y)./(x+y)` for two vectors of your choice.

---

[⬅ Day 019](../Day-019-Array-Division-Inverse-Determinant-and-Solving-Linear-Equations/README.md) · [🏠 Home](../README.md) · [Day 021 ➡](../Day-021-Using-Arrays-in-Built-in-Math-Functions-Vectorisation/README.md)
