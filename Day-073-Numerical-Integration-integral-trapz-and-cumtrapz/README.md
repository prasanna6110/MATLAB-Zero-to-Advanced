# Day 073 · Numerical Integration: integral, trapz and cumtrapz

_Numerical Analysis_

## Integrating a function
```matlab
q = integral(fun, a, b)            % MATLAB R2012a+ (recommended)
q = quad(fun, a, b)                % older, adaptive Simpson
q = quadl(fun, a, b)               % older, adaptive Lobatto
```
- `fun` must accept a **vector** of x (use `.*`, `./`, `.^`). For a function that does not, add `'ArrayValued', true`.
- The limits can be `Inf`: `integral(@(x) exp(-x.^2), -Inf, Inf)`.
- `'AbsTol'`, `'RelTol'` control the accuracy.

## Integrating measured data
| Function | Gives |
|----------|-------|
| `trapz(x, y)` | the area under the data points (trapezoidal rule) |
| `cumtrapz(x, y)` | the running integral (one value per point) |

## Double and triple integrals
`integral2(@(x, y) ..., xmin, xmax, ymin, ymax)` and `integral3`. The y-limits may be functions of x: `integral2(f, 0, 1, 0, @(x) x)`.

Typical uses: energy from power, charge from current, area and volume, average and RMS values, work from force, probabilities.

## Examples

### Example 1: integral of functions, including infinite limits  ([`example_1.m`](example_1.m))

```matlab
q1 = integral(@(x) 0.8*x.*exp(-0.2*x), 0, 8)
q2 = integral(@(x) exp(-x.^2), -Inf, Inf)       % sqrt(pi)
sqrt(pi)
q3 = integral(@(x) 1 ./ (1 + x.^2), 0, 1)       % pi/4
% RMS value of a 325 V peak sine over one period
T = 0.02;
Vrms = sqrt(integral(@(t) (325*sin(2*pi*50*t)).^2, 0, T) / T);
fprintf('Vrms = %.2f V (325/sqrt(2) = %.2f)\n', Vrms, 325/sqrt(2));
```

### Example 2: Energy from measured power data  ([`example_2.m`](example_2.m))

```matlab
hours = 0:24;
P_kW = [18 16 15 15 16 20 28 40 52 58 60 61 62 60 58 57 59 66 75 70 55 40 30 22 18];
E = trapz(hours, P_kW);
fprintf('Energy in the day: %.1f kWh, average load %.1f kW\n', E, E/24);
E_running = cumtrapz(hours, P_kW);
plot(hours, E_running, 'LineWidth', 1.5); grid on
xlabel('Hour'); ylabel('Cumulative energy (kWh)')
h_half = interp1(E_running, hours, E/2);
fprintf('Half of the energy was used by hour %.1f\n', h_half);
```

### Example 3: Double integrals and comparing methods  ([`example_3.m`](example_3.m))

```matlab
% Volume under z = x*y over the triangle 0<=x<=1, 0<=y<=x  (exact 1/8)
V = integral2(@(x, y) x.*y, 0, 1, 0, @(x) x)
% Area of a circle of radius 2 by integrating 1 over the disc
A = integral2(@(x, y) ones(size(x)), -2, 2, @(x) -sqrt(4 - x.^2), @(x) sqrt(4 - x.^2))
% trapz accuracy improves with more points
exact = 2;      % integral of sin from 0 to pi
for n = [5 10 50 200]
    x = linspace(0, pi, n);
    fprintf('n = %3d: trapz error = %.2e\n', n, abs(trapz(x, sin(x)) - exact));
end
```

## Practice

1. Compute `∫₀² (x³ + 2x) dx` with `integral` and by hand.
2. A current `i(t) = 5e^{-2t}` A flows into a capacitor. Find the charge delivered in the first 3 s.
3. Find the average value of `|sin(t)|` over one period.
4. Use `integral2` to find the volume under `z = 4 - x² - y²` over the square [-1, 1]².

---

[⬅ Day 072](../Day-072-Finding-a-Minimum-or-a-Maximum-fminbnd-and-fminsearch/README.md) · [🏠 Home](../README.md) · [Day 074 ➡](../Day-074-Ordinary-Differential-Equations-ode45/README.md)
