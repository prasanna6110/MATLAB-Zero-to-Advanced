# Day 089 · Plotting Symbolic Expressions and Numerical Calculations

_Symbolic Math_

## Plotting
- In MATLAB: `fplot(S, [a b])` plots a symbolic expression directly; `fsurf`, `fcontour`, `fmesh`, `fplot3`, `fimplicit` for 3-D and implicit plots. (`ezplot` is the older command.)
- Portable: convert it to a normal function handle first, then use `fplot`/`plot`:
  ```matlab
  fh = matlabFunction(S);     % S in x  ->  @(x) ...
  fplot(fh, [0 5])
  ```

## From symbols to numbers
| Command | Gives |
|---------|-------|
| `subs(S, x, 2)` | substitute a value (or an expression) |
| `subs(S, {x, y}, {1, 2})` or `subs(S, [x y], [1 2])` | several at once |
| `double(S)` | an ordinary double number (S must have no free symbols) |
| `vpa(S, d)` | a high-precision decimal with d digits |
| `matlabFunction(S)` | a fast numeric function handle (can also write a `.m` file) |
| `char(S)` / `string(S)` | the expression as text |

`matlabFunction` is the best way to use a symbolic result in loops, `ode45`, `fzero`, optimisation or a large vector of points: it is much faster than calling `subs` many times.

## Examples

### Example 1: From a symbolic result to a plot  ([`example_1.m`](example_1.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x
f = x^3 - 6*x^2 + 9*x + 1;
df = diff(f);
fh = matlabFunction(f);
dfh = matlabFunction(df);
fplot(fh, [-0.5 4.5]); hold on
fplot(dfh, [-0.5 4.5], '--'); hold off
grid on; legend('f(x)', 'f''(x)')
crit = double(solve(df == 0, x));
fprintf('Turning points at x = %s\n', mat2str(crit', 4));
```

### Example 2: subs, double and vpa  ([`example_2.m`](example_2.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x y
E = x^2*y + sqrt(x + y);
subs(E, x, 3)                           % still has y
v = subs(E, [x y], [3 1])               % exact: 9 + 2
double(v)
vpa(sym(pi)*sqrt(sym(2)), 25)
r = vpasolve(x^5 - x - 1 == 0, x, 1)   % no closed form: solve numerically near 1
double(r)
```

### Example 3: Fast numeric evaluation with matlabFunction  ([`example_3.m`](example_3.m))

```matlab
% Needs: Symbolic Math Toolbox
syms t w zeta positive
step_resp = 1 - exp(-zeta*w*t)*(cos(w*sqrt(1 - zeta^2)*t) + zeta/sqrt(1 - zeta^2)*sin(w*sqrt(1 - zeta^2)*t));
g = matlabFunction(step_resp, 'Vars', [t w zeta]);   % fixes the order of the inputs
tt = linspace(0, 3, 300);
hold on
for z = [0.2 0.5 0.8]
    plot(tt, g(tt, 5, z), 'DisplayName', sprintf('\\zeta = %.1f', z));
end
hold off; grid on; legend show
xlabel('t (s)'); title('Second-order step responses (\omega_n = 5 rad/s)')
peak = max(g(tt, 5, 0.2));
fprintf('Overshoot for zeta = 0.2: %.1f %% (theory %.1f %%)\n', 100*(peak - 1), 100*exp(-0.2*pi/sqrt(1 - 0.04)));
```

## Practice

1. Plot `sin(x)/x` symbolically on [-20, 20].
2. Substitute x = π/6 into `sin(x)^2 + cos(2x)` and get the exact value.
3. Compute `e` to 50 digits with `vpa(exp(sym(1)), 50)`.
4. Turn a symbolic integral result into a function with `matlabFunction` and plot it.

---

[⬅ Day 088](../Day-088-Solving-Ordinary-Differential-Equations-Symbolically-dsolve/README.md) · [🏠 Home](../README.md) · [Day 090 ➡](../Day-090-Laplace-and-Fourier-Transforms/README.md)
