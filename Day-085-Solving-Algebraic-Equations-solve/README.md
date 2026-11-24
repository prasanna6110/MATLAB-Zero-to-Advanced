# Day 085 · Solving Algebraic Equations: solve

_Symbolic Math_

## One equation
```matlab
syms x
sol = solve(x^2 - 5*x + 6 == 0, x)     % [2; 3]
```
- Write the equation with `==`. If you give only an expression, MATLAB solves **expression = 0**.
- The second input says which variable to solve for; the answer is in terms of the others: `solve(a*x^2 + b*x + c == 0, x)` gives the quadratic formula.
- The result can be exact numbers, expressions, or `root(...)` objects. Use `double(sol)` or `vpa(sol)` for decimals.
- For equations with infinitely many solutions (trig), you get the principal ones; use `'ReturnConditions', true` (MATLAB) for the general solution.
- When no exact solution exists, use `vpasolve(eq, x, guess)` or the numeric `fzero`.

## Systems of equations
```matlab
[sx, sy] = solve(eq1, eq2, x, y)      % separate outputs
S = solve([eq1, eq2], [x, y]);  S.x, S.y   % a structure (MATLAB)
```

## Examples

### Example 1: Solving single equations  ([`example_1.m`](example_1.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x a b c
solve(x^2 - 5*x + 6 == 0, x)
solve(a*x^2 + b*x + c == 0, x)          % the quadratic formula
r = solve(x^3 + x - 1 == 0, x);         % roots that have no nice form
double(r)
solve(exp(2*x) == 7, x)
solve(sin(x) == 1/2, x)                 % the principal solution
```

### Example 2: Systems of equations  ([`example_2.m`](example_2.m))

```matlab
% Needs: Symbolic Math Toolbox
syms x y z
[sx, sy] = solve(x + y == 10, x - y == 2, x, y)
[px, py] = solve(x^2 + y^2 == 25, x + y == 7, x, y)      % two solutions
[I1, I2, I3] = solve(6*x - 4*y == 12, -4*x + 13*y - 3*z == 0, -3*y + 8*z == -6, x, y, z);
fprintf('Mesh currents: %s A\n', mat2str(double([I1 I2 I3]), 5));
```

### Example 3: Solving a formula for any variable  ([`example_3.m`](example_3.m))

```matlab
% Needs: Symbolic Math Toolbox
syms R L C f w0 V P I
f_res = 1/(2*sym(pi)*sqrt(L*C));
C_needed = solve(f == f_res, C)                 % C for a resonant frequency f
double(subs(C_needed, [f L], [50 0.1]))         % farad for 50 Hz with 100 mH
I_from_P = solve(P == I^2*R, I)                 % two signs
syms Ts k                                       % temperature after time t (cooling law)
syms T0 Ta t positive
T = Ta + (T0 - Ta)*exp(-k*t);
t_needed = solve(T == Ts, t)
```

## Practice

1. Solve `2x² + 3x - 2 = 0` symbolically and check with `roots`.
2. Solve the system `x + 2y - z = 4, 2x - y + 3z = 9, 3x + y + z = 10`.
3. Solve `V = I R` and `P = V I` for R and I in terms of P and V.
4. Find the intersection points of `y = x²` and `y = 2x + 3`.

---

[⬅ Day 084](../Day-084-Changing-the-Form-of-an-Expression-expand-factor-collect-simplify-pretty/README.md) · [🏠 Home](../README.md) · [Day 086 ➡](../Day-086-Differentiation-Partial-Derivatives-Limits-and-Taylor-Series/README.md)
