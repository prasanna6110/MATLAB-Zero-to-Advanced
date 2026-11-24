# Day 068 · Curve Fitting with Functions Other than Polynomials

_Polynomials, Curve Fitting and Interpolation_

## Linearising the model
Many physical laws are not polynomials, but they **become straight lines** after taking logarithms. Fit a line to the transformed data with `polyfit(..., 1)`, then transform the coefficients back.

| Model | Linear form | Fit | Then |
|-------|-------------|-----|------|
| Power `y = b·xᵐ` | ln y = m ln x + ln b | `p = polyfit(log(x), log(y), 1)` | m = p(1), b = e^p(2) |
| Exponential `y = b·e^(mx)` | ln y = m x + ln b | `p = polyfit(x, log(y), 1)` | m = p(1), b = e^p(2) |
| Exponential `y = b·10^(mx)` | log₁₀ y = m x + log₁₀ b | `polyfit(x, log10(y), 1)` | b = 10^p(2) |
| Logarithmic `y = m ln x + b` | already linear in ln x | `polyfit(log(x), y, 1)` | |
| Reciprocal `y = 1/(m x + b)` | 1/y = m x + b | `polyfit(x, 1./y, 1)` | |

## How to choose the model
Plot the data on different axes:
- straight on `loglog` → power function
- straight on `semilogy` → exponential
- straight on `semilogx` → logarithmic
- `1/y` against x straight → reciprocal

Note: fitting the **transformed** data minimises the error of ln y, not of y. For the best fit of y itself use a nonlinear fit (Day 70).

## Examples

### Example 1: Exponential fit: capacitor discharge  ([`example_1.m`](example_1.m))

```matlab
t = 0:0.5:4;
v = [12.0 7.4 4.3 2.7 1.6 0.95 0.58 0.36 0.21];    % measured volts
p = polyfit(t, log(v), 1);
tau = -1 / p(1);
V0 = exp(p(2));
fprintf('v(t) = %.2f e^(-t/%.3f)   -> RC = %.3f s\n', V0, tau, tau);
tf = linspace(0, 4, 200);
subplot(1, 2, 1); plot(t, v, 'ko', tf, V0*exp(-tf/tau), 'r'); title('Linear axes'); grid on
subplot(1, 2, 2); semilogy(t, v, 'ko', tf, V0*exp(-tf/tau), 'r'); title('semilogy: a straight line'); grid on
```

### Example 2: Power-law fit: a fan law  ([`example_2.m`](example_2.m))

```matlab
speed = [600 800 1000 1200 1400];          % rpm
power = [0.52 1.25 2.40 4.20 6.70];        % kW
p = polyfit(log(speed), log(power), 1);
m = p(1); b = exp(p(2));
fprintf('P = %.3g * N^%.2f  (the fan law predicts the exponent 3)\n', b, m);
fprintf('Predicted power at 1500 rpm: %.2f kW\n', b * 1500^m);
loglog(speed, power, 'bo', speed, b*speed.^m, 'r-'); grid on
xlabel('Speed (rpm)'); ylabel('Power (kW)')
```

### Example 3: Choosing between models by trying them all  ([`example_3.m`](example_3.m))

```matlab
x = [1 2 3 4 5 6 7 8];
y = [2.1 3.3 4.0 4.5 4.9 5.3 5.6 5.8];
models = {'linear', 'power', 'exponential', 'logarithmic'};
xx = {x, log(x), x, log(x)};
yy = {y, log(y), log(y), y};
for k = 1:4
    p = polyfit(xx{k}, yy{k}, 1);
    switch k
        case 1, yf = polyval(p, x);
        case 2, yf = exp(p(2)) * x.^p(1);
        case 3, yf = exp(p(2)) * exp(p(1)*x);
        case 4, yf = p(1)*log(x) + p(2);
    end
    sse = sum((y - yf).^2);
    fprintf('%-12s SSE = %.4f\n', models{k}, sse);
end
```

## Practice

1. Fit `y = b e^{mx}` to bacteria counts `[100 180 330 600 1100]` at hours `0:4`. What is the doubling time?
2. Fit a power law to the period of a pendulum against its length.
3. Fit `y = 1/(mx + b)` to data of your choice and plot it.
4. Plot a data set on `semilogy`, `semilogx` and `loglog` and decide which model fits.

---

[⬅ Day 067](../Day-067-Curve-Fitting-with-Polynomials-polyfit/README.md) · [🏠 Home](../README.md) · [Day 069 ➡](../Day-069-Interpolation-interp1-spline-and-interp2/README.md)
