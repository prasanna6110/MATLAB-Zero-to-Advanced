% Day 044 · for Loops — A recurrence: cooling of a transformer
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

T_amb = 30;  T = 95;  k = 0.08;           % Newton-style cooling, 1 step = 1 minute
minutes = 40;
temps = zeros(1, minutes + 1);
temps(1) = T;
for m = 1:minutes
    temps(m + 1) = temps(m) - k * (temps(m) - T_amb);
end
fprintf('After %d minutes: %.1f C\n', minutes, temps(end));
plot(0:minutes, temps, 'r.-'); xlabel('Minute'); ylabel('Temperature (C)'); grid on
idx = find(temps < 50, 1);
fprintf('Below 50 C after %d minutes\n', idx - 1);
