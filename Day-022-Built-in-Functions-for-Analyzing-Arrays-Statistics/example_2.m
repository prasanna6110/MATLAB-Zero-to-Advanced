% Day 022 · Built-in Functions for Analyzing Arrays (Statistics) — Row-wise and column-wise analysis
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Rows = 4 feeders, columns = 6 hours of current (A)
I = [120 135 150 160 140 125
      80  85  90 110 105  95
     200 210 230 260 240 220
      60  62  64  70  66  61];
peak_per_feeder = max(I, [], 2)'
avg_per_hour = mean(I)
load_factor = mean(I, 2)' ./ peak_per_feeder
total_hourly = sum(I)
[~, busiest_hour] = max(total_hourly)
