# Day 046 · Nested Loops and Nested Conditional Statements

_Programming in MATLAB_

## Nesting
Loops and `if` statements can be placed **inside one another**. Each `for`, `while`, `if` and `switch` needs its **own `end`**.

```matlab
for r = 1:nRows          % outer loop
    for c = 1:nCols      % inner loop: runs completely for every r
        ...
    end
end
```
- The inner loop runs **completely** for **each** pass of the outer loop, so `n × m` passes in total.
- Typical uses: going through every element of a matrix, tables (multiplication tables), comparing every pair of items, grids of parameter values.
- Keep the indentation consistent: it shows which `end` belongs to which statement.

## Examples

### Example 1: A multiplication table in a matrix  ([`example_1.m`](example_1.m))

```matlab
n = 6;
T = zeros(n);
for r = 1:n
    for c = 1:n
        T(r, c) = r * c;
    end
end
disp(T)
isequal(T, (1:n)' * (1:n))     % the vectorised way
```

### Example 2: Building a matrix with conditions  ([`example_2.m`](example_2.m))

```matlab
n = 5;
A = zeros(n);
for r = 1:n
    for c = 1:n
        if r == c
            A(r, c) = 4;
        elseif abs(r - c) == 1
            A(r, c) = -1;
        end
    end
end
disp(A)                          % a tridiagonal matrix used in numerical methods
```

### Example 3: Comparing every pair: closest two substations  ([`example_3.m`](example_3.m))

```matlab
names = {'A', 'B', 'C', 'D', 'E'};
xy = [0 0; 4 3; 1 7; 6 1; 3 4];         % km
best = Inf;
for p = 1:size(xy, 1) - 1
    for q = p + 1:size(xy, 1)
        d = norm(xy(p, :) - xy(q, :));
        if d < best
            best = d; pair = [p q];
        end
    end
end
fprintf('Closest: %s and %s, %.2f km apart\n', names{pair(1)}, names{pair(2)}, best);
```

## Practice

1. Print a right-angled triangle of `*` with 6 rows using nested loops.
2. Find all pairs (a, b) with 1 ≤ a ≤ b ≤ 20 and a² + b² a perfect square.
3. Replace each element of a matrix with the sum of its row and column numbers.
4. Rewrite your answer to question 3 without loops.

---

[⬅ Day 045](../Day-045-while-Loops/README.md) · [🏠 Home](../README.md) · [Day 047 ➡](../Day-047-The-break-and-continue-Commands/README.md)
