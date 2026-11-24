% Day 047 · The break and continue Commands — break: stop at the first match
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

rng(5);
readings = 220 + 15*rand(1, 50);
for k = 1:numel(readings)
    if readings(k) > 233
        fprintf('First reading above 233 V is #%d (%.2f V)\n', k, readings(k));
        break
    end
end
% A while-true loop with break
n = 1;
while true
    if mod(n, 7) == 0 && mod(n, 11) == 0 && n > 200
        break
    end
    n = n + 1;
end
fprintf('Smallest number above 200 divisible by 7 and 11: %d\n', n);
