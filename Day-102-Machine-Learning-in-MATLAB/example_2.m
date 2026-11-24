% Day 102 · Machine Learning in MATLAB — k-nearest neighbours classifier from scratch
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

rng(2);
% Two classes of motor condition from (vibration, temperature)
healthy = [2 + 0.6*randn(60, 1), 55 + 4*randn(60, 1)];
faulty  = [4 + 0.8*randn(60, 1), 68 + 5*randn(60, 1)];
X = [healthy; faulty];  y = [zeros(60, 1); ones(60, 1)];
idx = randperm(120);  train = idx(1:90);  test = idx(91:end);
mu = mean(X(train, :)); sd = std(X(train, :));
Z = (X - mu) ./ sd;                                 % scale with the training statistics
k = 5;
pred = zeros(numel(test), 1);
for i = 1:numel(test)
    d = sqrt(sum((Z(train, :) - Z(test(i), :)).^2, 2));
    [~, order] = sort(d);
    pred(i) = mode(y(train(order(1:k))));
end
acc = mean(pred == y(test));
C = [sum(pred == 0 & y(test) == 0), sum(pred == 1 & y(test) == 0);
     sum(pred == 0 & y(test) == 1), sum(pred == 1 & y(test) == 1)];
fprintf('k-NN accuracy on %d test motors: %.1f %%\n', numel(test), 100*acc);
disp('Confusion matrix (rows = true healthy/faulty, columns = predicted):'); disp(C)
