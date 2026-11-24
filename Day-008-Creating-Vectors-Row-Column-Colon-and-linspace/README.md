# Day 008 · Creating Vectors: Row, Column, Colon and linspace

_Creating Arrays_

## What is a vector?
A **vector** is a one-dimensional array: a list of numbers in a row (1×n) or a column (n×1).

| How | Syntax | Result |
|-----|--------|--------|
| Row vector, list the elements | `[1 2 3]` or `[1, 2, 3]` | 1×3 |
| Column vector | `[1; 2; 3]` | 3×1 |
| Colon, step 1 | `m:n` | `1:5` → 1 2 3 4 5 |
| Colon, given step | `m:q:n` | `0:2:10` → 0 2 4 6 8 10 |
| Counting down | `10:-3:0` | 10 7 4 1 |
| Fixed number of points | `linspace(xi, xf, n)` | `linspace(0,1,5)` → 0 0.25 0.5 0.75 1 |
| Log-spaced points | `logspace(a, b, n)` | `logspace(0,3,4)` → 1 10 100 1000 |

Notes:
- With `m:q:n`, the last element **never goes past `n`**. `0:3:10` is `0 3 6 9`.
- If the step goes the wrong way (`5:1`), you get an **empty** vector (1×0).
- With `linspace`, the default `n` is 100.
- Use `linspace` when you need an exact number of points; use the colon when you need an exact spacing.

## Examples

### Example 1: Different ways to make a vector  ([`example_1.m`](example_1.m))

```matlab
years = [2019 2020 2021 2022 2023]      % row vector, typed in
load_MW = [210; 235; 228; 260]          % column vector, semicolons
x = 1:6                                 % step 1
t = 0:0.25:1                            % step 0.25
down = 20:-5:0                          % negative step
odd = 1:2:12                            % stops at 11, never passes 12
empty = 5:1                             % empty 1x0 vector
size(empty)
```

### Example 2: linspace and logspace  ([`example_2.m`](example_2.m))

```matlab
x = linspace(0, 10, 6)                  % 6 points, both ends included
angles = linspace(0, 2*pi, 5)
f = logspace(1, 4, 4)                   % 10 100 1000 10000 Hz
n = length(linspace(-1, 1))             % default is 100 points
```

### Example 3: Vectors built from formulas  ([`example_3.m`](example_3.m))

```matlab
t = 0:0.001:0.02;                       % one 50 Hz cycle, 1 ms steps
fprintf('%d samples\n', length(t));
v = 325 * sin(2*pi*50*t);               % instantaneous voltage
fprintf('First five samples: %s\n', mat2str(v(1:5), 4));
% A vector of the squares of 1..10 (element-wise power, Day 20)
squares = (1:10).^2
```

## Practice

1. Create a row vector of the even numbers from 2 to 30.
2. Create a column vector with the elements 5, 10, 15, 20.
3. Create 8 equally spaced points between -π and π.
4. What does `10:-2.5:0` produce? And `1:0.3:2`? Predict first.

---

[⬅ Day 007](../Day-007-Getting-Help-Reading-Errors-and-MATLAB-Applications/README.md) · [🏠 Home](../README.md) · [Day 009 ➡](../Day-009-Creating-Matrices-zeros-ones-eye-rand-magic-and-Concatenation/README.md)
