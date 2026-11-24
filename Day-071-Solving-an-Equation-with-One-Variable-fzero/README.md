# Day 071 · Solving an Equation with One Variable: fzero

_Numerical Analysis_

## `fzero`
Finds a value of x where **f(x) = 0** (a root).
```matlab
x = fzero(fun, x0)
```
- `fun`: a function handle, e.g. `@(x) x.*exp(-x) - 0.2`
- `x0`: a starting guess **near** the root, or an interval `[a b]` where f changes sign (more reliable)
- To solve `f(x) = c`, write it as `f(x) - c = 0`.
- `[x, fval, exitflag] = fzero(...)`: `fval` should be ~0 and `exitflag > 0` means success.
- `optimset('TolX', 1e-12, 'Display', 'iter')` controls the accuracy and shows each step.

## Tips
1. **Plot the function first** to see how many roots there are and where.
2. `fzero` finds **one** root, the one near x0. Call it several times with different guesses for several roots.
3. It finds a root only where the function **crosses** zero. Roots that just touch zero (like x² at 0) may fail.
4. For polynomials use `roots` to get all roots at once.

## Examples

### Example 1: Plot first, then find each root  ([`example_1.m`](example_1.m))

```matlab
f = @(x) x .* exp(-x) - 0.2;
fplot(f, [0 8]); grid on; hold on
r1 = fzero(f, 0.5);
r2 = fzero(f, [1 5]);              % an interval with a sign change
plot([r1 r2], [0 0], 'ro', 'MarkerFaceColor', 'r'); hold off
fprintf('Roots: %.6f and %.6f\n', r1, r2);
[x, fval, flag] = fzero(f, 3)
```

### Example 2: Solving engineering equations  ([`example_2.m`](example_2.m))

```matlab
% 1) Diode circuit: 5 = 1000*I + 0.0259*ln(I/1e-12)
diode = @(I) 1000*I + 0.0259*log(I/1e-12) - 5;
I = fzero(diode, [1e-6 5e-3]);
fprintf('Diode current %.4f mA, diode voltage %.4f V\n', I*1000, 5 - 1000*I);
% 2) Time for an RC circuit to charge to 90%
tau = 0.47;
t90 = fzero(@(t) 1 - exp(-t/tau) - 0.9, 1);
fprintf('Reaches 90%% at t = %.4f s (= %.3f tau)\n', t90, t90/tau);
% 3) Kepler-type equation: E - 0.3 sin E = 1.2
E = fzero(@(E) E - 0.3*sin(E) - 1.2, 1);
fprintf('E = %.6f rad\n', E);
```

### Example 3: Watching fzero iterate, and the roots of a polynomial  ([`example_3.m`](example_3.m))

```matlab
opts = optimset('Display', 'iter', 'TolX', 1e-10);
x = fzero(@(x) cos(x) - x, [0 1], opts);
fprintf('cos(x) = x at x = %.10f\n', x);
p = [1 -2 -5 6];
fprintf('roots: %s\n', mat2str(roots(p)', 6));
fprintf('fzero near 0: %.6f\n', fzero(@(x) polyval(p, x), 0));
```

## Practice

1. Solve `x³ - 2x - 5 = 0` with `fzero` and compare with `roots`.
2. Find all solutions of `sin(x) = 0.3x` (plot first to see how many).
3. A loan of Rs 5 lakh is repaid with EMI Rs 11 000 for 60 months. Find the monthly interest rate with `fzero`.
4. Why might `fzero(@(x) x.^2, 1)` fail?

---

[⬅ Day 070](../Day-070-The-Basic-Fitting-Interface-and-Nonlinear-Least-Squares-Fits/README.md) · [🏠 Home](../README.md) · [Day 072 ➡](../Day-072-Finding-a-Minimum-or-a-Maximum-fminbnd-and-fminsearch/README.md)
