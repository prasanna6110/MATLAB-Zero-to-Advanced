% Day 044 · for Loops — Summing a series
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% sum of 1/k^2 for k = 1..n approaches pi^2/6
for n = [10 100 1000 10000]
    s = 0;
    for k = 1:n
        s = s + 1/k^2;
    end
    fprintf('n = %5d: sum = %.6f   pi^2/6 = %.6f\n', n, s, pi^2/6);
end
