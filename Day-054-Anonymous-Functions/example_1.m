% Day 054 · Anonymous Functions — One-line functions
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

sq = @(x) x.^2;
sq(5)
sq([1 2 3])
hyp = @(a, b) sqrt(a.^2 + b.^2);
hyp(3, 4)
f = @(x) exp(-x) .* sin(2*x);
x = linspace(0, 5, 6);
disp([x; f(x)])
rand_dice = @() randi(6);          % no inputs
rng(1); rand_dice()
