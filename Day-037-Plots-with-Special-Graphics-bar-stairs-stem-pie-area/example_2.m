% Day 037 · Plots with Special Graphics: bar, stairs, stem, pie, area — stairs and stem for discrete signals
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

hours = 0:24;
tariff = [4*ones(1, 6) 6*ones(1, 4) 5*ones(1, 7) 8*ones(1, 5) 4*ones(1, 3)];
subplot(2, 1, 1)
stairs(hours, tariff, 'LineWidth', 1.5)
ylim([0 9]); xlabel('Hour'); ylabel('Rs / kWh'); title('Time-of-day tariff')
n = 0:20;
x = 0.85.^n .* cos(0.6*n);
subplot(2, 1, 2)
stem(n, x, 'filled')
xlabel('n'); ylabel('x[n]'); title('A decaying discrete-time signal')
