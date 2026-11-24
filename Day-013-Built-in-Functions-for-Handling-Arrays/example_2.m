% Day 013 · Built-in Functions for Handling Arrays — max, min, sort and find
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

temps = [31 35 29 38 33 36 30];
[t_max, day_max] = max(temps)
[t_min, day_min] = min(temps)
[sorted, order] = sort(temps, 'descend')
hot_days = find(temps > 34)
fprintf('%d hot days\n', numel(hot_days));
unique([3 1 3 2 1 3])
cumsum([5 10 15])                   % running total
diff([100 104 103 110])             % day-to-day change
