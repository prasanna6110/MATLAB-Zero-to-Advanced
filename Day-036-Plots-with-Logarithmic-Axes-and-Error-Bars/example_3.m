% Day 036 · Plots with Logarithmic Axes and Error Bars — Error bars from repeated measurements
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

rng(4);
speed = 500:250:1500;                      % rpm
runs = 1.2*speed/100 + randn(5, numel(speed));   % 5 repeated torque tests
avg = mean(runs);
sd = std(runs);
errorbar(speed, avg, sd, 'o-')
xlabel('Speed (rpm)'); ylabel('Torque (N m)')
title('Mean \pm 1 std of 5 tests')
grid on
xlim([400 1600])
