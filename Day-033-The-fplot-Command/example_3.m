% Day 033 · The fplot Command — Capacitor charging for different time constants
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

V = 12;
hold on
for tau = [0.5 1 2]
    fplot(@(t) V * (1 - exp(-t/tau)), [0 8], 'LineWidth', 1.5)
end
hold off
legend('\tau = 0.5 s', '\tau = 1 s', '\tau = 2 s', 'Location', 'southeast')
xlabel('Time (s)'); ylabel('Capacitor voltage (V)')
title('RC charging')
grid on
