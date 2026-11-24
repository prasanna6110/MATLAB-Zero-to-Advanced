# Day 034 · Plotting Multiple Graphs: plot with Several Pairs, hold, and line

_Two-Dimensional Plots_

## Three ways to put several curves in one plot
1. **One `plot` with several x,y pairs**:
   `plot(x, y1, 'b', x, y2, 'r--', x, y3, 'k:')`
2. **`hold on`**: keeps the current plot, so the next `plot` adds to it. `hold off` ends it.
3. **`line(x, y)`**: adds a line to the existing axes without erasing them (a low-level command with property pairs: `line(x, y, 'Color', 'r', 'LineStyle', '--')`).

## A legend
`legend('first', 'second', ..., 'Location', 'best')`. Locations: `north`, `south`, `east`, `west`, `northeast` (default), `southwest` …, `best`, `bestoutside`. You can also give each curve a name: `plot(x, y, 'DisplayName', 'data')` then `legend show`.

## A plot of a function and its derivatives
A classic use: plot `y`, `y'` and `y''` on the same axes to see where the slope is zero (max/min) and where the curvature changes sign (inflection).

## Examples

### Example 1: A function and its derivatives in one plot call  ([`example_1.m`](example_1.m))

```matlab
x = linspace(-2, 4, 200);
y = 3*x.^3 - 26*x + 10;
dy = 9*x.^2 - 26;
d2y = 18*x;
plot(x, y, 'b-', x, dy, 'r--', x, d2y, 'k:', 'LineWidth', 1.4)
legend('y', 'y''', 'y''''', 'Location', 'northwest')
xlabel('x'); grid on
title('y = 3x^3 - 26x + 10 and its derivatives')
```

### Example 2: hold on / hold off  ([`example_2.m`](example_2.m))

```matlab
t = linspace(0, 0.04, 400);
va = 325*sin(2*pi*50*t);
vb = 325*sin(2*pi*50*t - 2*pi/3);
vc = 325*sin(2*pi*50*t + 2*pi/3);
plot(t*1000, va, 'r')
hold on
plot(t*1000, vb, 'g')
plot(t*1000, vc, 'b')
hold off
xlabel('Time (ms)'); ylabel('Voltage (V)')
legend('V_a', 'V_b', 'V_c')
title('Three-phase supply')
grid on
```

### Example 3: The line command and DisplayName  ([`example_3.m`](example_3.m))

```matlab
x = 0:0.1:10;
plot(x, sqrt(x), 'DisplayName', '\surd x')
line(x, log(x + 1), 'Color', 'r', 'LineStyle', '--', 'DisplayName', 'ln(x+1)')
line([0 10], [2 2], 'Color', [0.5 0.5 0.5], 'DisplayName', 'level 2')
legend show
xlabel('x'); grid on
```

## Practice

1. Plot `sin(x)`, `sin(2x)` and `sin(3x)` for `0 ≤ x ≤ 2π` in one `plot` command.
2. Plot measured points as markers and a fitted line through them using `hold on`.
3. Add a horizontal dashed line at the average of some data with `line`.
4. Plot `f(x) = x⁴ - 4x²` and its first derivative, and mark the points where the derivative is zero.

---

[⬅ Day 033](../Day-033-The-fplot-Command/README.md) · [🏠 Home](../README.md) · [Day 035 ➡](../Day-035-Formatting-a-Plot-Labels-Title-Text-Legend-Axis-and-Grid/README.md)
