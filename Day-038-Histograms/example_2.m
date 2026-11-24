% Day 038 · Histograms — Choosing the bins
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

rng(11);
v = 230 + 3*randn(1, 1000);              % supply voltage samples
edges = 220:2:240;
counts = histc(v, edges);
bar(edges(1:end-1) + 1, counts(1:end-1), 1)   % bars centred in each bin (the last count is 'exactly 240')
xlabel('Voltage (V)'); ylabel('Count')
title('Voltage samples in 2 V bins')
outside = sum(v < 224 | v > 236);
fprintf('%d of 1000 samples are outside 230 +/- 6 V\n', outside);
