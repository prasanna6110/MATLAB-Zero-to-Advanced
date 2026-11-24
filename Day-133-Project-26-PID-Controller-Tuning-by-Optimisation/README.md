# Day 133 · Project 26: PID Controller Tuning by Optimisation

_Projects_

## Goal
Tune a PID controller for a third-order process in three ways and compare them:
1. **Ziegler-Nichols** (ultimate gain method),
2. **optimisation** with `fminsearch` minimising the **ITAE** criterion (∫ t·|e(t)| dt),
3. a hand-tuned "conservative" setting.
Compare overshoot, settling time, ITAE and the control effort, and test robustness when the plant gain changes by ±30%.

## Concepts used
A reusable simulation function with a filtered derivative, cost functions, `fminsearch` with a log-parameterisation (keeps gains positive), performance metrics, robustness loops.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
plant = struct('K', 1, 'den', conv(conv([1 1], [0.5 1]), [0.2 1]));   % 1/((s+1)(0.5s+1)(0.2s+1))
T = 12; dt = 2e-3;
% 1) Ziegler-Nichols: ultimate gain and period from the characteristic equation
d = plant.den;                                % 0.1 s^3 + 0.8 s^2 + 1.7 s + 1
wu = sqrt(d(3)/d(1)); Ku = (d(2)*wu^2 - d(4))/plant.K; Pu = 2*pi/wu;
zn = [0.6*Ku, 0.6*Ku/(Pu/2), 0.6*Ku*Pu/8];
% 2) optimisation of ITAE
cost = @(g) itae(simulate(exp(g), plant, T, dt));
g_opt = exp(fminsearch(cost, log(zn), optimset('MaxIter', 300, 'TolX', 1e-4)));
% 3) conservative hand tuning
hand = [1.5 1.0 0.3];
sets = {'Ziegler-Nichols', zn; 'ITAE optimised', g_opt; 'Conservative', hand};
fprintf('Ultimate gain Ku = %.2f, period Pu = %.3f s\n\n', Ku, Pu);
fprintf('%-16s %6s %6s %6s %8s %8s %8s %8s\n', 'Tuning', 'Kp', 'Ki', 'Kd', 'OS %', 'ts (s)', 'ITAE', 'max |u|');
for s = 1:3
    r = simulate(sets{s, 2}, plant, T, dt);
    fprintf('%-16s %6.2f %6.2f %6.2f %8.1f %8.2f %8.3f %8.2f\n', sets{s, 1}, sets{s, 2}, r.os, r.ts, itae(r), max(abs(r.u)));
    subplot(2, 1, 1); plot(r.t, r.y, 'LineWidth', 1.3); hold on
end
subplot(2, 1, 1); hold off; grid on; legend(sets(:, 1)); ylabel('y'); title('Step responses')
fprintf('\nRobustness (overshoot %% when the plant gain changes):\n');
gains = [0.7 1.0 1.3];
for s = 1:3
    os = zeros(size(gains));
    for k = 1:numel(gains)
        p2 = plant; p2.K = gains(k);
        os(k) = simulate(sets{s, 2}, p2, T, dt).os;
    end
    fprintf('  %-16s K x0.7: %5.1f   K x1.0: %5.1f   K x1.3: %5.1f\n', sets{s, 1}, os);
end
r = simulate(g_opt, plant, T, dt);
subplot(2, 1, 2); plot(r.t, r.u); grid on; ylabel('u'); xlabel('t (s)'); title('Control signal (ITAE tuning)')

function r = simulate(g, plant, T, dt)
    [A, B, C] = tf2ss_local(plant.K, plant.den);
    x = zeros(size(A, 1), 1); integ = 0; dfilt = 0; e_prev = 1; N = 20;
    t = 0:dt:T; y = zeros(size(t)); u = y;
    for k = 1:numel(t)
        y(k) = C*x;  e = 1 - y(k);
        integ = integ + e*dt;
        dfilt = dfilt + dt*N*((e - e_prev)/dt - dfilt);     % filtered derivative
        if k == 1, dfilt = 0; end
        e_prev = e;
        u(k) = g(1)*e + g(2)*integ + g(3)*dfilt;
        x = x + dt*(A*x + B*u(k));
    end
    r.t = t; r.y = y; r.u = u; r.e = 1 - y;
    r.os = max(0, 100*(max(y) - 1));
    k = find(abs(y - 1) > 0.02, 1, 'last'); r.ts = t(min(k + 1, numel(t)));
end

function J = itae(r)
    J = trapz(r.t, r.t .* abs(r.e));
end

function [A, B, C] = tf2ss_local(K, den)
% State-space (controllable canonical form) of K / den(s)
    K = K / den(1);  den = den / den(1);  n = numel(den) - 1;
    A = [zeros(n - 1, 1) eye(n - 1); -fliplr(den(2:end))];
    B = [zeros(n - 1, 1); 1];
    C = [K zeros(1, n - 1)];
end
```

## Extend this project

- Minimise ISE (∫e²) or IAE (∫|e|) instead of ITAE and compare the gains.
- Add a penalty on the control effort to the cost function.
- Add a 0.2 s time delay to the plant and retune.
- (MATLAB) Compare with `pidtune(tf(1, plant.den), 'PID')`.

---

[⬅ Day 132](../Day-132-Project-25-Library-Management-System-with-Object-Oriented-Programming/README.md) · [🏠 Home](../README.md) · [Day 134 ➡](../Day-134-Project-27-Battery-State-of-Charge-Estimation-with-a-Kalman-Filter/README.md)
