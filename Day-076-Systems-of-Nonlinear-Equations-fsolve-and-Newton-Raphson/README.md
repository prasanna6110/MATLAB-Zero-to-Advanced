# Day 076 · Systems of Nonlinear Equations: fsolve and Newton-Raphson

_Numerical Analysis_

## Linear vs nonlinear systems
- **Linear** systems `A x = b`: use `x = A \ b` (Day 19).
- **Nonlinear** systems, e.g. `x² + y² = 4` and `eˣ + y = 1`: no direct formula, so solve **iteratively** from a starting guess.

## `fsolve` (Optimization Toolbox; also in GNU Octave)
```matlab
F = @(v) [v(1)^2 + v(2)^2 - 4;  exp(v(1)) + v(2) - 1];
[v, Fval, flag] = fsolve(F, [1; -1]);
```
- F takes one vector of unknowns and returns a vector of equations written as **= 0**.
- `flag > 0` means it converged; check that `Fval` is close to zero.

## Newton-Raphson by hand
For F(x) = 0 with Jacobian matrix J (J(i,j) = ∂Fᵢ/∂xⱼ):

x_new = x - J(x) \ F(x)

repeated until the change is tiny. This is the method behind **load flow** studies in power systems. It converges very fast (quadratically) when the guess is good, and may diverge when it is not.

Without the Optimization Toolbox, `fminsearch(@(v) sum(F(v).^2), v0)` also works for small problems.

## Examples

### Example 1: Solving two nonlinear equations with fsolve  ([`example_1.m`](example_1.m))

```matlab
% Needs: Optimization Toolbox (fsolve is built into GNU Octave)
F = @(v) [v(1)^2 + v(2)^2 - 4;
          exp(v(1)) + v(2) - 1];
[v, Fval, flag] = fsolve(F, [1; -1], optimset('Display', 'off'));
fprintf('Solution x = %.6f, y = %.6f (flag %d, residual %.1e)\n', v, flag, norm(Fval));
[v2, ~] = fsolve(F, [-2; 1], optimset('Display', 'off'));
fprintf('Another solution from another guess: x = %.6f, y = %.6f\n', v2);
th = linspace(0, 2*pi, 200);
plot(2*cos(th), 2*sin(th), 'b'); hold on
x = linspace(-2.5, 1.2, 200); plot(x, 1 - exp(x), 'r')
plot([v(1) v2(1)], [v(2) v2(2)], 'ko', 'MarkerFaceColor', 'k'); hold off
axis equal; grid on; legend('x^2 + y^2 = 4', 'y = 1 - e^x')
```

### Example 2: Newton-Raphson written by hand  ([`example_2.m`](example_2.m))

```matlab
F = @(v) [v(1)^2 + v(2)^2 - 4;  exp(v(1)) + v(2) - 1];
J = @(v) [2*v(1)    2*v(2);
          exp(v(1)) 1     ];
v = [1; -1];
for k = 1:20
    dv = -J(v) \ F(v);
    v = v + dv;
    fprintf('iter %d: x = %.10f, y = %.10f, |step| = %.2e\n', k, v, norm(dv));
    if norm(dv) < 1e-12, break; end
end
```

### Example 3: Operating point of a nonlinear circuit  ([`example_3.m`](example_3.m))

```matlab
% A 5 V source, 1 kohm resistor and a diode in series, with a 2 kohm load across the diode.
% Unknowns: node voltage Vd and diode current Id.
Is = 1e-12; VT = 0.02585;
F = @(u) [ (5 - u(1))/1000 - u(2) - u(1)/2000;      % KCL at the node
           u(2) - Is*(exp(u(1)/VT) - 1) ];          % the diode equation
u = [0.6; 1e-3];
for k = 1:50                                        % Newton with a numerical Jacobian
    Fu = F(u); Jn = zeros(2);
    for j = 1:2
        du = zeros(2, 1); du(j) = 1e-8 * max(1, abs(u(j)));
        Jn(:, j) = (F(u + du) - Fu) / du(j);
    end
    step = -Jn \ Fu;
    u = u + step;
    if norm(step) < 1e-14, break; end
end
fprintf('Vd = %.4f V, Id = %.4f mA after %d iterations\n', u(1), u(2)*1000, k);
```

## Practice

1. Solve `x + y = 3`, `x·y = 2` with `fsolve` from two different guesses.
2. Write Newton's method for one equation and use it to find the cube root of 17.
3. Find where the circle `x² + y² = 9` meets the parabola `y = x² - 3`.
4. What happens to Newton-Raphson when the Jacobian is singular at the guess?

---

[⬅ Day 075](../Day-075-Systems-of-ODEs-and-Higher-Order-ODEs/README.md) · [🏠 Home](../README.md) · [Day 077 ➡](../Day-077-Numerical-Differentiation-and-Finite-Differences/README.md)
