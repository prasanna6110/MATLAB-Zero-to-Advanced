% Day 047 · The break and continue Commands — continue: skip bad data
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

data = [12 -1 15 NaN 18 999 14 -1 16];
total = 0; used = 0;
for k = 1:numel(data)
    x = data(k);
    if isnan(x) || x < 0 || x > 100
        fprintf('skipping sample %d (%g)\n', k, x);
        continue
    end
    total = total + x;
    used = used + 1;
end
fprintf('Average of %d good samples = %.2f\n', used, total / used);
