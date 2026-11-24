# Day 084 · Changing the Form of an Expression: expand, factor, collect, simplify, pretty

_Symbolic Math_

## Rewriting an expression
| Command | Does | Example |
|---------|------|---------|
| `expand(S)` | multiplies out products and powers; uses trig and exp identities | `(x+1)^2` → `x^2 + 2x + 1` |
| `factor(S)` | writes a polynomial as a product of factors | `x^2 - 5x + 6` → `(x-2)(x-3)` |
| `collect(S, x)` | groups the terms by powers of x | `x*y + x` → `x(y + 1)` |
| `simplify(S)` | tries many rules and returns the simplest form | `sin(x)^2 + cos(x)^2` → `1` |
| `combine(S)`, `rewrite(S, 'exp')` | combine or rewrite terms | |
| `partfrac(S, x)` | partial fractions | |
| `numden(S)` | the numerator and denominator | |
| `pretty(S)` | shows the expression in a maths-like layout | |
| `latex(S)` | the LaTeX code for reports | |

The old `simple` command (which tried several forms) has been removed from modern MATLAB: use `simplify`. `collect` is not yet available in GNU Octave's symbolic package.

Assumptions change what can be simplified: `sqrt(x^2)` simplifies to `x` only if x is known to be positive (`syms x positive`).

## Examples

### Example 1: expand and factor  ([`example_1.m`](example_1.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x y a
expand((x + 2)^3)
expand((x - y)*(x + y))
expand(sin(x + y))                 % trig identity
expand(exp(a + x))
factor(x^2 - 5*x + 6)
factor(x^3 - 8)
factor(sym(360))                   % prime factors of a number
```

### Example 2: simplify, pretty and latex  ([`example_2.m`](example_2.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x
simplify(sin(x)^2 + cos(x)^2)
simplify((x^2 - 1)/(x - 1))
simplify(cos(x)^4 - sin(x)^4)
S = (x^2 + 3*x)/(x^3 - x);
pretty(S)
pretty(simplify(S))
latex(x^2/(1 + sqrt(x)))
syms p positive
simplify(sqrt(p^2))                % = p, because p > 0
```

### Example 3: collect and partfrac  ([`example_3.m`](example_3.m))

```matlab
% MATLAB-ONLY: collect and partfrac are not in GNU Octave's symbolic package
syms x y s
collect((x + y)^2*(x - 1), x)
collect((x + y)^2*(x - 1), y)
F = (2*s + 3)/(s^2 + 3*s + 2);
partfrac(F, s)
[n, d] = numden(F)
```

## Practice

1. Expand `(2x - 3)⁴` and factor the result back.
2. Simplify `(x³ - 1)/(x - 1)`.
3. Use `pretty` and `latex` on the quadratic formula `(-b + sqrt(b^2 - 4ac))/(2a)`.
4. Show that `cos(2x) - (cos²x - sin²x)` simplifies to 0.

---

[⬅ Day 083](../Day-083-Symbolic-Objects-and-Symbolic-Expressions/README.md) · [🏠 Home](../README.md) · [Day 085 ➡](../Day-085-Solving-Algebraic-Equations-solve/README.md)
