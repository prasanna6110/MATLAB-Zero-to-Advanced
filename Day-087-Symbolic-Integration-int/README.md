# Day 087 · Symbolic Integration: int

_Symbolic Math_

## `int`
| Command | Gives |
|---------|-------|
| `int(S)` | the indefinite integral with respect to the default variable (no "+ C") |
| `int(S, t)` | with respect to t |
| `int(S, a, b)` | the definite integral from a to b (default variable) |
| `int(S, t, a, b)` | definite, with respect to t |
| `int(S, x, 0, Inf)` | improper integrals |

- If MATLAB cannot find a closed form, it returns the integral unevaluated; then use `double()` / `vpa()` on the definite integral or the numeric `integral`.
- The limits can be symbolic: `int(x^2, 0, a)` → a³/3.
- Multiple integrals: nest `int` calls.

Applications: area, volume, work, energy, charge, average and RMS values, centroids, probability.

## Examples

### Example 1: Indefinite and definite integrals  ([`example_1.m`](example_1.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x t a
int(x^2 + 3*x)
int(x*exp(x))                      % integration by parts
int(1/(1 + x^2))
int(cos(a*t), t)
int(x^2, 0, 2)
int(x^2, 0, a)                     % a symbolic limit
int(exp(-x), 0, Inf)               % improper
int(exp(-x^2), -Inf, Inf)          % sqrt(pi)
```

### Example 2: RMS and average values exactly  ([`example_2.m`](example_2.m))

```matlab
% Needs: Symbolic Math Toolbox
syms t Vm w T positive
v = Vm*sin(w*t);
T0 = 2*pi/w;
Vrms = simplify(sqrt(int(v^2, t, 0, T0) / T0))     % Vm/sqrt(2)
Vavg_half = simplify(int(v, t, 0, T0/2) / (T0/2))  % 2 Vm / pi
% Energy stored in an inductor: integral of v*i
syms L I0 tau positive
i = I0*(1 - exp(-t/tau));
E_final = limit(int(L*diff(i, t)*i, t, 0, T), T, Inf)
```

### Example 3: Area between curves and a double integral  ([`example_3.m`](example_3.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x y
f = x + 2;  g = x^2;
xs = solve(f == g, x)                         % intersection points
A = int(f - g, x, min(xs), max(xs))           % area between the curves
double(A)
V = int(int(x*y, y, 0, x), x, 0, 1)           % double integral over a triangle
```

## Practice

1. Integrate `x² sin x` and check by differentiating the answer.
2. Compute `∫₀^∞ x e^{-x} dx`.
3. Find the area enclosed between `y = x²` and `y = √x`.
4. Find the RMS value of a full-wave rectified sine symbolically.

---

[⬅ Day 086](../Day-086-Differentiation-Partial-Derivatives-Limits-and-Taylor-Series/README.md) · [🏠 Home](../README.md) · [Day 088 ➡](../Day-088-Solving-Ordinary-Differential-Equations-Symbolically-dsolve/README.md)
