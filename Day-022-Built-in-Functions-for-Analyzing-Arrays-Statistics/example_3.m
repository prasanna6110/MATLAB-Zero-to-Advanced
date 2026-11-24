% Day 022 · Built-in Functions for Analyzing Arrays (Statistics) — Correlation and moving average
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

temperature = [28 30 33 35 36 38 37 34 31 29];
demand_MW   = [410 425 460 495 505 540 530 480 445 420];
R = corrcoef(temperature, demand_MW);
fprintf('Correlation between temperature and demand: %.3f\n', R(1, 2));
smooth = movmean(demand_MW, 3);
disp([demand_MW; round(smooth)])
counts = histc(temperature, [25 30 35 40])   % how many in 25-30, 30-35, 35-40, and exactly 40
