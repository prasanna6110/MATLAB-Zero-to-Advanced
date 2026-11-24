# Day 074 · Ordinary Differential Equations: ode45

_Numerical Analysis_

## The problem
An ODE gives the **rate of change**: dy/dt = f(t, y), with an initial value y(t₀) = y₀. MATLAB solves it numerically.

## The steps
1. Write the ODE as **dy/dt = f(t, y)**.
2. Make a function handle: `f = @(t, y) ...` (the inputs must be in the order **t, y**).
3. Choose the time span: `tspan = [t0 tf]` (or a vector of times where you want the answer).
4. Solve: `[t, y] = ode45(f, tspan, y0);`
5. Plot `plot(t, y)`.

## The solvers
| Solver | Type | When |
|--------|------|------|
| `ode45` | Runge-Kutta 4/5, explicit | the first choice for most problems |
| `ode23` | Runge-Kutta 2/3 | low accuracy, fast |
| `ode113` | Adams | smooth problems, high accuracy |
| `ode15s`, `ode23s`, `ode23t`, `ode23tb` | implicit | **stiff** problems (very fast and very slow parts together, e.g. circuits with tiny and large time constants) |

Options: `opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @evfun)`, then `ode45(f, tspan, y0, opts)`.

If ode45 is extremely slow or takes tiny steps, the problem is probably stiff: try `ode15s`.

## Examples

### Example 1: A first-order ODE: an RC circuit  ([`example_1.m`](example_1.m))

```matlab
% dv/dt = (Vs - v) / (R C), v(0) = 0
R = 1e3; C = 470e-6; Vs = 12;
f = @(t, v) (Vs - v) / (R*C);
[t, v] = ode45(f, [0 3], 0);
v_exact = Vs * (1 - exp(-t/(R*C)));
plot(t, v, 'o', t, v_exact, '-'); grid on
xlabel('t (s)'); ylabel('v_C (V)'); legend('ode45', 'exact', 'Location', 'southeast')
fprintf('Max error vs exact solution: %.2e V\n', max(abs(v - v_exact)));
```

### Example 2: A nonlinear ODE: draining a tank  ([`example_2.m`](example_2.m))

```matlab
% dh/dt = -(a/A) sqrt(2 g h)   (Torricelli), h(0) = 2 m
A = 1.5; a = 0.01; g = 9.81;
f = @(t, h) -(a/A) * sqrt(2*g*max(h, 0));
[t, h] = ode45(f, [0 600], 2);
plot(t/60, h, 'LineWidth', 1.5); grid on
xlabel('Time (min)'); ylabel('Water level (m)')
k = find(h < 0.5, 1);
fprintf('The level falls below 0.5 m after %.1f minutes\n', t(k)/60);
```

### Example 3: Answers at chosen times and solver options  ([`example_3.m`](example_3.m))

```matlab
f = @(t, y) -2*y + sin(3*t);
tout = 0:0.5:3;                               % only these times are returned
[t, y] = ode45(f, tout, 1);
disp([t y])
opts = odeset('RelTol', 1e-9, 'AbsTol', 1e-12);
[~, y2] = ode45(f, tout, 1, opts);
fprintf('Difference between default and tight tolerances: %.2e\n', max(abs(y - y2)));
% Population with a varying growth rate, solved with ode23
[t3, p] = ode23(@(t, p) 0.3*(1 + 0.5*sin(t)).*p.*(1 - p/1000), [0 30], 10);
fprintf('Population after 30 days: %.1f (steps used: %d)\n', p(end), numel(t3));
```

## Practice

1. Solve `dy/dt = -0.5y + 3`, y(0) = 0 on [0, 15] and compare with the exact solution.
2. Solve Newton's law of cooling for a cup of tea from 90 °C in a 25 °C room.
3. Solve `dy/dt = y² - t` from y(0) = 0.5 on [0, 2] and plot it.
4. An RL circuit: `L di/dt + R i = V`. Solve for i(t) with R = 5 Ω, L = 0.5 H, V = 10 V.

---

[⬅ Day 073](../Day-073-Numerical-Integration-integral-trapz-and-cumtrapz/README.md) · [🏠 Home](../README.md) · [Day 075 ➡](../Day-075-Systems-of-ODEs-and-Higher-Order-ODEs/README.md)
