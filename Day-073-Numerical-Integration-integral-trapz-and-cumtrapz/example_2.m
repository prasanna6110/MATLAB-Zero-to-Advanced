% Day 073 · Numerical Integration: integral, trapz and cumtrapz — Energy from measured power data
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

hours = 0:24;
P_kW = [18 16 15 15 16 20 28 40 52 58 60 61 62 60 58 57 59 66 75 70 55 40 30 22 18];
E = trapz(hours, P_kW);
fprintf('Energy in the day: %.1f kWh, average load %.1f kW\n', E, E/24);
E_running = cumtrapz(hours, P_kW);
plot(hours, E_running, 'LineWidth', 1.5); grid on
xlabel('Hour'); ylabel('Cumulative energy (kWh)')
h_half = interp1(E_running, hours, E/2);
fprintf('Half of the energy was used by hour %.1f\n', h_half);
