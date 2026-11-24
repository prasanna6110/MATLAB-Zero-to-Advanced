% Day 017 · Addition, Subtraction and Operations with Scalars — Daily energy readings
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Meter readings (kWh) at the start of 5 days for 3 houses (rows)
start = [1200 1250 1305 1361 1410
          800  842  880  925  970
         2200 2290 2375 2460 2550];
daily_use = diff(start, 1, 2)          % differences along columns -> daily use
extra_vs_house1 = daily_use - daily_use(1, :)
total_per_house = sum(daily_use, 2)'
