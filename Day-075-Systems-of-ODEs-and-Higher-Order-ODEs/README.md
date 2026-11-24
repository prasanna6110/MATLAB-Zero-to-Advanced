# Day 075 · Systems of ODEs and Higher-Order ODEs

_Numerical Analysis_

## Systems
For several coupled equations, `y` is a **column vector** and `f` returns a **column vector** of derivatives:
```matlab
f = @(t, y) [ dy1/dt expression ; dy2/dt expression ];
[t, Y] = ode45(f, tspan, [y1_0; y2_0]);
% Y(:,1) is y1(t), Y(:,2) is y2(t)
```

## Higher-order ODEs: reduce to first order
A second-order equation like **m x'' + c x' + k x = F(t)** becomes two first-order equations with **y1 = x, y2 = x'**:
- y1' = y2
- y2' = (F(t) - c·y2 - k·y1) / m

An n-th order ODE needs n state variables.

## Longer models in a function
For bigger models write the right-hand side in a (local) function:
```matlab
[t, Y] = ode45(@(t, y) model(t, y, p), tspan, y0);
function dy = model(t, y, p)
    dy = zeros(2, 1);
    dy(1) = ...;
    dy(2) = ...;
end
```
Passing a parameter structure `p` keeps the model tidy.

## Stiff systems
If the time constants differ hugely, use `ode15s` (or `ode23s`).

## Examples

### Example 1: A series RLC circuit (second order)  ([`example_1.m`](example_1.m))

```matlab
% L q'' + R q' + q/C = V(t)   with i = q'
R = 10; L = 0.1; C = 100e-6; V = 24;
f = @(t, y) [y(2); (V - R*y(2) - y(1)/C) / L];     % y = [q; i]
[t, Y] = ode45(f, [0 0.1], [0; 0]);
vC = Y(:, 1) / C;
subplot(2, 1, 1); plot(t*1000, Y(:, 2)); ylabel('i (A)'); grid on
subplot(2, 1, 2); plot(t*1000, vC); ylabel('v_C (V)'); xlabel('t (ms)'); grid on
zeta = R/2 * sqrt(C/L);
fprintf('zeta = %.3f, overshoot of vC = %.1f %%\n', zeta, 100*(max(vC) - V)/V);
```

### Example 2: A predator-prey model with a parameter structure  ([`example_2.m`](example_2.m))

```matlab
p = struct('a', 1.0, 'b', 0.1, 'c', 1.5, 'd', 0.075);
[t, Y] = ode45(@(t, y) predator_prey(t, y, p), [0 30], [40; 9]);
subplot(1, 2, 1); plot(t, Y); legend('prey', 'predators'); xlabel('time'); grid on
subplot(1, 2, 2); plot(Y(:, 1), Y(:, 2)); xlabel('prey'); ylabel('predators'); title('Phase plane'); grid on
fprintf('Prey ranges from %.1f to %.1f\n', min(Y(:, 1)), max(Y(:, 1)));

function dy = predator_prey(~, y, p)
    dy = zeros(2, 1);
    dy(1) = p.a*y(1) - p.b*y(1)*y(2);
    dy(2) = -p.c*y(2) + p.d*y(1)*y(2);
end
```

### Example 3: A stiff problem: ode45 vs ode15s  ([`example_3.m`](example_3.m))

```matlab
% A fast mode (rate 1000) and a slow mode (rate 1)
f = @(t, y) [-1000*y(1) + 999*y(2); -y(2)];
tic; [t1, ~] = ode45(f, [0 5], [2; 1]); time45 = toc;
tic; [t2, Y2] = ode15s(f, [0 5], [2; 1]); time15 = toc;
fprintf('ode45 : %5d steps, %.3f s\n', numel(t1), time45);
fprintf('ode15s: %5d steps, %.3f s\n', numel(t2), time15);
fprintf('y(5) = [%.5f %.5f], exact exp(-5) = %.5f\n', Y2(end, :), exp(-5));
```

## Practice

1. Solve the pendulum `θ'' + (g/L) sin θ = 0` for θ(0) = 60°, θ'(0) = 0 and plot θ(t).
2. Simulate a mass-spring-damper with m = 1, c = 0.5, k = 4 and a step force of 1 N.
3. Solve the SIR epidemic model `S' = -βSI, I' = βSI - γI, R' = γI`.
4. Increase R in the RLC example until the response has no overshoot. What is ζ then?

---

[⬅ Day 074](../Day-074-Ordinary-Differential-Equations-ode45/README.md) · [🏠 Home](../README.md) · [Day 076 ➡](../Day-076-Systems-of-Nonlinear-Equations-fsolve-and-Newton-Raphson/README.md)
