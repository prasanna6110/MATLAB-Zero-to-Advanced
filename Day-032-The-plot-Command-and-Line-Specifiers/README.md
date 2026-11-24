# Day 032 · The plot Command and Line Specifiers

_Two-Dimensional Plots_

## `plot(x, y)`
Draws the points `(x(k), y(k))` joined by straight lines. `x` and `y` must have the **same length**. The figure opens in a **Figure Window**.

- `plot(y)` alone uses `1:length(y)` as x.
- For a **smooth curve** of a function, use many points: `x = linspace(0, 2*pi, 200)`.

## Line specifiers: `plot(x, y, 'r--o')`
| Line style | | Colour | | Marker | |
|-----------|--|--------|--|--------|--|
| `-` solid (default) | | `r` red | | `o` circle | |
| `--` dashed | | `g` green | | `*` asterisk | |
| `:` dotted | | `b` blue | | `+` plus | |
| `-.` dash-dot | | `c` cyan, `m` magenta | | `x` cross, `.` point | |
| | | `y` yellow, `k` black, `w` white | | `s` square, `d` diamond | |
| | | | | `^ v < >` triangles, `p` pentagram, `h` hexagram | |

A marker without a line style draws **only markers**: `plot(x, y, 'ro')`.

## Property name / value pairs
```matlab
plot(x, y, 'b-', 'LineWidth', 2, 'MarkerSize', 8, ...
     'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'y', 'Color', [0.8 0.3 0])
```
Colours can also be RGB triples `[r g b]` with values 0–1.

## Examples

### Example 1: Plotting measured data  ([`example_1.m`](example_1.m))

```matlab
year = [2016 2017 2018 2019 2020 2021 2022 2023];
peak_GW = [159 164 177 183 183 200 211 243];
plot(year, peak_GW, '--rs', 'LineWidth', 1.5, 'MarkerFaceColor', 'r')
xlabel('Year'); ylabel('Peak demand (GW)')
title('Peak electricity demand')
grid on
fprintf('Growth over the period: %.1f %%\n', 100 * (peak_GW(end) / peak_GW(1) - 1));
```

### Example 2: Plotting a function smoothly  ([`example_2.m`](example_2.m))

```matlab
x = linspace(-2, 4, 300);          % many points -> smooth curve
y = 3.5.^(-0.5*x) .* cos(6*x);
plot(x, y, 'LineWidth', 1.2)
xlabel('x'); ylabel('y')
title('y = 3.5^{-0.5x} cos(6x)')
grid on
% Compare with only 10 points: the shape is lost
x10 = linspace(-2, 4, 10);
hold on
plot(x10, 3.5.^(-0.5*x10) .* cos(6*x10), 'ko--')
hold off
legend('300 points', '10 points')
```

### Example 3: Markers only, and plot(y)  ([`example_3.m`](example_3.m))

```matlab
rng(2);
x = 1:20;
y = 2*x + 5 + 4*randn(1, 20);
plot(x, y, 'bo', 'MarkerSize', 7)           % scatter-style, no line
xlabel('Sample'); ylabel('Value'); grid on
figure
plot(cumsum(randn(1, 200)), 'k')            % plot(y): x is 1..200
title('A random walk')
```

## Practice

1. Plot `y = x.^2 - 4*x + 3` for `-1 ≤ x ≤ 5` with a red dashed line.
2. Plot monthly rainfall for 12 months with green diamond markers and no line.
3. Plot one cycle of a 50 Hz, 325 V peak voltage with a line width of 2.
4. Try `plot(x, y, 'Color', [1 0.5 0])`. What colour is it?

---

[⬅ Day 031](../Day-031-Low-level-File-I-O-fopen-fprintf-fgetl-fscanf-textscan/README.md) · [🏠 Home](../README.md) · [Day 033 ➡](../Day-033-The-fplot-Command/README.md)
