% Day 048 · Preallocation, Vectorisation and Timing Code — A vectorised simulation of many trials
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

rng(8);
% 100000 people each pick a random birthday: how often do 23 people share one?
trials = 20000;
days = randi(365, 23, trials);
sorted = sort(days);
shared = any(diff(sorted) == 0);         % any equal neighbours in each column
fprintf('Probability that 2 of 23 people share a birthday: %.3f\n', mean(shared));
