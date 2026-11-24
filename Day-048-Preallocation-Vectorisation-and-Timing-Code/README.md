# Day 048 · Preallocation, Vectorisation and Timing Code

_Programming in MATLAB_

## Preallocation
Growing an array inside a loop (`x(end+1) = ...` or `x = [x new]`) makes MATLAB **copy the whole array** every time. Create it at full size first:
```matlab
x = zeros(1, n);      % or ones, NaN(1,n), cell(1,n), strings(1,n)
for k = 1:n
    x(k) = ...;
end
```

## Vectorisation
Replace element-by-element loops with array operations and functions (`.* ./ .^`, `sum`, `cumsum`, `max`, logical indexing). It is usually much faster and shorter.

## Timing
- `tic; ...; t = toc` measures the elapsed time.
- `timeit(@() f(x))` gives a reliable time for a function (MATLAB).
- The **Profiler** (`profile on; ...; profile viewer`, or **Run and Time** in the Editor) shows which lines take the most time.

## Tips for fast MATLAB code
1. Preallocate arrays.
2. Vectorise inner loops.
3. Keep loops in **functions** rather than scripts (they are optimised better).
4. Loop down **columns** (MATLAB stores data column by column).
5. Avoid printing inside long loops.

## Examples

### Example 1: The cost of growing an array  ([`example_1.m`](example_1.m))

```matlab
n = 2e5;
tic
a = [];
for k = 1:n
    a(end + 1) = k^2;          % grows every pass
end
t_grow = toc;
tic
b = zeros(1, n);               % preallocated
for k = 1:n
    b(k) = k^2;
end
t_pre = toc;
tic
c = (1:n).^2;                  % vectorised
t_vec = toc;
fprintf('Growing: %.4f s  Preallocated: %.4f s  Vectorised: %.4f s\n', t_grow, t_pre, t_vec);
isequal(a, b, c)
```

### Example 2: Rewriting loops as vector code  ([`example_2.m`](example_2.m))

```matlab
x = linspace(0, 1, 11);
% Loop version: count values above 0.5 and add their squares
count = 0; s = 0;
for k = 1:numel(x)
    if x(k) > 0.5
        count = count + 1;
        s = s + x(k)^2;
    end
end
% Vector version
mask = x > 0.5;
count2 = nnz(mask);
s2 = sum(x(mask).^2);
fprintf('loop: %d, %.4f   vector: %d, %.4f\n', count, s, count2, s2);
% Running maximum, loop vs vector
y = [3 1 4 1 5 9 2 6];
rm = zeros(size(y)); rm(1) = y(1);
for k = 2:numel(y), rm(k) = max(rm(k-1), y(k)); end
disp(rm); disp(cummax(y))
```

### Example 3: A vectorised simulation of many trials  ([`example_3.m`](example_3.m))

```matlab
rng(8);
% 100000 people each pick a random birthday: how often do 23 people share one?
trials = 20000;
days = randi(365, 23, trials);
sorted = sort(days);
shared = any(diff(sorted) == 0);         % any equal neighbours in each column
fprintf('Probability that 2 of 23 people share a birthday: %.3f\n', mean(shared));
```

## Practice

1. Time the computation of `sum(1./(1:1e7))` with a loop and vectorised.
2. Rewrite `for k = 1:n, if v(k) < 0, v(k) = 0; end, end` as one line.
3. Use the Profiler on one of your slow scripts. Which line is the slowest?
4. Why is it better to loop down columns than across rows of a big matrix?

---

[⬅ Day 047](../Day-047-The-break-and-continue-Commands/README.md) · [🏠 Home](../README.md) · [Day 049 ➡](../Day-049-Error-Handling-try-catch-error-warning-and-assert/README.md)
