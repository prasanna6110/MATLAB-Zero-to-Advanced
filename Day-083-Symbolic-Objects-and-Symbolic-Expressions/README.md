# Day 083 · Symbolic Objects and Symbolic Expressions

_Symbolic Math_

## Numeric vs symbolic
So far MATLAB worked with **numbers** (floating point). The **Symbolic Math Toolbox** works with **symbols and exact expressions**, like doing algebra on paper:
- `sqrt(2)` → 1.4142 (numeric, rounded)
- `sqrt(sym(2))` → √2 (symbolic, exact)

## Creating symbolic objects
| Command | Creates |
|---------|---------|
| `syms x y t` | symbolic variables x, y, t |
| `syms a b real` / `positive` | with assumptions (help simplification) |
| `x = sym('x')` | one symbolic variable |
| `c = sym(1)/3` | the exact number 1/3 (not 0.3333) |
| `syms f(x)` | a symbolic **function** f of x |
| `A = sym('a', [2 2])` | a 2×2 matrix of symbols a1_1, a1_2 … |

A **symbolic expression** is anything built from symbolic objects: `E = 2*x^2 + 3*x - 1`. You do **not** need the dot operators for symbols (`x^2` is fine), but they do no harm.

## Finding the variables
`symvar(E)` lists the symbolic variables in an expression in alphabetical order (older versions used `findsym`). When MATLAB has to choose the variable itself (for `diff`, `int`, `solve`), it uses the **default** variable: the one closest to **x** alphabetically.

> **Toolbox:** symbolic math needs the **Symbolic Math Toolbox** in MATLAB. In GNU Octave install the `symbolic` package (`pkg load symbolic`). Every example below runs in both.

## Examples

### Example 1: Exact vs numeric  ([`example_1.m`](example_1.m))

```matlab
% Needs: Symbolic Math Toolbox
a = sqrt(2)                 % a rounded number
b = sqrt(sym(2))            % exact
b^2                         % exactly 2
c = sym(1)/3 + sym(1)/6     % exact fraction 1/2
1/3 + 1/6                   % floating point 0.5000
d = sym(10)^25 + 1          % exact big integers
e = vpa(pi, 40)             % pi to 40 digits
```

### Example 2: Symbolic variables and expressions  ([`example_2.m`](example_2.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x y a b
E = a*x^2 + b*x + 5
F = (x + y)^2
G = E * F;
symvar(G)                   % all the variables, alphabetically
symvar(E, 1)                % the default variable (closest to x)
syms R L C w real
Z = R + 1i*w*L + 1/(1i*w*C)  % an impedance as a formula
```

### Example 3: Symbolic functions and substitution  ([`example_3.m`](example_3.m))

```matlab
% Needs: Symbolic Math Toolbox
syms f(x) t
f(x) = x^3 - 2*x + 1;
f(2)                        % exact value
f(t + 1)                    % substitute an expression
syms V0 tau
v = V0 * (1 - exp(-t/tau));
v_at_tau = subs(v, t, tau)  % value at t = tau
num = subs(v, [V0 tau t], [12 0.5 1])
double(num)                 % convert to an ordinary number
```

## Practice

1. Create the expression `E = (a + b)^3` and list its variables.
2. Compare `sin(pi)` with `sin(sym(pi))`.
3. Define `g(x) = x^2 e^{-x}` as a symbolic function and evaluate it at x = 1 exactly and as a number.
4. Compute `sym(2)^100` exactly.

---

[⬅ Day 082](../Day-082-Animation-in-MATLAB/README.md) · [🏠 Home](../README.md) · [Day 084 ➡](../Day-084-Changing-the-Form-of-an-Expression-expand-factor-collect-simplify-pretty/README.md)
