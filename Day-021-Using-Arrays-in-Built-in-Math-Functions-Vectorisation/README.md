# Day 021 · Using Arrays in Built-in Math Functions (Vectorisation)

_Mathematics with Arrays_

## Functions work on whole arrays
Most built-in functions (`sqrt`, `exp`, `sin`, `log`, `abs`, `round` …) accept an array and act on **every element**, returning an array of the same size.

```matlab
x = [0 pi/2 pi];
sin(x)            % [0 1 0]
sqrt([4 9 16])    % [2 3 4]
```

## Vectorisation
Writing code that works on whole arrays instead of loops is called **vectorisation**. It is:
- **shorter** and closer to the maths
- usually much **faster** in MATLAB

Typical pattern: create the input vector, write the formula once with the dot operators and functions, and get every result in one line.

Functions such as `sum`, `mean`, `max`, `cumsum`, `prod` reduce a vector to a single value or a running total, so they also replace many loops.

## Examples

### Example 1: Functions applied to every element  ([`example_1.m`](example_1.m))

```matlab
x = [1 4 9 16 25];
sqrt(x)
log(x)
round([2.4 -2.5 7.51])
A = [0 30 60; 90 120 180];
sind(A)                         % works on matrices too
abs([-3 4 -5])
```

### Example 2: A full table of values in one line each  ([`example_2.m`](example_2.m))

```matlab
theta = 0:15:90;
table = [theta; sind(theta); cosd(theta); tand(theta)]';
fprintf(' angle    sin      cos      tan\n');
fprintf('%5d %8.4f %8.4f %10.4f\n', table');
```

### Example 3: Loop vs vectorised code, and timing it  ([`example_3.m`](example_3.m))

```matlab
N = 1e6;
x = linspace(0, 10, N);
tic
y1 = zeros(1, N);
for k = 1:N
    y1(k) = exp(-0.2 * x(k)) * sin(3 * x(k));
end
t_loop = toc;
tic
y2 = exp(-0.2 * x) .* sin(3 * x);
t_vec = toc;
fprintf('Loop: %.4f s   Vectorised: %.4f s   Same result: %d\n', t_loop, t_vec, max(abs(y1 - y2)) < 1e-12);
```

## Practice

1. Compute `log10` of `[1 10 100 1000 0.01]`.
2. Make a table of x, eˣ and ln(x) for x = 1 to 10.
3. Rewrite this loop as one line: `s = 0; for k = 1:100, s = s + 1/k^2; end`.
4. For 1000 random angles, compute `sin(θ)^2 + cos(θ)^2`. What do you expect?

---

[⬅ Day 020](../Day-020-Element-by-Element-Operations/README.md) · [🏠 Home](../README.md) · [Day 022 ➡](../Day-022-Built-in-Functions-for-Analyzing-Arrays-Statistics/README.md)
