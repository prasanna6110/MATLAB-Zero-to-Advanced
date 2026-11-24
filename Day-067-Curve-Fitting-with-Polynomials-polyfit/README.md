# Day 067 · Curve Fitting with Polynomials: polyfit

_Polynomials, Curve Fitting and Interpolation_

## `polyfit`
```matlab
p = polyfit(x, y, n)
```
finds the polynomial of degree **n** that best fits the data points in the **least-squares** sense (it minimises the sum of the squared vertical distances).

- `n = 1`: a straight line `y = p(1)*x + p(2)`
- `n = 2`: a parabola, and so on
- With **n = number of points - 1**, the polynomial passes **through every point** (but may wiggle wildly between them).
- Evaluate the fit with `polyval(p, xfine)`.
- `[p, S, mu] = polyfit(x, y, n)` also centres and scales x, which helps for large x values (e.g. years).

## How good is the fit?
- **Residuals**: `y - polyval(p, x)`
- **R²** (coefficient of determination): `1 - sum(res.^2) / sum((y - mean(y)).^2)`, closer to 1 is better.
- **Overfitting**: a very high degree follows the noise and gives nonsense between and beyond the data. Choose the **lowest degree** that captures the trend, ideally from the physics of the problem.

## Examples

### Example 1: Fitting a straight line  ([`example_1.m`](example_1.m))

```matlab
V = [0 1 2 3 4 5 6];                       % applied voltage
I = [0.02 0.98 2.05 2.97 4.10 4.95 6.02];  % measured current (mA)
p = polyfit(V, I, 1);
R_kohm = 1 / p(1);
fprintf('I = %.4f V %+.4f  ->  R = %.3f kohm\n', p(1), p(2), R_kohm);
res = I - polyval(p, V);
R2 = 1 - sum(res.^2) / sum((I - mean(I)).^2);
fprintf('R^2 = %.5f\n', R2);
plot(V, I, 'ko', V, polyval(p, V), 'r-')
xlabel('V'); ylabel('I (mA)'); legend('data', 'fit', 'Location', 'northwest'); grid on
```

### Example 2: Choosing the degree (and overfitting)  ([`example_2.m`](example_2.m))

```matlab
x = 0:0.5:5;
y = [0 0.8 2.1 2.9 3.7 3.9 4.1 3.8 3.2 2.1 0.7];
xf = linspace(0, 5, 200);
degrees = [1 2 3 10];
for k = 1:4
    p = polyfit(x, y, degrees(k));
    res = y - polyval(p, x);
    R2 = 1 - sum(res.^2) / sum((y - mean(y)).^2);
    subplot(2, 2, k)
    plot(x, y, 'o', xf, polyval(p, xf))
    title(sprintf('degree %d, R^2 = %.4f', degrees(k), R2))
    ylim([-2 6])
end
```

### Example 3: Forecasting with a quadratic fit  ([`example_3.m`](example_3.m))

```matlab
year = 2015:2023;
demand = [1090 1135 1206 1260 1291 1252 1374 1503 1588];   % TWh (illustrative)
[p, ~, mu] = polyfit(year, demand, 2);    % centring improves accuracy
future = 2024:2026;
forecast = polyval(p, future, [], mu);
for k = 1:numel(future)
    fprintf('%d forecast: %.0f TWh\n', future(k), forecast(k));
end
plot(year, demand, 'bo', [year future], polyval(p, [year future], [], mu), 'r--')
xlabel('Year'); ylabel('TWh'); legend('data', 'quadratic trend'); grid on
```

## Practice

1. Fit a line to `x = 1:10`, `y = 3x + 2 + noise` and compare the slope with 3.
2. Fit polynomials of degree 1 to 5 to a data set and plot R² against the degree.
3. Fit a parabola to the projectile heights `[0 12 20 24 24 20 12]` at `t = 0:6` and estimate g.
4. Why can a degree-9 fit through 10 points be a bad model?

---

[⬅ Day 066](../Day-066-Polynomial-Arithmetic-conv-deconv-polyder-polyint-and-residue/README.md) · [🏠 Home](../README.md) · [Day 068 ➡](../Day-068-Curve-Fitting-with-Functions-Other-than-Polynomials/README.md)
