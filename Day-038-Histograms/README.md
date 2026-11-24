# Day 038 · Histograms

_Two-Dimensional Plots_

## `histogram` (modern) and `hist` (classic)
A histogram counts how many values fall in each **bin** (interval).

```matlab
histogram(x)               % automatic bins
histogram(x, 20)           % 20 bins
histogram(x, edges)        % bins given by an edges vector, e.g. 0:10:100
histogram(x, 'Normalization', 'probability')   % fractions instead of counts
h = histogram(x); h.Values, h.BinEdges          % the counts and edges
```
Classic (works everywhere, also in Octave): `hist(x, nbins)` draws; `[n, centers] = hist(x, nbins)` returns the counts. Counts only (no plot): `histcounts(x, edges)` in MATLAB, `histc(x, edges)` in older versions.

## Reading a histogram
- the **shape**: symmetric (normal), skewed, bimodal
- the **centre** and **spread**
- **outliers**: isolated bars far from the rest

## Examples

### Example 1: A histogram of exam marks  ([`example_1.m`](example_1.m))

```matlab
rng(10);
marks = round(min(100, max(0, 62 + 14*randn(1, 200))));
hist(marks, 10)
xlabel('Marks'); ylabel('Number of students')
title('Distribution of 200 marks')
[counts, centers] = hist(marks, 10);
disp([round(centers); counts])
```

### Example 2: Choosing the bins  ([`example_2.m`](example_2.m))

```matlab
rng(11);
v = 230 + 3*randn(1, 1000);              % supply voltage samples
edges = 220:2:240;
counts = histc(v, edges);
bar(edges(1:end-1) + 1, counts(1:end-1), 1)   % bars centred in each bin (the last count is 'exactly 240')
xlabel('Voltage (V)'); ylabel('Count')
title('Voltage samples in 2 V bins')
outside = sum(v < 224 | v > 236);
fprintf('%d of 1000 samples are outside 230 +/- 6 V\n', outside);
```

### Example 3: The modern histogram object  ([`example_3.m`](example_3.m))

```matlab
% MATLAB-ONLY: histogram/histcounts objects (R2014b+)
rng(12);
data = [randn(1, 500) - 2, randn(1, 500) + 3];   % a bimodal distribution
h = histogram(data, 30, 'Normalization', 'probability');
title('A bimodal distribution')
fprintf('Number of bins %d, largest bar %.3f\n', h.NumBins, max(h.Values));
[N, edges] = histcounts(data, -6:1:7);
disp(N)
```

## Practice

1. Generate 1000 normal random numbers and draw histograms with 10, 30 and 100 bins. Which looks best?
2. Count the marks in the ranges 0–39, 40–59, 60–79, 80–100.
3. Draw the histogram of the sum of two dice over 5000 rolls. What shape appears?
4. Compare the histogram of `rand` and of `randn` samples.

---

[⬅ Day 037](../Day-037-Plots-with-Special-Graphics-bar-stairs-stem-pie-area/README.md) · [🏠 Home](../README.md) · [Day 039 ➡](../Day-039-Polar-Plots/README.md)
