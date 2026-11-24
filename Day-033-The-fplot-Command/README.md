# Day 033 · The fplot Command

_Two-Dimensional Plots_

## `fplot`: plot a function without making x yourself
```matlab
fplot(@(x) x.^2 .* sin(x), [-10 10])
```
- The first argument is a **function handle** (an anonymous function, Day 54): `@(x) expression`.
- The second is the interval `[xmin xmax]` (default `[-5 5]`).
- `fplot` chooses the points itself and adds more where the curve bends quickly.
- Line specifiers and properties work as in `plot`: `fplot(f, [0 5], 'r--', 'LineWidth', 2)`.
- Several functions: call `fplot` again after `hold on`.
- Parametric curves: `fplot(@(t) cos(t), @(t) sin(t), [0 2*pi])`.

Older MATLAB also accepted a text formula: `fplot('x^2', [0 5])`. Modern MATLAB uses function handles (and `ezplot` is no longer recommended).

## Examples

### Example 1: fplot with a function handle  ([`example_1.m`](example_1.m))

```matlab
f = @(x) x.^2 + 4*sin(2*x) - 1;
fplot(f, [-3 3], 'LineWidth', 1.5)
grid on
xlabel('x'); ylabel('f(x)')
title('f(x) = x^2 + 4 sin(2x) - 1')
```

### Example 2: Several functions and a parametric curve  ([`example_2.m`](example_2.m))

```matlab
fplot(@(t) exp(-t), [0 5], 'b')
hold on
fplot(@(t) 1 - exp(-t), [0 5], 'r--')
fplot(@(t) t.*exp(-t), [0 5], 'k:')
hold off
legend('e^{-t}', '1 - e^{-t}', 't e^{-t}')
xlabel('t (time constants)')
figure
t = linspace(0, 2*pi, 500);       % a parametric curve: x(t), y(t)
plot(sin(3*t), sin(4*t))          % (MATLAB also allows fplot(@(t) sin(3*t), @(t) sin(4*t), [0 2*pi]))
axis equal
title('x = sin 3t, y = sin 4t')
```

### Example 3: Capacitor charging for different time constants  ([`example_3.m`](example_3.m))

```matlab
V = 12;
hold on
for tau = [0.5 1 2]
    fplot(@(t) V * (1 - exp(-t/tau)), [0 8], 'LineWidth', 1.5)
end
hold off
legend('\tau = 0.5 s', '\tau = 1 s', '\tau = 2 s', 'Location', 'southeast')
xlabel('Time (s)'); ylabel('Capacitor voltage (V)')
title('RC charging')
grid on
```

## Practice

1. Use `fplot` to draw `f(x) = x³ - 6x² + 9x + 1` on `[-1 5]`.
2. Draw a circle of radius 2 as a parametric `fplot` and make the axes equal.
3. Plot `sin(x)/x` on `[-20 20]`. What does `fplot` do near x = 0?
4. Plot the discharge curve `V0*exp(-t/RC)` for three values of RC on one graph.

---

[⬅ Day 032](../Day-032-The-plot-Command-and-Line-Specifiers/README.md) · [🏠 Home](../README.md) · [Day 034 ➡](../Day-034-Plotting-Multiple-Graphs-plot-with-Several-Pairs-hold-and-line/README.md)
