# Day 044 · for Loops

_Programming in MATLAB_

## Syntax
```matlab
for k = first:step:last
    commands
end
```
- The loop variable `k` takes **each value** of the vector in turn.
- The vector can be anything: `for k = [3 7 1]`, `for v = linspace(0,1,5)`.
- If the right side is a **matrix**, `k` takes each **column** in turn.
- Do **not** change `k` inside the loop to skip values (it is reset each pass); use `continue` instead.
- Avoid naming the counter `i` or `j` if you also use complex numbers.

## Typical loop patterns
- **Accumulate** a sum or product: `s = 0; for k = 1:n, s = s + term; end`
- **Fill** an array: `x = zeros(1, n); for k = 1:n, x(k) = ...; end`
- **Recurrence**: each value from the previous one, e.g. `x(k) = 0.5*x(k-1) + 1`
- **Loop over items**: `for k = 1:numel(names) ... names{k} ... end`

In MATLAB, many loops can be replaced by vectorised code (Day 48), but loops are still needed for recurrences and step-by-step simulations.

## Examples

### Example 1: Summing a series  ([`example_1.m`](example_1.m))

```matlab
% sum of 1/k^2 for k = 1..n approaches pi^2/6
for n = [10 100 1000 10000]
    s = 0;
    for k = 1:n
        s = s + 1/k^2;
    end
    fprintf('n = %5d: sum = %.6f   pi^2/6 = %.6f\n', n, s, pi^2/6);
end
```

### Example 2: A recurrence: cooling of a transformer  ([`example_2.m`](example_2.m))

```matlab
T_amb = 30;  T = 95;  k = 0.08;           % Newton-style cooling, 1 step = 1 minute
minutes = 40;
temps = zeros(1, minutes + 1);
temps(1) = T;
for m = 1:minutes
    temps(m + 1) = temps(m) - k * (temps(m) - T_amb);
end
fprintf('After %d minutes: %.1f C\n', minutes, temps(end));
plot(0:minutes, temps, 'r.-'); xlabel('Minute'); ylabel('Temperature (C)'); grid on
idx = find(temps < 50, 1);
fprintf('Below 50 C after %d minutes\n', idx - 1);
```

### Example 3: Looping over items and over matrix columns  ([`example_3.m`](example_3.m))

```matlab
names = {'Feeder-1', 'Feeder-2', 'Feeder-3'};
loads = [3.2 5.8 4.1];                      % MW
for k = 1:numel(names)
    status = 'OK';
    if loads(k) > 5, status = 'OVERLOADED'; end
    fprintf('%s: %.1f MW  %s\n', names{k}, loads(k), status);
end
M = [1 2 3; 4 5 6];
for col = M                                 % col takes each column
    fprintf('column sum = %d\n', sum(col));
end
```

## Practice

1. Use a for loop to compute the factorial of 10 and check with `factorial(10)`.
2. Print the first 20 Fibonacci numbers using a loop.
3. Compute the compound interest balance year by year for 15 years and plot it.
4. Approximate e using the series 1 + 1/1! + 1/2! + … with 15 terms.

---

[⬅ Day 043](../Day-043-The-switch-case-Statement/README.md) · [🏠 Home](../README.md) · [Day 045 ➡](../Day-045-while-Loops/README.md)
