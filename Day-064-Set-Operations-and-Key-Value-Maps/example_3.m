% Day 064 · Set Operations and Key-Value Maps — Counting words with a map and grouping with accumarray
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

text = 'the load on the feeder and the load on the bus';
words = strsplit(text, ' ');
counter = containers.Map();
for k = 1:numel(words)
    w = words{k};
    if isKey(counter, w)
        counter(w) = counter(w) + 1;
    else
        counter(w) = 1;
    end
end
ks = keys(counter);
for k = 1:numel(ks)
    fprintf('%-7s %d\n', ks{k}, counter(ks{k}));
end
% Total energy per day of the week with accumarray
day_of_reading = [1 2 1 3 2 1 3];
energy = [10 12 9 15 11 8 14];
totals = accumarray(day_of_reading', energy')'
