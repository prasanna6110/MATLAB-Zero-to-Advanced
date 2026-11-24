# Day 088 · Solving Ordinary Differential Equations Symbolically: dsolve

_Symbolic Math_

## `dsolve`
```matlab
syms y(t)
ode = diff(y, t) == -2*y + 4;
ySol = dsolve(ode)                    % the general solution, with constants C1, C2...
ySol = dsolve(ode, y(0) == 1)         % with an initial condition
```
- For a **second-order** ODE, give two conditions. Write the derivative condition with a helper: `Dy = diff(y, t); conds = [y(0) == 0, Dy(0) == 1];`.
- **Systems**: `syms x(t) y(t)`, then `[xs, ys] = dsolve(eqns, conds)`.
- Many nonlinear ODEs have no closed-form solution; then `dsolve` gives a warning or an empty result, and you use the numeric `ode45` (Day 74).
- Old syntax with text (`dsolve('Dy = -2*y + 4', 'y(0) = 1')`) is no longer supported in new MATLAB.

Symbolic solutions show the **structure** of the answer (time constants, natural frequency, damping), which numeric solutions only show as numbers.

## Examples

### Example 1: First-order ODEs  ([`example_1.m`](example_1.m))

```matlab
% Needs: Symbolic Math Toolbox
syms y(t)
dsolve(diff(y, t) == -2*y)                       % general solution
dsolve(diff(y, t) == -2*y + 4, y(0) == 1)        % with an initial value
syms v(t) R C Vs
vC = dsolve(diff(v, t) == (Vs - v)/(R*C), v(0) == 0)   % RC charging
```

### Example 2: Second-order ODE: an RLC circuit  ([`example_2.m`](example_2.m))

```matlab
% Needs: Symbolic Math Toolbox
syms q(t)
Dq = diff(q, t);
R = 6; L = 1; C = sym(1)/25; V = 10;              % numbers chosen for a neat answer
ode = L*diff(q, t, 2) + R*Dq + q/C == V;
qs = dsolve(ode, [q(0) == 0, Dq(0) == 0]);
i_t = simplify(diff(qs, t))
vC = simplify(qs / C)
fh = matlabFunction(vC);
fprintf('vC at t = 0.5 s: %.4f V (final value %d V)\n', fh(0.5), V);
```

### Example 3: A system of two ODEs  ([`example_3.m`](example_3.m))

```matlab
% MATLAB-ONLY: GNU Octave's dsolve returns systems in a different form
% Needs: Symbolic Math Toolbox
syms x(t) y(t)
eqs = [diff(x, t) == y, diff(y, t) == -x];       % simple harmonic motion
[xs, ys] = dsolve(eqs, [x(0) == 1, y(0) == 0])
check = simplify(xs^2 + ys^2)                    % stays 1: the motion is a circle
```

## Practice

1. Solve `dy/dt = 3y` with y(0) = 2.
2. Solve `y'' + 4y = 0` with y(0) = 1, y'(0) = 0.
3. Solve the RL circuit `L di/dt + R i = V`, i(0) = 0 symbolically.
4. Compare a `dsolve` solution with an `ode45` solution on the same plot.

---

[⬅ Day 087](../Day-087-Symbolic-Integration-int/README.md) · [🏠 Home](../README.md) · [Day 089 ➡](../Day-089-Plotting-Symbolic-Expressions-and-Numerical-Calculations/README.md)
