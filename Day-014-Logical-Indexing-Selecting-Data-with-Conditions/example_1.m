% Day 014 · Logical Indexing: Selecting Data with Conditions — Selecting with conditions
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

v = [12 -3 45 7 -8 20 0 33];
mask = v > 10                  % logical array
big = v(mask)                  % 12 45 20 33
negatives = v(v < 0)
count_positive = nnz(v > 0)
v(v < 0) = 0                   % clip the negatives to zero
