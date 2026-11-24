# Day 086 · Differentiation, Partial Derivatives, Limits and Taylor Series

_Symbolic Math_

## Derivatives: `diff`
| Command | Gives |
|---------|-------|
| `diff(S)` | dS/dx for the default variable |
| `diff(S, t)` | dS/dt |
| `diff(S, n)` or `diff(S, x, n)` | the n-th derivative |
| `diff(S, x, y)` or `diff(diff(S, x), y)` | a mixed partial derivative |
| `jacobian([f; g], [x y])` | the Jacobian matrix |
| `gradient(f, [x y])`, `hessian(f, [x y])` | gradient vector and Hessian (MATLAB) |

(For numbers, `diff` means differences, Day 77. With symbolic input it differentiates.)

## Limits: `limit`
`limit(S, x, a)`, one-sided with `'left'` / `'right'`, and at infinity `limit(S, x, Inf)`.

## Series
- `taylor(S, x, a, 'Order', n)`: the Taylor polynomial around x = a up to (but not including) power n.
- `symsum(term, k, a, b)`: a sum, possibly to infinity.

## Examples

### Example 1: Derivatives  ([`example_1.m`](example_1.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x t
diff(x^3 + 2*x^2 - 5)
diff(sin(x)*x^2)
diff(exp(-2*t)*cos(5*t), t)
diff(x^5, 3)                       % third derivative
f = x^3 - 6*x^2 + 9*x + 1;
crit = solve(diff(f) == 0, x)      % turning points
d2 = subs(diff(f, 2), x, crit)     % positive -> minimum, negative -> maximum
```

### Example 2: Partial derivatives and the Jacobian  ([`example_2.m`](example_2.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x y
g = x^2*y^3 + sin(x*y);
gx = diff(g, x)
gy = diff(g, y)
gxy = diff(diff(g, x), y)
gyx = diff(diff(g, y), x);
simplify(gxy - gyx)                % mixed partials are equal
F = [x^2 + y^2 - 4; exp(x) + y - 1];
J = jacobian(F, [x y])             % used by Newton-Raphson (Day 76)
```

### Example 3: Limits and Taylor series  ([`example_3.m`](example_3.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x n
limit(sin(x)/x, x, 0)
limit((1 + 1/n)^n, n, Inf)         % e
limit(1/x, x, 0, 'right')
limit(1/x, x, 0, 'left')
T = taylor(exp(x), x, 0, 'Order', 5)
T_sin = taylor(sin(x), x, 0, 'Order', 8)
err = double(subs(sin(x) - T_sin, x, 0.5))
```

## Practice

1. Differentiate `ln(x² + 1)` and `tan(x)`.
2. Find the maximum of `x e^{-x}` using `diff` and `solve`.
3. Compute `∂²f/∂x∂y` of `f = e^{xy}`.
4. Find the Taylor series of `cos x` up to x⁶ and compare it with `cos(0.3)`.

---

[⬅ Day 085](../Day-085-Solving-Algebraic-Equations-solve/README.md) · [🏠 Home](../README.md) · [Day 087 ➡](../Day-087-Symbolic-Integration-int/README.md)
