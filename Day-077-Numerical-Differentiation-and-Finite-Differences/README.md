# Day 077 · Numerical Differentiation and Finite Differences

_Numerical Analysis_

## Derivatives from data
| Formula | Order | MATLAB |
|---------|-------|--------|
| forward: (y(k+1) - y(k)) / h | O(h) | `diff(y) ./ diff(x)` (one element shorter) |
| backward: (y(k) - y(k-1)) / h | O(h) | |
| central: (y(k+1) - y(k-1)) / (2h) | O(h²) | `gradient(y, h)` (same length, central inside) |
| second derivative: (y(k+1) - 2y(k) + y(k-1)) / h² | O(h²) | `del2(y, h)*4` in 1-D, or `diff(y, 2)/h^2` |

- `diff(y, n)` gives the n-th difference.
- `gradient(Z, hx, hy)` returns both partial derivatives of a 2-D grid.

## The step-size trade-off
A smaller h reduces the **truncation error**, but if h is too small the **round-off error** grows because you subtract nearly equal numbers. For first derivatives with doubles, h ≈ 1e-5 to 1e-8 is typical.

**Noise** is amplified by differentiation: smooth the data first (`movmean`, a polynomial fit) before differentiating measured signals.

## Finite differences for ODEs and PDEs
Replacing derivatives by differences turns differential equations into algebraic equations (e.g. heat conduction, Project days). Euler's method `y(k+1) = y(k) + h f(t(k), y(k))` is the simplest ODE solver.

## Examples

### Example 1: diff vs gradient on a known function  ([`example_1.m`](example_1.m))

```matlab
h = 0.1;
x = 0:h:2;
y = x.^3;
exact = 3*x.^2;
d_forward = diff(y) / h;                 % length n-1
d_central = gradient(y, h);              % length n
fprintf('max error forward : %.4f\n', max(abs(d_forward - exact(1:end-1))));
fprintf('max error central : %.4f (inside points: %.4f)\n', max(abs(d_central - exact)), max(abs(d_central(2:end-1) - exact(2:end-1))));
plot(x, exact, 'k', x(1:end-1), d_forward, 'r--', x, d_central, 'b:', 'LineWidth', 1.4)
legend('exact 3x^2', 'forward', 'central', 'Location', 'northwest'); grid on
```

### Example 2: The step-size trade-off  ([`example_2.m`](example_2.m))

```matlab
f = @sin; x0 = 1; exact = cos(1);
hs = 10.^(-1:-1:-14);
err_fwd = abs((f(x0 + hs) - f(x0)) ./ hs - exact);
err_cen = abs((f(x0 + hs) - f(x0 - hs)) ./ (2*hs) - exact);
loglog(hs, err_fwd, 'o-', hs, err_cen, 's-'); grid on
xlabel('step h'); ylabel('error'); legend('forward', 'central')
[~, k1] = min(err_fwd); [~, k2] = min(err_cen);
fprintf('Best h: forward %.0e (error %.1e), central %.0e (error %.1e)\n', hs(k1), err_fwd(k1), hs(k2), err_cen(k2));
```

### Example 3: Velocity and acceleration from position data, and Euler's method  ([`example_3.m`](example_3.m))

```matlab
t = 0:0.05:2;
rng(6);
pos = 4.9*t.^2 + 0.002*randn(size(t));     % a falling object with tiny noise
vel = gradient(pos, 0.05);
acc = gradient(vel, 0.05);
fprintf('Mean acceleration from data: %.2f m/s^2 (true 9.8)\n', mean(acc(5:end-5)));
% Euler's method for dy/dt = -2y, y(0) = 1
for h = [0.5 0.1 0.01]
    tt = 0:h:2; y = zeros(size(tt)); y(1) = 1;
    for k = 1:numel(tt) - 1
        y(k + 1) = y(k) + h * (-2*y(k));
    end
    fprintf('h = %.2f: y(2) = %.5f (exact %.5f)\n', h, y(end), exp(-4));
end
```

## Practice

1. Compute the derivative of `e^x` at x = 0 with forward and central differences for h = 0.1, 0.01, 0.001.
2. From the voltage data of a charging capacitor, find the current `i = C dv/dt`.
3. Show that the forward error is roughly proportional to h and the central error to h².
4. Solve `dy/dt = t - y` with Euler's method and compare with `ode45`.

---

[⬅ Day 076](../Day-076-Systems-of-Nonlinear-Equations-fsolve-and-Newton-Raphson/README.md) · [🏠 Home](../README.md) · [Day 078 ➡](../Day-078-Three-Dimensional-Line-Plots-plot3/README.md)
