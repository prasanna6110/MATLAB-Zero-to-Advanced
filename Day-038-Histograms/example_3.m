% Day 038 · Histograms — The modern histogram object
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% MATLAB-ONLY: histogram/histcounts objects (R2014b+)
rng(12);
data = [randn(1, 500) - 2, randn(1, 500) + 3];   % a bimodal distribution
h = histogram(data, 30, 'Normalization', 'probability');
title('A bimodal distribution')
fprintf('Number of bins %d, largest bar %.3f\n', h.NumBins, max(h.Values));
[N, edges] = histcounts(data, -6:1:7);
disp(N)
