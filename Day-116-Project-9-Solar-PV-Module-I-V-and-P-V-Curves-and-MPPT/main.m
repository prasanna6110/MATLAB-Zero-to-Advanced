% Day 116 · Project 9: Solar PV Module: I-V and P-V Curves and MPPT — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
mod = struct('Isc', 8.21, 'Voc', 32.9, 'Ns', 54, 'n', 1.3, 'Rs', 0.22, 'Rsh', 415, 'Ki', 0.0032, 'Kv', -0.123);
cases = [1000 25; 800 25; 500 25; 1000 50];       % [G (W/m^2), T (C)]
V = linspace(0, 34, 300);
fprintf('%8s %6s %8s %8s %8s %8s %6s\n', 'G', 'T', 'Isc', 'Voc', 'Vmp', 'Pmp', 'FF');
for k = 1:size(cases, 1)
    G = cases(k, 1); T = cases(k, 2);
    I = arrayfun(@(v) pv_current(v, G, T, mod), V);
    P = V .* I;
    Voc_k = V(find(I > 0, 1, 'last'));
    [Vmp, negP] = fminbnd(@(v) -v*pv_current(v, G, T, mod), 0, Voc_k);
    Pmp = -negP; Isc_k = pv_current(0, G, T, mod);
    fprintf('%8d %6d %8.2f %8.2f %8.2f %8.1f %6.3f\n', G, T, Isc_k, Voc_k, Vmp, Pmp, Pmp/(Isc_k*Voc_k));
    subplot(2, 2, 1); plot(V, max(I, 0)); hold on
    subplot(2, 2, 2); plot(V, max(P, 0)); hold on; plot(Vmp, Pmp, 'ko')
end
subplot(2, 2, 1); hold off; grid on; xlabel('V'); ylabel('I (A)'); title('I-V curves')
legend('1000 W/m^2 25C', '800, 25C', '500, 25C', '1000, 50C', 'Location', 'southwest')
subplot(2, 2, 2); hold off; grid on; xlabel('V'); ylabel('P (W)'); title('P-V curves')
% ---- P&O MPPT over a day ----
hours = 6:0.1:18;
Gday = max(0, 1000*sin(pi*(hours - 6)/12)) .* (1 - 0.3*(hours > 12.5 & hours < 13.5));   % a passing cloud
Tday = 25 + 20*sin(pi*(hours - 6)/12);
v = 20; dv = 0.4; p_prev = 0;
P_track = zeros(size(hours)); P_best = zeros(size(hours));
for k = 1:numel(hours)
    if Gday(k) < 5, continue; end
    p = v * pv_current(v, Gday(k), Tday(k), mod);
    if p < p_prev, dv = -dv; end            % power fell: reverse the direction
    p_prev = p;
    v = min(max(v + dv, 1), 33);
    P_track(k) = p;
    [~, negP] = fminbnd(@(x) -x*pv_current(x, Gday(k), Tday(k), mod), 0, 33);
    P_best(k) = -negP;
end
E_track = trapz(hours, P_track); E_best = trapz(hours, P_best);
fprintf('\nDaily energy: available %.1f Wh, tracked by P&O %.1f Wh, efficiency %.2f %%\n', E_best, E_track, 100*E_track/E_best);
subplot(2, 1, 2); plot(hours, P_best, 'k', hours, P_track, 'r--'); grid on
xlabel('Hour'); ylabel('P (W)'); legend('maximum possible', 'P&O tracked'); title('MPPT during one day')

function I = pv_current(V, G, T, m)
    q = 1.602e-19; k = 1.381e-23; Tk = T + 273.15; Vt = k*Tk/q;
    Iph = (m.Isc + m.Ki*(T - 25)) * G/1000;
    Voc_T = m.Voc + m.Kv*(T - 25);
    I0 = (m.Isc + m.Ki*(T - 25)) / (exp(Voc_T/(m.n*m.Ns*Vt)) - 1);
    f = @(I) Iph - I0*(exp((V + I*m.Rs)/(m.n*m.Ns*Vt)) - 1) - (V + I*m.Rs)/m.Rsh - I;
    I = fzero(f, [-2*m.Isc, 2*m.Isc]);
end
