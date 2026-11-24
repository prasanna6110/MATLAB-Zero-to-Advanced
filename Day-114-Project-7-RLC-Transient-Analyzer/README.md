# Day 114 · Project 7: RLC Transient Analyzer

_Projects_

## Goal
For a series RLC circuit switched onto a DC source, find the **damping type** (over-, critically or under-damped), derive the **closed-form** capacitor voltage and current, verify it with **ode45**, and measure rise time, peak time, overshoot and settling time for several resistances.

## Theory
L q'' + R q' + q/C = V. With α = R/(2L) and ω₀ = 1/√(LC):
- α > ω₀ overdamped: s₁,₂ = -α ± √(α² - ω₀²)
- α = ω₀ critically damped: v_C = V[1 - (1 + αt)e^(-αt)]
- α < ω₀ underdamped: ω_d = √(ω₀² - α²), v_C = V[1 - e^(-αt)(cos ω_d t + (α/ω_d) sin ω_d t)]

## Concepts used
`if-elseif`, functions returning function handles, `ode45`, interpolation for timing measures, subplots, a summary table.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
V = 12; L = 0.5; C = 200e-6;
w0 = 1/sqrt(L*C);
R_crit = 2*sqrt(L/C);
fprintf('w0 = %.2f rad/s, critical resistance = %.2f ohm\n\n', w0, R_crit);
R_list = [10 40 R_crit 200];
t = linspace(0, 0.25, 3000);
fprintf('%9s %-18s %9s %9s %9s %10s %9s\n', 'R (ohm)', 'Type', 'alpha', 'tr (ms)', 'tp (ms)', 'OS (%)', 'ts (ms)');
colors = lines(numel(R_list));
for k = 1:numel(R_list)
    R = R_list(k);
    [vc_fun, type, alpha] = rlc_step(V, R, L, C);
    vc = vc_fun(t);
    [tt, Y] = ode45(@(tt, y) [y(2); (V - R*y(2) - y(1)/C)/L], [0 0.25], [0; 0], odeset('RelTol', 1e-8, 'AbsTol', 1e-10));
    err = max(abs(Y(:, 1)/C - vc_fun(tt')'));
    m = step_metrics(t, vc, V);
    fprintf('%9.2f %-18s %9.2f %9.2f %9.2f %10.2f %9.2f   (ode45 diff %.1e V)\n', R, type, alpha, 1000*m.tr, 1000*m.tp, m.os, 1000*m.ts, err);
    subplot(2, 1, 1); plot(t*1000, vc, 'Color', colors(k, :), 'LineWidth', 1.4); hold on
    i = C * gradient(vc, t);
    subplot(2, 1, 2); plot(t*1000, i, 'Color', colors(k, :), 'LineWidth', 1.4); hold on
end
subplot(2, 1, 1); hold off; grid on; ylabel('v_C (V)'); title('Series RLC step response')
legend(arrayfun(@(r) sprintf('R = %.1f \\Omega', r), R_list, 'UniformOutput', false), 'Location', 'southeast')
subplot(2, 1, 2); hold off; grid on; ylabel('i (A)'); xlabel('t (ms)')

function [vc, type, alpha] = rlc_step(V, R, L, C)
    alpha = R/(2*L);  w0 = 1/sqrt(L*C);
    if abs(alpha - w0) < 1e-9*w0
        type = 'critically damped';
        vc = @(t) V*(1 - (1 + alpha*t).*exp(-alpha*t));
    elseif alpha > w0
        type = 'overdamped';
        s1 = -alpha + sqrt(alpha^2 - w0^2);  s2 = -alpha - sqrt(alpha^2 - w0^2);
        vc = @(t) V*(1 + (s2*exp(s1*t) - s1*exp(s2*t))/(s1 - s2));
    else
        type = 'underdamped';
        wd = sqrt(w0^2 - alpha^2);
        vc = @(t) V*(1 - exp(-alpha*t).*(cos(wd*t) + alpha/wd*sin(wd*t)));
    end
end

function m = step_metrics(t, y, final)
    m.tr = interp_time(t, y, 0.9*final) - interp_time(t, y, 0.1*final);
    [pk, kp] = max(y);
    m.os = max(0, 100*(pk - final)/final);
    if m.os > 0.01, m.tp = t(kp); else, m.tp = NaN; end
    outside = find(abs(y - final) > 0.02*final, 1, 'last');
    m.ts = t(min(outside + 1, numel(t)));
end

function tc = interp_time(t, y, level)
    k = find(y >= level, 1);
    if isempty(k) || k == 1, tc = NaN; return; end
    tc = t(k-1) + (level - y(k-1)) * (t(k) - t(k-1)) / (y(k) - y(k-1));
end
```

## Extend this project

- Add a parallel RLC circuit driven by a current source.
- Allow non-zero initial capacitor voltage and inductor current.
- Find (with `fzero`) the R that gives exactly 5% overshoot.
- Replace the DC source by a sine and plot the steady-state amplitude against frequency (resonance curve).

---

[⬅ Day 113](../Day-113-Project-6-AC-Circuit-Analyzer-and-Power-Factor-Correction/README.md) · [🏠 Home](../README.md) · [Day 115 ➡](../Day-115-Project-8-Three-Phase-System-Analyzer/README.md)
