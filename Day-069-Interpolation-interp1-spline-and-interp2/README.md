# Day 069 · Interpolation: interp1, spline and interp2

_Polynomials, Curve Fitting and Interpolation_

## Interpolation vs curve fitting
- **Curve fitting** finds one smooth function that is close to all the points (it need not pass through them).
- **Interpolation** estimates values **between** known points, passing **exactly through** them.

## `interp1`
```matlab
yi = interp1(x, y, xi, method)
```
| Method | Result |
|--------|--------|
| `'linear'` (default) | straight lines between points |
| `'nearest'` | the value of the nearest point (steps) |
| `'previous'` / `'next'` | hold the previous / next value |
| `'spline'` | a smooth cubic spline (continuous 1st and 2nd derivatives) |
| `'pchip'` | a smooth curve that **does not overshoot** (keeps the shape, good for monotonic data) |

- `x` must be distinct (and is usually sorted).
- Outside the range of x the result is `NaN`, unless you add `'extrap'` (extrapolation is risky!).
- `spline(x, y, xi)` and `pchip(x, y, xi)` are also separate functions.

## 2-D interpolation
`zi = interp2(X, Y, Z, xi, yi, method)` for data on a grid (e.g. a table of efficiency vs speed and torque). `griddata` handles scattered points.

## Examples

### Example 1: Linear, nearest, spline and pchip compared  ([`example_1.m`](example_1.m))

```matlab
x = 0:1:5;
y = [1 2 1.5 4 4.2 3];
xi = linspace(0, 5, 200);
methods = {'nearest', 'linear', 'spline', 'pchip'};
for k = 1:4
    subplot(2, 2, k)
    plot(x, y, 'ko', 'MarkerFaceColor', 'k'); hold on
    plot(xi, interp1(x, y, xi, methods{k}), 'LineWidth', 1.3); hold off
    title(methods{k}); ylim([0 5]); grid on
end
fprintf('At x = 2.5: linear %.3f, spline %.3f, pchip %.3f\n', ...
    interp1(x, y, 2.5), interp1(x, y, 2.5, 'spline'), interp1(x, y, 2.5, 'pchip'));
```

### Example 2: Looking up a table: transformer efficiency  ([`example_2.m`](example_2.m))

```matlab
load_pct = [10 25 50 75 100 125];
eff = [93.1 96.5 97.9 98.2 98.1 97.8];
query = [40 60 90 110];
eff_q = interp1(load_pct, eff, query, 'pchip');
for k = 1:numel(query)
    fprintf('Efficiency at %3d%% load: %.2f %%\n', query(k), eff_q(k));
end
interp1(load_pct, eff, 150)                 % NaN outside the table
interp1(load_pct, eff, 150, 'linear', 'extrap')   % extrapolated: use with care
% Find the load for best efficiency on a fine grid
fine = 10:0.1:125;
[best, k] = max(interp1(load_pct, eff, fine, 'spline'));
fprintf('Best efficiency %.2f %% near %.1f %% load\n', best, fine(k));
```

### Example 3: Filling gaps in hourly data and 2-D interpolation  ([`example_3.m`](example_3.m))

```matlab
hours = 0:23;
temp = [22 21 21 20 20 21 23 NaN NaN 30 32 33 34 NaN 35 34 33 31 29 NaN 26 25 24 23];
good = ~isnan(temp);
filled = temp;
filled(~good) = interp1(hours(good), temp(good), hours(~good), 'pchip');
fprintf('Filled hours %s with %s\n', mat2str(hours(~good)), mat2str(filled(~good), 3));
% A motor efficiency map: rows = torque, columns = speed
speed = [500 1000 1500];
torque = [10 20 30];
eta = [80 86 88; 84 90 91; 83 89 92];
fprintf('Efficiency at 1250 rpm, 25 Nm: %.2f %%\n', interp2(speed, torque, eta, 1250, 25));
```

## Practice

1. Interpolate `sin` from 6 points on `[0, π]` with linear and spline methods. Which is closer to the true values?
2. A table gives the density of water at 0, 20, 40, 60, 80 °C. Estimate it at 35 °C.
3. Why can `'spline'` overshoot while `'pchip'` does not? Show an example.
4. Use `interp1` with `'previous'` to turn event times into a step signal.

---

[⬅ Day 068](../Day-068-Curve-Fitting-with-Functions-Other-than-Polynomials/README.md) · [🏠 Home](../README.md) · [Day 070 ➡](../Day-070-The-Basic-Fitting-Interface-and-Nonlinear-Least-Squares-Fits/README.md)
