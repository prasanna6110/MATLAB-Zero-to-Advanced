# Day 121 · Project 14: DC Motor Speed Control with a PI Controller

_Projects_

## Goal
Model a separately excited **DC motor**, design a **PI speed controller**, and simulate start-up, a sudden **load torque** and a **speed reference change**, with a voltage limit and **anti-windup**. Compare open-loop and closed-loop speed regulation.

## Model
- Electrical: L di/dt = u - R i - Kb ω
- Mechanical: J dω/dt = Kt i - B ω - T_L
- PI controller: u = Kp e + Ki ∫e dt, e = ω_ref - ω, limited to ±V_max. With anti-windup, the integrator stops growing while the output is saturated.

## Concepts used
A fixed-step simulation loop (as a digital controller would run), structures for parameters, saturation, piecewise inputs, performance measures, subplots.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
m = struct('R', 2.0, 'L', 0.02, 'Kb', 0.5, 'Kt', 0.5, 'J', 0.02, 'B', 0.002);
Vmax = 240;
dt = 1e-4; t = 0:dt:3;
w_ref = 150*(t >= 0) + 50*(t >= 2);            % rad/s: 150, then 200 at t = 2 s
TL = 4*(t >= 1);                               % 4 N m load applied at t = 1 s
Kp = 2.0; Ki = 20;
res = struct();
for mode = 1:3                                  % 1 open loop, 2 PI without anti-windup, 3 PI with anti-windup
    i = 0; w = 0; integ = 0;
    W = zeros(size(t)); U = W; I = W;
    for k = 1:numel(t)
        e = w_ref(k) - w;
        if mode == 1
            u = w_ref(k) * (m.Kb + m.R*m.B/m.Kt);          % steady-state voltage for no load
        else
            u_unsat = Kp*e + Ki*integ;
            u = min(max(u_unsat, -Vmax), Vmax);
            if mode == 2 || u == u_unsat
                integ = integ + e*dt;                       % anti-windup: freeze while saturated
            end
        end
        di = (u - m.R*i - m.Kb*w) / m.L;
        dw = (m.Kt*i - m.B*w - TL(k)) / m.J;
        i = i + di*dt;  w = w + dw*dt;
        W(k) = w; U(k) = u; I(k) = i;
    end
    res(mode).W = W; res(mode).U = U; res(mode).I = I;
end
names = {'open loop', 'PI (no anti-windup)', 'PI + anti-windup'};
for mode = 1:3
    W = res(mode).W;
    drop = 150 - min(W(t > 1 & t < 1.5));
    err_end = w_ref(end) - W(end);
    os = max(W(t < 1)) - 150;
    fprintf('%-20s overshoot %6.2f rad/s | speed drop with load %6.2f rad/s | final error %6.2f rad/s\n', names{mode}, max(os, 0), drop, err_end);
end
subplot(3, 1, 1); plot(t, w_ref, 'k--', t, res(1).W, t, res(2).W, t, res(3).W); ylabel('\omega (rad/s)'); grid on
legend(['reference', names], 'Location', 'southeast'); title('DC motor speed control')
subplot(3, 1, 2); plot(t, res(3).U); ylabel('u (V)'); grid on
subplot(3, 1, 3); plot(t, res(3).I); ylabel('i (A)'); xlabel('t (s)'); grid on
```

## Extend this project

- Add an inner current loop (cascade control) with its own PI controller.
- Tune Kp and Ki with `fminsearch` to minimise the integral of the squared error.
- Add measurement noise to ω and a low-pass filter before the controller.
- Convert the controller into a discrete-time version with a 1 ms sample time.

---

[⬅ Day 120](../Day-120-Project-13-Transmission-Line-Performance-Calculator/README.md) · [🏠 Home](../README.md) · [Day 122 ➡](../Day-122-Project-15-Signal-Analyzer-and-Noise-Remover/README.md)
