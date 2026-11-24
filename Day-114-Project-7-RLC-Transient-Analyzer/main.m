% Day 114 · Project 7: RLC Transient Analyzer — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

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
