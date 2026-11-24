# Day 070 · The Basic Fitting Interface and Nonlinear Least-Squares Fits

_Polynomials, Curve Fitting and Interpolation_

## The Basic Fitting tool
In a **Figure** window with plotted data: **Tools → Basic Fitting**. You can:
- tick fit types (linear, quadratic, cubic … up to 10th degree, spline, shape-preserving)
- show the **equation** on the plot and the **norm of residuals**
- plot the **residuals**
- **evaluate** the fit at new x values
- export the fit coefficients to the workspace

## Nonlinear fits: minimise the error directly
When the model cannot be linearised (or you want the true least-squares fit of y), define the **sum of squared errors** as a function of the parameters and minimise it:
```matlab
model = @(c, x) c(1) * (1 - exp(-c(2) * x));
sse = @(c) sum((y - model(c, x)).^2);
c = fminsearch(sse, [1 1]);          % start from a guess
```
- `fminsearch` is in core MATLAB (no toolbox).
- `lsqcurvefit(model, c0, x, y)` (Optimization Toolbox) is faster and gives more information.
- `fit(x, y, 'exp1')` and the **Curve Fitter app** (Curve Fitting Toolbox) offer a library of models (exponential, Gaussian, Fourier, sum of sines, smoothing splines) with confidence bounds.

A good **starting guess** matters: nonlinear fits can get stuck in a local minimum.

## Examples

### Example 1: A nonlinear fit with fminsearch  ([`example_1.m`](example_1.m))

```matlab
t = 0:0.5:6;
y = [0 2.9 4.9 6.3 7.3 7.9 8.4 8.7 8.9 9.1 9.1 9.2 9.2];   % a first-order step response
model = @(c, t) c(1) * (1 - exp(-t / c(2)));
sse = @(c) sum((y - model(c, t)).^2);
c = fminsearch(sse, [5 1]);
fprintf('Final value K = %.3f, time constant tau = %.3f s\n', c(1), c(2));
tf = linspace(0, 6, 200);
plot(t, y, 'ko', tf, model(c, tf), 'r-'); grid on
xlabel('t (s)'); legend('data', 'fit', 'Location', 'southeast')
title(sprintf('y = %.2f(1 - e^{-t/%.2f})', c(1), c(2)))
```

### Example 2: Fitting a damped oscillation  ([`example_2.m`](example_2.m))

```matlab
rng(3);
t = linspace(0, 4, 60);
true_c = [5 0.8 6 0.3];                                   % A, decay, w, phase
model = @(c, t) c(1) * exp(-c(2)*t) .* cos(c(3)*t + c(4));
y = model(true_c, t) + 0.15*randn(size(t));
sse = @(c) sum((y - model(c, t)).^2);
c = fminsearch(sse, [4 1 5.5 0], optimset('MaxFunEvals', 5000, 'MaxIter', 5000));
fprintf('Fitted A = %.2f, alpha = %.2f, w = %.2f rad/s, phase = %.2f\n', c);
plot(t, y, 'b.', t, model(c, t), 'r-'); grid on
legend('noisy data', 'fit')
```

### Example 3: Toolbox fits: lsqcurvefit and fit  ([`example_3.m`](example_3.m))

```matlab
% MATLAB-ONLY: needs the Optimization and Curve Fitting toolboxes
% Needs: Optimization Toolbox, Curve Fitting Toolbox
x = (0:0.5:5)';
y = 3*exp(-0.7*x) + 0.5 + 0.05*randn(size(x));
model = @(c, x) c(1)*exp(-c(2)*x) + c(3);
c = lsqcurvefit(model, [1 1 0], x, y)
f = fit(x, y, 'exp2')          % a library model: a*exp(b*x) + c*exp(d*x)
plot(f, x, y)
```

## Practice

1. Plot some data, open **Tools → Basic Fitting**, try 3 fit types and show the residuals.
2. Fit `y = a / (1 + b e^{-c t})` (a logistic curve) to growth data with `fminsearch`.
3. Compare the linearised exponential fit (Day 68) with an `fminsearch` fit on the same data.
4. What happens to `fminsearch` with a very bad starting guess? Try it.

---

[⬅ Day 069](../Day-069-Interpolation-interp1-spline-and-interp2/README.md) · [🏠 Home](../README.md) · [Day 071 ➡](../Day-071-Solving-an-Equation-with-One-Variable-fzero/README.md)
