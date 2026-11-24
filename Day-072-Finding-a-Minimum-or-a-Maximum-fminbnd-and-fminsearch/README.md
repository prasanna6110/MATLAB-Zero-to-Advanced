# Day 072 · Finding a Minimum or a Maximum: fminbnd and fminsearch

_Numerical Analysis_

## `fminbnd`: one variable on an interval
```matlab
[x, fval] = fminbnd(fun, x1, x2)
```
finds the **minimum** of a function of one variable between x1 and x2. It can return a **local** minimum or the minimum at an end point; plot the function first.

## Maximum
There is no `fmaxbnd`: find the minimum of **-f(x)**.
```matlab
[x, negmax] = fminbnd(@(x) -f(x), a, b);
fmax = -negmax;
```

## `fminsearch`: several variables, no limits
```matlab
[x, fval] = fminsearch(@(v) cost(v(1), v(2)), [x0 y0])
```
- Uses the Nelder-Mead simplex method, no derivatives needed, in core MATLAB.
- The function takes **one vector** of variables.
- Constrained problems need `fmincon`; linear programmes `linprog` (Optimization Toolbox). Global search: `ga`, `particleswarm` (Global Optimization Toolbox).

## Examples

### Example 1: Minimum and maximum of a function  ([`example_1.m`](example_1.m))

```matlab
f = @(x) x.^3 - 12*x.^2 + 40.25*x - 36.5;
fplot(f, [0 10]); grid on; hold on
[xmin, fmin] = fminbnd(f, 3, 8);
[xmax, negfmax] = fminbnd(@(x) -f(x), 0, 4);
plot(xmin, fmin, 'gv', xmax, -negfmax, 'r^', 'MarkerSize', 10, 'MarkerFaceColor', 'auto'); hold off
fprintf('Local minimum %.4f at x = %.4f\n', fmin, xmin);
fprintf('Local maximum %.4f at x = %.4f\n', -negfmax, xmax);
[x2, f2] = fminbnd(f, 0, 10)          % still the LOCAL minimum near 5.6...
fprintf('but f(0) = %.1f is lower: always check the end points too!\n', f(0));
```

### Example 2: Maximum power transfer  ([`example_2.m`](example_2.m))

```matlab
Vs = 12; Rs = 8;                       % source voltage and internal resistance
P = @(RL) Vs^2 * RL ./ (Rs + RL).^2;
[RL_best, negP] = fminbnd(@(RL) -P(RL), 0.1, 50);
fprintf('Maximum power %.3f W when RL = %.3f ohm (theory: RL = Rs = %d)\n', -negP, RL_best, Rs);
fplot(P, [0 50]); xlabel('R_L (\Omega)'); ylabel('P (W)'); grid on
% A box from a 30 cm x 20 cm sheet: cut squares of side x, maximise the volume
V = @(x) x .* (30 - 2*x) .* (20 - 2*x);
[xb, negV] = fminbnd(@(x) -V(x), 0, 10);
fprintf('Best cut %.3f cm gives volume %.1f cm^3\n', xb, -negV);
```

### Example 3: Several variables with fminsearch  ([`example_3.m`](example_3.m))

```matlab
% Minimum of the "banana" (Rosenbrock) function, a classic test
banana = @(v) 100*(v(2) - v(1)^2)^2 + (1 - v(1))^2;
[v, fv] = fminsearch(banana, [-1.2 1]);
fprintf('Minimum at (%.4f, %.4f), value %.2e\n', v, fv);
% Cheapest location for a warehouse serving 4 shops (sum of distances)
shops = [0 0; 10 0; 10 8; 2 9];
total_dist = @(p) sum(sqrt(sum((shops - p).^2, 2)));
best = fminsearch(total_dist, mean(shops));
fprintf('Warehouse at (%.2f, %.2f), total distance %.2f km\n', best, total_dist(best));
```

## Practice

1. Find the minimum of `f(x) = x² - 6x + 11` with `fminbnd` and check it by calculus.
2. A cylindrical can must hold 500 cm³. Find the radius that uses the least sheet metal.
3. Find the maximum of `x e^{-x}` on [0, 5].
4. Use `fminsearch` to find the point closest to the origin on the line `x + 2y = 10`.

---

[⬅ Day 071](../Day-071-Solving-an-Equation-with-One-Variable-fzero/README.md) · [🏠 Home](../README.md) · [Day 073 ➡](../Day-073-Numerical-Integration-integral-trapz-and-cumtrapz/README.md)
