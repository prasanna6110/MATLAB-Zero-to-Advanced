% Day 023 · Generation of Random Numbers — Uniform, integer and normal random numbers
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

rng(1);                              % reproducible
u = rand(1, 5)
in_range = 10 + (20 - 10) * rand(1, 5)   % between 10 and 20
dice = randi(6, 1, 10)
temps = randi([20 35], 1, 7)
noise = 0.5 * randn(1, 5)
heights = 170 + 8 * randn(1, 1000);
fprintf('Mean %.1f cm, std %.1f cm\n', mean(heights), std(heights));
